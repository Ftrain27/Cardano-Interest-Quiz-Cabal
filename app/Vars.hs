module Vars (
    Prompt
    ,Option
    ,Name
    ,Link
    ,Score
    ,Answer
    ,Question
    ,Quiz
    ,Project
    ,Recommendations
    ,Result
    ,Category (..)
    ,Tracker (..)
    ,allQuestions
    ,projRec
) where

--import Control.Lens

type Prompt   = String
type Option   = String
type Name     = String
type Link     = String
type Score    = Int
type Answer   = Char

type Question        = (Category, Prompt, [Option])
type Quiz            = [Question]
type Project         = (Category, Name, Link, Score) 
type Recommendations = [Project]
type Result          = (Name, Link)
-- data Project         = Project { Category :: Category, Name :: String, Link :: String, Score :: Score }


data Category = Nft | Defi | Gaming | Identity | Metaverse deriving (Show, Eq, Ord)

data Tracker = Tracker 
    { _Nft       :: Score 
    , _Defi      :: Score
    , _Gaming    :: Score
    , _Identity  :: Score
    , _Metaverse :: Score
    , qNum       :: Score
    } deriving (Show, Eq)

--makeLenses ''Tracker

q1  = (Nft, "1. Have you heard of NFTs?", ["a. I know about it, but it doesn't interest me","b. What is that?","c. I think I have before", "d. I love Nfts!"])
q2  = (Nft, "2. Do you have any NFTs?", ["a. No", "b. Yes, I love collecting them to show off", "c. Yes, I love collecting them for their utility", "d. Yes, I love flipping them"])
q3  = (Defi, "3. Have you heard of DeFi?", ["a. I know about it, but it doesn't interest me","b. What is that?","c. I think I have before", "d. I love Defi!"])
q4  = (Defi, "4. Have you used any DeFi protocols?", ["a. No", "b. Yes, I love doing price arbitrage!", "c. Yes, I love yield farming!", "d. Yes, I love exploring novel defi protocol features!"])
q5  = (Gaming, "5. Have you heard of Play to Earn `P2E`?", ["a. I know about it, but it doesn't interest me","b. What is that?","c. I think I have before", "d. I love P2E!"])
q6  = (Gaming, "6. Have you played any P2E games?", ["a. No", "b. I'm more of an investor than a player", "c. I want to, but I'm waiting for the games to actually be fun", "d. Of course, Axie Infinity is my life!"])
q7  = (Identity, "7. Have you heard of blockchain identity solutions before?", ["a. I know about it, but it doesn't interest me","b. What is that?","c. I think I have before", "d. I love Identity solutions!"])
q8  = (Identity, "8. Do you have any identification issues?", ["a. No", "b. Yes, I have a million online accounts", "c. Yes, I travel a lot and documentation is difficult to deal with", "d. Yes, I have other issues with identification"])
q9  = (Metaverse, "9. Have you heard of the Metaverse?", ["a. I know about it, but it doesn't interest me","b. What is that?","c. I think I have before", "d. I love the Metaverse!"])
q10 = (Metaverse, "10. Have you participated in any Metaverse worlds?", ["a. No", "b. I'm more of an investor than a participant", "c. I want to, but I'm waiting for the worlds to actually be interesting", "d. Of course, Virtua is my life!"])

allQuestions :: Quiz 
allQuestions =  [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10]

projRec :: Recommendations 
projRec = [
    (Nft       , "Yummi Universe"          ,"https://yummiuniverse.com/"      , 1)
  , (Nft       , "Ada Handle"              ,"https://adahandle.com/"          , 3)
  , (Nft       , "unsigned_algorithms"     ,"https://www.unsigs.com/"         , 5)
  , (Defi      , "SundaeSwap"              ,"https://www.sundaeswap.finance/" , 1)
  , (Defi      , "Liqwid"                  ,"https://www.liqwid.finance/"     , 3)
  , (Defi      , "Aada"                    ,"https://aada.finance/"           , 5)
  , (Gaming    , "HashGuardians"           ,"https://www.hashguardians.io/"   , 1)
  , (Gaming    , "Bears Club"              ,"https://bearsclub.io/"           , 3)
  , (Gaming    , "DEADPXLZ"                ,"https://pxlz.org/"               , 5)
  , (Identity  , "dHealth"                 ,"https://www.dhealth.com/"        , 1)
  , (Identity  , "Blockademia"             ,"https://blockademia.com/en/"     , 3)
  , (Identity  , "Atala PRISM"             ,"https://atalaprism.io/"          , 5)
  , (Metaverse , "Cardano Island (Virtua)" ,"https://cardano.virtua.com/"     , 1)
  , (Metaverse , "Cornucopias"             ,"https://www.cornucopias.io/"     , 3)
  , (Metaverse , "Space Tokens"            ,"https://www.spacetokens.io/"     , 5)
  ]