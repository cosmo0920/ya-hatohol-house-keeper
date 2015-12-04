{-# LANGUAGE RecordWildCards #-}
module Main where

import Lib
import Options.Applicative
import System.IO.Unsafe (unsafePerformIO)

data Config = Config
  { date   :: String
  , stat   :: Bool
  , table  :: String }

config :: Parser Config
config = Config
     <$> strOption
         ( long "date"
        <> metavar "DATE"
        <> value (unsafePerformIO oneMonthPast)
        <> help ("Specify date time with format %Y/%m/%d [default:" ++
                 unsafePerformIO oneMonthPast ++ "]" ))
     <*> switch
         ( long "stat"
        <> help "Get statistics")
     <*> strOption
         ( long "table"
        <> metavar "TABLE_NAME"
        <> help "Specify table name" )

runQuery :: Config -> IO ()
runQuery Config {..} = do
  case table of
   "action_logs" -> do
     case stat of
      True -> runCountActionLogs
      False -> runDeleteActionLogsWithTime date
   "events" -> do
      case stat of
       True -> runCountEvents
       False -> runDeleteEventsWithTime date
   _ -> putStrLn "Unsupported table."

main :: IO ()
main = do
  execParser opts >>= runQuery

  where
    opts = info (helper <*> config)
           ( fullDesc
             <> progDesc "Yet Another Hatohol House Keeper"
             <> header "Project Hatohol inspired House Keeper" )
