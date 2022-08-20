module ANSI where

import System.Console.ANSI

startUp :: IO ()
startUp = do
    clearScreen
    setCursorPosition 5 0
    setSGR [ SetConsoleIntensity BoldIntensity
            , SetColor Foreground Vivid Red
            , SetColor Background Vivid Blue
            , SetBlinkSpeed RapidBlink
            ]
    putStrLn "Welcome to the Cardano Interest Quiz!"
    setSGR [ SetConsoleIntensity NormalIntensity
            , SetColor Foreground Dull Red
            , SetBlinkSpeed NoBlink
            ]
    putStrLn "This is a simple, 10 question quiz used to match your interests to relevant crypto projects in the Cardano Ecosystem"
    putStrLn "Please press a, b, c or d to answer each question"
    putStrLn "You can also press q to quit at any time"
    putStrLn "Press any key to continue..."
    hyperlink "Test.com" "Test"


--SGR needed to change properties like color of text
  -- SetColor <Layer> <ColorIntensity> <Color>
    -- Layer (Foreground,Background)
    -- ColorIntensity (Vivid,Dull)

  -- setConsoleIntensity <Level> - essentially how thick the text is
-- setCursorPosition <row> <column>

--     -- hyperlink "Test.com" "Test"

-- test2 =  do
--   setSGR [SetColor Foreground Dull Blue]
--   putStr "Enter your name: "
--   setSGR [SetColor Foreground Dull Yellow]
--   hFlush stdout  -- flush the output buffer before getLine
--   name <- getLine
--   setSGR [SetColor Foreground Dull Blue]
--   putStrLn $ "Hello, " ++ name ++ "!"
--   setSGR [Reset]  -- reset to default colour scheme