module Language.PureScript.Scheme.CodeGen.Transpiler where

import Language.PureScript.CoreFn.Module      (Module(..))
import Language.PureScript.CoreFn.Ann         (Ann)
import Language.PureScript.CoreFn.Expr        (Expr(..), Bind(..))
import Language.PureScript.Names              (runIdent)
import Language.PureScript.AST.Literals       (Literal(..))
import Language.PureScript.Scheme.CodeGen.AST (AST(..))


moduleToScheme :: Module Ann -> [AST]
moduleToScheme (Module _sourceSpan _comments _name _path
                       _imports _exports _reExports _foreigns declarations) =
  fmap bindToScheme declarations


bindToScheme :: Bind Ann -> AST
bindToScheme (NonRec _ann ident expr) =
  Define (runIdent ident) (exprToScheme expr)
bindToScheme _ = error "Not implemented"


exprToScheme :: Expr Ann -> AST
exprToScheme (Literal _ann literal) = literalToScheme literal
exprToScheme _ = error "Not implemented"


literalToScheme :: Literal (Expr Ann) -> AST
literalToScheme (NumericLiteral (Left integer)) = IntegerLiteral integer
literalToScheme (ArrayLiteral xs) = VectorLiteral $ fmap exprToScheme xs
literalToScheme _ = error "Not implemented"
