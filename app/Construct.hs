{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE FlexibleContexts #-}

module Construct where

import Control.Monad.State
import System.IO
import System.Exit (exitSuccess)
import System.Console.ANSI
import System.Random
import Data.List (sortBy)
import Data.Function (on)

import Vars
import ANSI

--Pure Code

mkTracker :: MonadIO m => m Tracker 
mkTracker = return $ Tracker 
  {
      _Nft       = 0
    , _Defi      = 0
    , _Gaming    = 0
    , _Identity  = 0
    , _Metaverse = 0
    , qNum       = 0
  }

modifyTracker :: (MonadIO m, MonadState Tracker m) => Category -> (Score -> Score) -> m ()
modifyTracker c f 
  | c == Nft       =  modify $ modifyNft       f
  | c == Defi      =  modify $ modifyDefi      f
  | c == Gaming    =  modify $ modifyGaming    f
  | c == Identity  =  modify $ modifyIdentity  f
  | c == Metaverse =  modify $ modifyMetaverse f

modifyNft :: (Score -> Score) -> Tracker -> Tracker
modifyNft f t = t { _Nft = f (_Nft t) } 

modifyDefi :: (Score -> Score) -> Tracker -> Tracker
modifyDefi f t = t { _Defi = f (_Defi t) } 

modifyGaming :: (Score -> Score) -> Tracker -> Tracker
modifyGaming f t = t { _Gaming = f (_Gaming t) } 

modifyIdentity :: (Score -> Score) -> Tracker -> Tracker
modifyIdentity f t = t { _Identity = f (_Identity t) } 

modifyMetaverse :: (Score -> Score) -> Tracker -> Tracker
modifyMetaverse f t = t { _Metaverse = f (_Metaverse t) } 

incQNum :: Tracker -> Tracker
incQNum t = t { qNum = (+1) (qNum t)}

nextQuestion :: (MonadIO m, MonadState Tracker m) => m ()
nextQuestion = modify $ incQNum

--Impure Code

io :: MonadIO m => IO a -> m a  
io = liftIO

quietly :: IO a -> IO a
quietly ioa = do
  hSetEcho stdin False
  a <- ioa
  hSetEcho stdin True
  return a

randomize :: [a] -> IO [a]                                                                                                                                             
randomize xs = do                                                                                                                                                      
  ys <- replicateM (length xs) $ randomRIO (1 :: Int, 100000)                                                                                                          
  pure $ map fst $ sortBy (compare `on` snd) (zip xs ys)

showQuestion :: (MonadIO m, MonadState Tracker m) => Question -> m()
showQuestion (_ , q , os) = do
  tracker <- get
  io $ bold $ putStrLn (concat [show (qNum tracker), ". ", q])
  io (helper os) where
    helper []      = return ()
    helper (x:xs)  = putStrLn ("    " ++  x) >> helper xs
  
invalidAns :: IO Char
invalidAns = do 
  italics $ putStrLn "You entered an invalid answer. Please try again!"
  putStrLn ""
  quietly getChar

ansCheck :: (MonadIO m, MonadState Tracker m) => Answer -> Question -> m ()
ansCheck x ques@(c, _, _) =
 case x of 
    'a' -> modifyTracker c (+0) >> showAns 'a'
    'b' -> modifyTracker c (+1) >> showAns 'b'
    'c' -> modifyTracker c (+2) >> showAns 'c'
    'd' -> modifyTracker c (+3) >> showAns 'd'
    'q' -> io (putStrLn "Thank you for your time") >> io exitSuccess
    _   -> do 
      ans <- io invalidAns
      ansCheck ans ques

showAns :: (MonadIO m, MonadState Tracker m) => Char -> m ()
showAns x = io $ putStrLn ("You chose " ++ [x]) 