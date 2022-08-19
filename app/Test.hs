module Test where

import System.IO (hFlush, stdout)
import System.Console.ANSI

-- Testing ANSI functionality

--SGR needed to change properties like color of text
  -- SetColor <Layer> <ColorIntensity> <Color>
    -- Layer (Foreground,Background)
    -- ColorIntensity (Vivid,Dull)

  -- setConsoleIntensity <Level> - essentially how thick the text is
-- setCursorPosition <row> <column>

test = do
    clearScreen
    setCursorPosition 5 0
    setTitle "ANSI Terminal Short Example"

    setSGR [ SetConsoleIntensity BoldIntensity
           , SetColor Foreground Vivid Red
           , SetBlinkSpeed SlowBlink
           ]
    
    putStr "Hello"
    setCursorPosition 8 5

    -- hyperlink "Test.com" "Test"

    setSGR [ SetConsoleIntensity NormalIntensity
           , SetColor Foreground Vivid White
           , SetColor Background Dull Blue
           ]
    putStrLn "World!"
    setSGR [Reset]

test2 =  do
  setSGR [SetColor Foreground Dull Blue]
  putStr "Enter your name: "
  setSGR [SetColor Foreground Dull Yellow]
  hFlush stdout  -- flush the output buffer before getLine
  name <- getLine
  setSGR [SetColor Foreground Dull Blue]
  putStrLn $ "Hello, " ++ name ++ "!"
  setSGR [Reset]  -- reset to default colour scheme




























-- import Test.QuickCheck
-- import Test.HUnit
-- import Construct
-- import Vars

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
