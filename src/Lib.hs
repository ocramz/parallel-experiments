-- | A library to do stuff.
module Lib where

import System.Random (StdGen, getStdGen, randoms)

import Control.Parallel (par, pseq)


randomInts :: Int -> StdGen -> [Int]
randomInts k g = let result = take k (randoms g)
                 in force result `seq` result



force :: [a] -> ()
force xs = go xs `pseq` ()
    where go (_:xs) = go xs
          go [] = 1
