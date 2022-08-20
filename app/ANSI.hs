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

endScreen :: IO ()
endScreen = do
    setSGR [SetColor Foreground Dull Magenta,SetConsoleIntensity BoldIntensity]
    putStrLn "Calculating results..."

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

--SGR needed to change properties like color of text
  -- SetColor <Layer> <ColorIntensity> <Color>
    -- Layer (Foreground,Background)
    -- ColorIntensity (Vivid,Dull)

  -- setConsoleIntensity <Level> - essentially how thick the text is
-- setCursorPosition <row> <column>