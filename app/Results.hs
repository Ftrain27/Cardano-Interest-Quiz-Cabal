{-# LANGUAGE FlexibleContexts #-}

module Results where

import Control.Monad.State
import Data.List (sortBy)
import Data.Function (on)
import System.Console.ANSI
import Vars
import ANSI

--Pure Code

first :: (a,b,c,d) -> a
first (a,b,c,d) = a

second :: (a,b,c,d) -> b
second (a,b,c,d) = b

third :: (a,b,c,d) -> c
third (a,b,c,d) = c

fourth :: (a,b,c,d) -> d
fourth (a,b,c,d) = d


mkResults :: Tracker -> Recommendations -> Recommendations
mkResults t [] = []
mkResults t (r : rs) =
  case testResults t r of
    True  -> r : mkResults t rs
    False -> mkResults t rs

testResults :: Tracker -> Project -> Bool
testResults t proj@(c, _, _, n) =
  case c of
    Nft       -> _Nft       t >= n
    Defi      -> _Defi      t >= n
    Gaming    -> _Gaming    t >= n
    Identity  -> _Identity  t >= n
    Metaverse -> _Metaverse t >= n

--Impure Code

sortResults :: Recommendations -> IO ()
sortResults recs =
  showResults a where
    a = sortBy (compare `on` first) (take 5 (sortBy (flip compare `on` fourth) recs))

showResults :: Recommendations -> IO ()
showResults [] = return ()
showResults (r : rs) = do
  setSGR [SetColor Foreground Dull Blue,SetConsoleIntensity BoldIntensity]
  putStr $ second r 
  setSGR [SetColor Foreground Dull Red,SetConsoleIntensity NormalIntensity]
  setCursorColumn 25
  putStrLn $ third r 
  reset
  showResults rs
