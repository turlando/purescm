module Main where

import System.Environment (getArgs)
import Options (Options(..))
import Build (build)
import Language.PureScript.Scheme.IOUtil (print', tshow)

import qualified System.IO as IO
import qualified Options as Options

main :: IO ()
main = do
  IO.hSetEncoding IO.stdout IO.utf8
  IO.hSetEncoding IO.stderr IO.utf8
  IO.hSetBuffering IO.stdout IO.LineBuffering
  IO.hSetBuffering IO.stderr IO.LineBuffering

  Options { optionOutput, optionRunModule } <- Options.runParser =<< getArgs
  print' $ "Options: " <> optionOutput
  print' $ "    output: " <> optionOutput
  print' $ "    runModule: " <> tshow optionRunModule
  print' ""

  build optionOutput
