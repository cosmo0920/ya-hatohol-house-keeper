{-# LANGUAGE MonadComprehensions #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module HouseKeeper where

import Data.Int (Int32, Int64)
import Data.Time (Day, LocalTime, NominalDiffTime, TimeZone, UTCTime,
                  getCurrentTime, getCurrentTimeZone, utcToLocalTime, addUTCTime, formatTime,
                  defaultTimeLocale)
import System.Posix.Types (EpochTime)
import Database.Relational.Query
import qualified Events
import Events (Events, events, tableOfEvents)
import qualified ActionLogs
import ActionLogs (ActionLogs, actionLogs, tableOfActionLogs)
import Database.Record

import Database.Relational.Query

import Database.HDBC (IConnection, SqlValue, rollback, commit)
import Database.HDBC.Query.TH (makeRecordPersistableDefault)
import Database.HDBC.Record (runDelete, runInsert, runInsertQuery, runQuery, runUpdate)
import Database.HDBC.Session (withConnectionIO, handleSqlError')
import DataSource (connect)

import qualified Data.ByteString.Char8 as BC
import Data.UnixTime

thirtyDaysPastFromToday :: IO String
thirtyDaysPastFromToday = do
  now <- getCurrentTime
  zone <- getCurrentTimeZone
  result <- thirtyDaysPast' zone now
  return result

thirtyDaysPast' :: TimeZone -> UTCTime -> IO String
thirtyDaysPast' zone time = do
  let utc = addUTCTime ((-60*60*24*30)::NominalDiffTime) time
      zonedTime = utcToLocalTime zone utc
      result = formatTime defaultTimeLocale "%Y/%m/%d" zonedTime
  return result

unsafeDayValue :: SqlProjectable p => String -> p (Maybe LocalTime)
unsafeDayValue = unsafeProjectSqlTerms . showConstantTermsSQL

toEpochTimeSec :: SqlProjectable p => String -> p Int32
toEpochTimeSec dt = unsafeProjectSqlTerms . showConstantTermsSQL $ (show epoch :: String)
  where
    epoch = toEpochTimeSecInternal dt

toEpochTimeSecInternal :: String -> EpochTime
toEpochTimeSecInternal dt = epoch
  where
    epoch = toEpochTime unixtime
    unixtime = parseUnixTime format (BC.pack dt)
    format = (BC.pack "%Y/%m/%d %H:%M:%S")

deleteActionLogsWithTime :: String -> Delete ()
deleteActionLogsWithTime timeStr = typedDelete tableOfActionLogs . restriction $ \proj -> do
  wheres $ proj ! ActionLogs.queuingTime' .<. unsafeDayValue timeStr

deleteEventsWithUnixTime :: String -> Delete ()
deleteEventsWithUnixTime timeStr = typedDelete tableOfEvents . restriction $ \proj -> do
  wheres $ proj ! Events.timeSec' .<. toEpochTimeSec timeStr

countEvents :: Relation () Int64
countEvents = aggregateRelation $ do
  e <- query events
  return $ count (e ! Events.unifiedId')

countActionLogs :: Relation () Int64
countActionLogs = aggregateRelation $ do
  a <- query actionLogs
  return $ count (a ! ActionLogs.actionLogId')

run :: (Show a, IConnection conn, FromSql SqlValue a, ToSql SqlValue p)
    => conn -> p -> Relation p a -> IO ()
run conn param rel = do
  putStrLn $ "SQL: " ++ show rel
  records <- runQuery conn (relationalQuery rel) param
  mapM_ print records
  putStrLn ""
  rollback conn

runD :: (IConnection conn, ToSql SqlValue p)
     => conn -> p -> Delete p -> IO ()
runD conn param dlt = do
  putStrLn $ "SQL: " ++ show dlt
  num <- runDelete conn dlt param
  print num
  putStrLn ""
  commit conn

runDeleteEventsWithTime :: String -> IO ()
runDeleteEventsWithTime day = handleSqlError' $ withConnectionIO connect $ \conn -> do
  runD conn () $ deleteEventsWithUnixTime day

runDeleteActionLogsWithTime :: String -> IO ()
runDeleteActionLogsWithTime day = handleSqlError' $ withConnectionIO connect $ \conn -> do
  runD conn () $ deleteActionLogsWithTime day

runCountEvents :: IO ()
runCountEvents = handleSqlError' $ withConnectionIO connect $ \conn -> do
  run conn () countEvents

runCountActionLogs :: IO ()
runCountActionLogs = handleSqlError' $ withConnectionIO connect $ \conn -> do
  run conn () countActionLogs
