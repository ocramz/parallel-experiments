module LibSpec where

import Test.Hspec
-- import Test.Hspec.QuickCheck

import Control.Parallel

import Data.Time.Clock (diffUTCTime, getCurrentTime, UTCTime)

import Lib 

main :: IO ()
main = hspec spec

spec :: Spec
spec =
  describe "Lib" $ do
    it "works" $ do
      True `shouldBe` True
    -- prop "ourAdd is commutative" $ \x y ->
    --   ourAdd x y `shouldBe` ourAdd y x
