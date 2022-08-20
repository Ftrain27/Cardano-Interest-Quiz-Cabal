module ANSI where

import System.Console.ANSI

startUp :: IO ()
startUp = do
    clearScreen
    setCursorPosition 5 0
    setSGR [  SetColor Foreground Vivid Red
            , SetColor Background Vivid Blue
            , SetBlinkSpeed RapidBlink
            ]
    bold $ putStrLn "Welcome to the Cardano Interest Quiz!"
    setSGR [ SetColor Foreground Dull Red, SetBlinkSpeed NoBlink ]
    putStrLn "This is a simple, 10 question quiz used to match your interests to relevant crypto projects in the Cardano Ecosystem"
    putStrLn "Please press a, b, c or d to answer each question"
    putStrLn "You can also press q to quit at any time"
    putStrLn "Press any key to continue..."
    setSGR [ Reset ]

italics :: IO a -> IO a
italics ioa = do
  setSGR [SetItalicized True]  
  a <- ioa
  setSGR [SetItalicized False]
  return a

bold :: IO a -> IO a
bold ioa = do 
  setSGR [ SetConsoleIntensity BoldIntensity ]
  a <- ioa
  setSGR [ SetConsoleIntensity NormalIntensity ]
  return a

reset :: IO ()
reset = setSGR [Reset]

-- Testing ANSI functionality

--SGR needed to change properties like color of text
  -- SetColor <Layer> <ColorIntensity> <Color>
    -- Layer (Foreground,Background)
    -- ColorIntensity (Vivid,Dull)

  -- setConsoleIntensity <Level> - essentially how thick the text is
-- setCursorPosition <row> <column>

-- test = do
--     clearScreen
--     setCursorPosition 5 0
--     setTitle "ANSI Terminal Short Example"

--     setSGR [ SetConsoleIntensity BoldIntensity
--            , SetColor Foreground Vivid Red
--            , SetBlinkSpeed SlowBlink
--            ]
    
--     putStr "Hello"
--     setCursorPosition 8 5

--     -- hyperlink "Test.com" "Test"

--     setSGR [ SetConsoleIntensity NormalIntensity
--            , SetColor Foreground Vivid White
--            , SetColor Background Dull Blue
--            ]
--     putStrLn "World!"
--     setSGR [Reset]

-- test2 =  do
--   setSGR [SetColor Foreground Dull Blue]
--   putStr "Enter your name: "
--   setSGR [SetColor Foreground Dull Yellow]
--   hFlush stdout  -- flush the output buffer before getLine
--   name <- getLine
--   setSGR [SetColor Foreground Dull Blue]
--   putStrLn $ "Hello, " ++ name ++ "!"
--   setSGR [Reset]  -- reset to default colour scheme