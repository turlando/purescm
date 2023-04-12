module PureScript.Backend.Chez.Runtime (runtimeModule) where

import Prelude

import Control.Monad.State (runState)
import Control.Monad.State.Class (class MonadState, modify_)
import Data.Array as Array
import Data.Array.NonEmpty as NEA
import Data.Array.NonEmpty.Internal (NonEmptyArray(..))
import Data.Maybe (Maybe(..))
import Data.Traversable (sequence)
import Data.Tuple (Tuple(..))
import PureScript.Backend.Chez.Constants (libChezSchemePrefix, scmPrefixed)
import PureScript.Backend.Chez.Syntax (ChezDefinition(..), ChezExport(..), ChezExpr, ChezImport(..), ChezImportSet(..), ChezLibrary)
import PureScript.Backend.Chez.Syntax as S
import PureScript.Backend.Chez.Syntax.Common as C

makeExportedFunction
  :: forall m
   . Monad m
  => MonadState (Array ChezExport) m
  => String
  -> NonEmptyArray String
  -> ChezExpr
  -> m ChezDefinition
makeExportedFunction name args expr = do
  modify_ $ Array.cons $ ExportIdentifier name
  pure $ Define name $ C.mkCurriedFn args expr

makeBooleanComparison
  :: forall m. Monad m => MonadState (Array ChezExport) m => String -> m ChezDefinition
makeBooleanComparison suffix =
  makeExportedFunction ("boolean" <> suffix) (NonEmptyArray [ "x", "y" ]) $
    S.List
      [ S.Identifier $ scmPrefixed "fx" <> suffix
      , S.List [ S.Identifier "boolean->integer", S.Identifier "x" ]
      , S.List [ S.Identifier "boolean->integer", S.Identifier "y" ]
      ]

runtimeModule :: ChezLibrary
runtimeModule = do
  let
    Tuple definitions exports = flip runState [] $ sequence
      [ pure $ S.Define "boolean->integer" $ C.mkCurriedFn (pure "x") $ S.List
          [ S.Identifier $ scmPrefixed "if"
          , S.Identifier "x"
          , S.Integer $ S.ChezDigit "1"
          , S.Integer $ S.ChezDigit "0"
          ]
      , makeBooleanComparison ">?"
      , makeBooleanComparison ">=?"
      , makeBooleanComparison "<=?"
      , makeBooleanComparison "<?"
      ]
  { "#!chezscheme": true
  , "#!r6rs": true
  , name:
      { identifiers: NEA.cons' "_Chez_Runtime" [ "lib" ]
      , version: []
      }
  , exports
  , imports:
      [ ImportSet $ ImportPrefix
          (ImportLibrary { identifiers: NEA.singleton "chezscheme", version: Nothing })
          libChezSchemePrefix
      ]
  , body:
      { definitions
      , expressions: []
      }
  }
