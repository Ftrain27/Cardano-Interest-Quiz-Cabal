module Test where

import Test.QuickCheck
import Test.HUnit
-- import Clash.Netlist.Types (NumLit)

import Construct
import Vars

{-fxns to test:
wait (if given 'q', does it quit? if given 't', does it test? if given any other key, does it continue?)
showQuestion (if given an empty list, does it do nothing? if given a Question, does it print the qNum and the formatted question?)
showAns (if given nothing, does it print "you chose "? if given a char, does it print "you chose 'x' "?)
first, second, third, fourth (do each of these functions return the correct tuple value?)
mkResults (if given an empty list, does it return an empty list? )
showResults (if given an empty list, does it do nothing? if given Recommendations, does it print the 2nd and 3rd tuple values for each rec?)
runQuiz (if given empty list, does it do nothing? if given a Question, does it increment the q number and getChar?)
-}
testShowQuestionEmptyList :: Test
testShowQuestionEmptyList =
    TestCase $ assertEqual "Should return Nothing for empty list"
                           Nothing (showQuestion [])

testShowQuestionNonEmptyList :: Test
testShowQuestionNonEmptyList =
    TestCase $ assertEqual "Should return a question for non empty list" (Just 1)
               (showQuestion (allQuestions!!0 :: Question))

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

mainTest :: IO Counts
mainTest = runTestTT $ TestList [testShowQuestionEmptyList, testShowQuestionNonEmptyList]

-- prop_reverseReverse :: [Int] -> Bool
-- prop_reverseReverse xs = reverse (reverse xs) == xs

-- pushTest :: Assertion
-- pushTest = [NumLit 1] ^? push (NumLit 1)

-- pushPopTest :: Assertion
-- pushPopTest = [] ^? (push (NumLit 0) >> void pop)

-- main :: IO ()
-- main = defaultMainWithOpts
--       [testCase "push" pushTest
--       ,testCase "push-pop" pushPopTest]
--       mempty