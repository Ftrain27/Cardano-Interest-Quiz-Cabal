{-# LANGUAGE FlexibleContexts #-}

module Main where
import Control.Monad.State
import Control.Concurrent
import System.IO
import Construct
import Vars
import Results


-- running main in ghci is fine
-- need to figure out why its not doing the same with 'cabal run'
-- suggested additions:
-- add ability to go back and change answers


main :: IO ()
main =  do 
  putStrLn "Welcome to the Cardano Interest Quiz!"
  putStrLn "This is a simple, 10 question quiz used to match your interests to relevant crypto projects in the Cardano Ecosystem"
  putStrLn "Please press a, b, c or d to answer each question"
  putStrLn "You can also press q to quit at any time"
  hSetBuffering stdin NoBuffering
  tracker <- mkTracker
  evalStateT runIt tracker
  return ()

runIt :: StateT Tracker IO ()
runIt = do
  runQuiz allQuestions
  io (putStrLn "Calculating results...")
  io $ threadDelay (10 ^ 6)
  tracker <- get
  io $ sortResults (mkResults tracker projRec)
  io (putStrLn "Thank you for your time")


runQuiz :: (MonadIO m, MonadState Tracker m) => Quiz -> m ()
runQuiz []     = return ()
runQuiz (q:qs) = do 
  io $ showQuestion q
  ans <- io (quietly getChar)
  io $ putStrLn ("You chose " ++ [ans])
  ansCheck ans q
  runQuiz qs

--runResults :: (MonadIO m, MonadState Tracker m) => m ()
--runResults = do
  --tracker <- get
  --io $ print $ show (mkResults tracker projRec) 

-- runStateT :: s -> m (a, s)

-- runQuiz :: Quiz -> StateT Tracker IO ()
-- runQuiz []     = return ()
-- runQuiz (q:qs) = do 
--   showQuestion q
--   ans <- io (quietly $ getChar)
--   ansCheck ans q
--   -- Tracker _Nft
--   runQuiz qs