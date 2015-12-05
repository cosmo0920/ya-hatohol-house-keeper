import HouseKeeper
import Test.Hspec
import Control.Monad.Trans (liftIO)
import Data.Time (Day, LocalTime, NominalDiffTime, TimeZone, UTCTime,
                  getCurrentTime, getCurrentTimeZone, utcToLocalTime, addUTCTime, formatTime,
                  defaultTimeLocale, parseTimeOrError)

specs :: Spec
specs = describe "util functions" $ do
  it "obtaining unixtime with 2008/10/1 10:00" $
    toEpochTimeSecInternal "2008/10/1 10:00" `shouldBe` 1222822800

  it "obtaining unixtime with 2011/11/22 10:00" $
    toEpochTimeSecInternal "2011/11/22 10:00" `shouldBe` 1321923600

  it "obtaining unixtime with 2015/12/5 10:00" $
    toEpochTimeSecInternal "2015/12/5 10:00" `shouldBe` 1449277200

  it "obtaining one past month with 2015/12/01" $ do
    zone <- getCurrentTimeZone
    let utc = parseTimeOrError True defaultTimeLocale "%Y/%m/%d" "2015/12/01" :: UTCTime
    past <- thirtyDaysPast' zone utc
    past `shouldBe` "2015/11/01"

  it "obtaining one past month with 2015/01/01" $ do
    zone <- getCurrentTimeZone
    let utc = parseTimeOrError True defaultTimeLocale "%Y/%m/%d" "2015/01/01" :: UTCTime
    past <- thirtyDaysPast' zone utc
    past `shouldBe` "2014/12/02"

main :: IO ()
main = hspec $ specs
