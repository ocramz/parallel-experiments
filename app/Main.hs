module Main where

import Lib

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
testFunction = parSort2 3

-- randomInts :: Int -> StdGen -> [Int]
-- randomInts k g = let result = take k (randoms g)
--                  in force result `seq` result

main = do
  args <- getArgs
  nc <- getNumCapabilities
  let count | null args = 500000
            | otherwise = read (head args)
  input <- randomInts count `fmap` getStdGen
  putStrLn $ "We have " ++ show (length input) ++ " elements to sort, using " ++ show nc ++ " threads."
  start <- getCurrentTime
  let sorted = testFunction input
  putStrLn $ "Sorted all " ++ show (length sorted) ++ " elements."
  end <- getCurrentTime
  putStrLn $ show (end `diffUTCTime` start) ++ " elapsed."
