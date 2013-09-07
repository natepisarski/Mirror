--Mirror is a program for responding to input (well, aren't all programs?)
--Syntax of a mirror file is:
--inp1|inp2_output1
--Soon, mirror will handle multiple outputs per inputs.
import System.IO
import System.Environment
import System.Process

import Cookbook.Ingredients.Tupples.Look
import Cookbook.Ingredients.Lists.Modify
import Cookbook.Ingredients.Lists.Access
import Cookbook.Common
import Cookbook.Continuous
import Cookbook.IO

--"Under Construction"
--import Cookbook.Recipes.Configuration
import Cookbook.Recipes.Configuration --Copy of Cookbook.Recipes.Configuration

readMirrorList :: String -> [(String,String)]
readMirrorList x | (length x) < 2 = []
readMirrorList x
  | '|' `elem` x = let inputs = (before x '_') in zip (splitOn inputs '|') (repeat (after x '_'))
  | otherwise = let (a:b:_) = splitOn x '_' in [(a,b)]

flt :: [[a]] -> [a]
flt [] = []
flt (x:xs) = x ++ flt xs

main = do
  (config:_) <- getArgs
  c <- filelines config
  x <- filelines (conf c "file")
  repl (flt (map readMirrorList x)) c

repl :: [(String,String)] -> [String] -> IO ()
repl x c = do
  ($!) putStr (conf c "input")
  response <- getLine
  putStrLn ""
  case (look x response) of  (Just f) -> putStrLn f;(Nothing) -> learn x c response --Horrible indentation, I know.
  repl x c

learn :: [(String,String)] -> [String] -> String -> IO ()
learn inout config unknown = do
  putStr (conf config "learn")
  x <- getLine
  putStrLn ""
  system("append " ++ (conf config "file")++" "++(unknown++"_"++x))
  repl ((unknown,x):inout) config
  
  
  
      
