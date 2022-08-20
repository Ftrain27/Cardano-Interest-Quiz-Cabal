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
  runQuiz allQuestions
  io $ putStrLn ""
  io $ setSGR [SetColor Foreground Dull Magenta,SetConsoleIntensity BoldIntensity]
  -- want this to blink until thread delay ,then clear the line , then show results
  io (putStrLn "Calculating results...")
  io $ threadDelay (10 ^ 6)
  -- io $ clearLine
  io $ putStrLn ""
  tracker <- get
  io $ sortResults (mkResults tracker projRec)
  io $ putStrLn ""
  io (putStrLn "Thank you for your time")

runQuiz :: (MonadIO m, MonadState Tracker m) => Quiz -> m ()
runQuiz []     = return ()
runQuiz (q:qs) = do 
  io $ showQuestion q
  ans <- io (quietly getChar)
  io $ putStrLn ""
  io $ setSGR [SetColor Foreground Dull Green]
  io $ setSGR [Reset]
  ansCheck ans q
  io $ putStrLn ("You chose " ++ [ans])
  runQuiz qs