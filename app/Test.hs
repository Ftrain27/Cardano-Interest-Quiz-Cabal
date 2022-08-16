--this is where a test will be generated for our code base.
 -- Tests.hs
module Test where
import Test.QuickCheck
import Test.HUnit
import Workspace
import Vars


 --prop_reverseReverse :: [Int] -> Bool
-- prop_reverseReverse xs = reverse (reverse xs) == xs

--pushTest :: Assertion
--pushTest = [NumLit 1] ^? push (NumLit 1)

--pushPopTest :: Assertion
--pushPopTest = [] ^? (push (NumLit 0) >> void pop)

--main :: IO ()
--main = defaultMainWithOpts
--       [testCase "push" pushTest
  --     ,testCase "push-pop" pushPopTest]
   --    mempty

-- testShowQuestionEmptyList :: Test
-- testShowQuestionEmptyList =
--     TestCase $ assertEqual "Should return Nothing for empty list"
--                            Nothing (showQuestion ([]::[String]))

-- testShowQuestionNonEmptyList :: Test
-- testShowQuestionNonEmptyList =
--     TestCase $ assertEqual "Should return a question for non empty list" (Just 1)
--                (showQuestion ([1]::[String]))

-- testInvalidAns :: Test
-- testInvalidAns =
--     TestCase $ assertEqual "Should return null"
--                           Nothing (invalidAns ansCheck)

-- testCatGet :: Test
-- testCatGet =
--     TestCase $ assertEqual "Should return one of the following cases: nft,defi,gaming,ID,metaverse" (Just 1)
--                (catGet ([1]::[Int]))

-- testCatNotGot :: Test
-- testCatNotGot =
--     TestCase $ assertEqual "Should return null"
--                            Nothing (catGet ([]::[Int]))

-- not sure if this case value is working properly as intended 

-- main :: IO Counts
-- main = runTestTT $ TestList [testShowQuestionEmptyList, testShowQuestionNonEmptyList, testInvalidAns]

-- **Irfan meeting notes**
-- key takeaway: State Monad >>> Lens

--incTracker :: String -> State Tracker ()
--incTracker category = do
-- tracker <- get
-- case category of
-- "defi" -> do
-- let oldDefi = defi oldTracker
-- newDefi = oldDefi + 1
-- newTracker = oldTracker { defi = newDefi }
-- put new tracker

-- main = do 
-- let oldTracker = Tracker {defi = 0, nft = 0}
-- newTracker = execState (incTracker "nft") oldTracker
-- print newTracker
-- replicateM does an operation multiple times. replicate2 = 2x

--modify f is an action that updates the state to the result of applying f to the current state.
--modify f = get >>= (put . f)

-- incDefi :: Tracker -> Tracker
-- incDefi t = t { defi = defi t }
-- incNft :: Tracker -> Tracker
-- incNft t = t { Nft = Nft t }

-- modifyDefi :: (Score -> Score) -> Tracker -> Tracker
-- 
-- modifyNft :: (Score -> Score) -> Tracker -> Tracker
--modify_nft ft = t { nft = f (nft t) }
--modify _tracker :: (Score -> Score) -› String -› State Tracker ()
--modify tracker h c
-- C== "defi" = modify $ modify_defi h
-- C== "nft" = modify $ modify_nft h
-- main = do
-- let old tracker = Tracker { defi = 0, nft = 0}
-- new_tracker = flip execState old_tracker $ do
-- modify_tracker (+ 7) "nft"
-- modify tracker (+ 17) "defi"
-- print new tracker

-- import Control.Lens.TH
-- import Control.Monad.State

-- type Defi = Bool
-- type Nft = Int
-- data Tracker = Tracker {
-- _defi :: Defi,
-- _nft :: Nft
-- } deriving Show
-- makeLenses ''Tracker

-- put_defi :: Defi -› State Tracker ()
-- put defi new defi = defi .= new defi

-- main = print $ (execState (put_defi True) (Tracker {_defi = False, _nft = 0 }))

-- State Monad >>> Lens 