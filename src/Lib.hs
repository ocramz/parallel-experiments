module Lib where

import System.Random (StdGen, getStdGen, randoms)
import Data.List (sort)

import Control.Parallel (par, pseq)



seqSort :: (Ord a) => [a] -> [a]
seqSort (x:xs) = lesser `pseq` (greater `pseq`
                                (lesser ++ x:greater))
    where lesser  = seqSort [y | y <- xs, y <  x]
          greater = seqSort [y | y <- xs, y >= x]
seqSort _ = []


parSort :: (Ord a) => [a] -> [a]
parSort (x:xs)    = force greater `par` (force lesser `pseq`
                                         (lesser ++ x:greater))
    where lesser  = parSort [y | y <- xs, y <  x]
          greater = parSort [y | y <- xs, y >= x]
parSort _         = []


parSort2 :: (Ord a) => Int -> [a] -> [a]
parSort2 d list@(x:xs)
  | d <= 0     = sort list
  | otherwise = force greater `par` (force lesser `pseq`
                                     (lesser ++ x:greater))
      where lesser      = parSort2 d' [y | y <- xs, y <  x]
            greater     = parSort2 d' [y | y <- xs, y >= x]
            d' = d - 1
parSort2 _ _              = []






randomInts :: Int -> StdGen -> [Int]
randomInts k g = let result = take k (randoms g)
                 in force result `seq` result



force :: [a] -> ()
force xs = go xs `pseq` ()
    where go (_:xs) = go xs
          go [] = 1
