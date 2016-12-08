module Main where

import Lib

import Criterion.Main (defaultMain, bgroup, bench, whnf, whnfIO, nfIO)

import Data.Time.Clock (diffUTCTime, getCurrentTime)
import System.Environment (getArgs)
import GHC.Conc.Sync (getNumCapabilities)

import System.Random (StdGen, getStdGen, randoms)

-- import Text.Printf (printf)

-- main :: IO ()
-- main = print "It works!"


testFunction :: [Int] -> [Int]
-- testFunction = sort
-- testFunction = seqSort
-- testFunction = parSort
testFunction = parSort2 4

-- randomInts :: Int -> StdGen -> [Int]
-- randomInts k g = let result = take k (randoms g)
--                  in force result `seq` result

-- main = do
--   args <- getArgs
--   nc <- getNumCapabilities
--   let count | null args = 500000
--             | otherwise = read (head args)
--   input <- randomInts count `fmap` getStdGen
--   putStrLn $ "We have " ++ show (length input) ++ " elements to sort, using " ++ show nc ++ " threads."
--   start <- getCurrentTime
--   let sorted = testFunction input
--   putStrLn $ "Sorted all " ++ show (length sorted) ++ " elements."
--   end <- getCurrentTime
--   putStrLn $ show (end `diffUTCTime` start) ++ " elapsed."

genDataIO :: Int -> Int -> IO Int
genDataIO count nlev = do
  input <- randomInts count `fmap` getStdGen
  return $ length (parSort2 nlev input) -- hardwired parSort2



main = defaultMain
  [bgroup "parSort2"
    [
      -- bench (showData n 1) (whnfIO $ genDataIO n 1),
      bench (showData n 2) (whnfIO $ genDataIO n 2)
      -- bench (showData n 4) (whnfIO $ genDataIO n 4)
      
    ]
  ] where n = 500000
          showData nd nl = unwords ["( # entries :",show nd,", parallel threshold :",show nl,")"]


   



-- main = defaultMain
--   [
--     bgroup "parSort2" [ bench "1" $ whnf ]
--   ]



-- main = defaultMain [
--   bgroup "fib" [ bench "1"  $ whnf fib 1
--                , bench "5"  $ whnf fib 5
--                , bench "9"  $ whnf fib 9
--                , bench "11" $ whnf fib 11
--                ]
--   ]
