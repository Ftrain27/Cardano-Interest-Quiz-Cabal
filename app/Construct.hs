{-# LANGUAGE BlockArguments #-}
{-# LANGUAGE FlexibleContexts #-}

module Construct where

import Control.Monad.State
import System.IO
import System.Exit (exitSuccess)
import System.Console.ANSI
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
--add in initialization for random generator here also
--Generator might look somthing like this: 
--import System.Random
--main = replicateM (randomTracker :: Tracker Score) >>= print

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

--Impure Code

io :: MonadIO m => IO a -> m a  
io = liftIO

quietly :: IO a -> IO a
quietly ioa = do
  hSetEcho stdin False
  a <- ioa
  hSetEcho stdin True
  return a

showQuestion :: Question -> IO ()
showQuestion (_ , q , os) = do
  bold $ putStrLn q
  helper os where
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