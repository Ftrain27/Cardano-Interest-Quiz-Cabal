{-# LANGUAGE FlexibleContexts #-}

module Main where
import Control.Monad.State
import Control.Concurrent
import System.IO
import System.Console.ANSI
import System.Exit (exitSuccess)

import Construct
import Vars
import Results
import ANSI

-- suggested additions:
-- add ability to go back and change answers
-- eventually implement a web scraper and interpreter to suggest up-to-date projects

main :: IO ()
main =  do 
  hideCursor
  startUp
  hSetBuffering stdin NoBuffering
  hFlush stdout
  x <- quietly getChar
  wait x
  showCursor
  tracker <- mkTracker
  evalStateT runIt tracker
  return ()

wait :: Char -> IO ()
wait x
  | x == 'q' = putStrLn "Thank you for your time" >> exitSuccess
  | otherwise = return ()

runIt :: StateT Tracker IO ()
runIt = do
  io $ putStrLn ""
  allRandomQuestions <- io $ randomize allQuestions
  runQuiz allRandomQuestions
  io $ putStrLn ""
  tracker <- get
  io $ runResults tracker

runQuiz :: (MonadIO m, MonadState Tracker m) => Quiz -> m ()
runQuiz []     = return ()
runQuiz (q:qs) = do 
  nextQuestion
  showQuestion q
  ans <- io (quietly getChar)
  io $ putStrLn ""
  ansCheck ans q
  io $ putStrLn ""
  runQuiz qs

runResults :: Tracker -> IO ()
runResults t = do
  setSGR [SetColor Foreground Vivid Yellow]
  bold $ putStr "Calculating results..."
  hFlush stdout
  threadDelay (2 * (10 ^ 6))
  clearLine
  setSGR [SetColor Foreground Vivid Green]
  setCursorColumn 0
  bold $ putStrLn "Done"
  reset
  putStrLn "Here are the projects that would most interest you:"
  putStrLn ""
  sortResults (mkResults t projRec)
  putStrLn ""
  putStrLn "Thank you for your time"
