{-# LANGUAGE FlexibleContexts #-}

module Results where

import Control.Monad.State
import Data.List (sortBy)
import Data.Function (on)
import System.Console.ANSI
import Vars

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
showResults (r : rs) = do -- putStrLn (second r ++ "    " ++ third r) >> showResults rs
  setSGR [SetColor Foreground Dull Blue,SetConsoleIntensity BoldIntensity]
  putStr $ second r 
  setSGR [SetColor Foreground Dull Red,SetConsoleIntensity NormalIntensity]
  setCursorColumn 25
  putStrLn  $ third r 
  setSGR [Reset]
  showResults rs

-- mkResults :: (MonadIO m, MonadState Tracker m) => Recommendations -> m (Recommendations)

--  2. Assign a number to each data type, then use a random generator to select a data type and remove all of its associated results

-- eventually implement a web scraper and interpreter to suggest up-to-date projects

-- **RECOMMENDATIONS**
-- **NFT**
-- Yummi Universe
-- https://yummiuniverse.com/

-- Ada Handle
-- https://adahandle.com/

-- unsigned_algorithms
-- https://www.unsigs.com/

-- **DEFI**
-- SundaeSwap
-- https://www.sundaeswap.finance/

-- Liqwid
-- https://www.liqwid.finance/

-- Aada
-- https://aada.finance/

-- **GAMING**
-- HashGuardians
-- https://www.hashguardians.io/

-- Bears Club
-- https://bearsclub.io/

-- DEADPXLZ
-- https://pxlz.org/

-- **IDENTITY**
-- Blockademia
-- https://blockademia.com/en/

-- dHealth
-- https://www.dhealth.com/

-- Atala PRISM
-- https://atalaprism.io/

-- **METAVERSE**
-- Cardano Island (Virtua)
-- https://cardano.virtua.com/

-- Cornucopias
-- https://www.cornucopias.io/

-- Space Tokens
-- https://www.spacetokens.io/