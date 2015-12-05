import HouseKeeper
import Test.Hspec
import Data.Time (TimeZone, UTCTime,
                  getCurrentTime, getCurrentTimeZone,
                  defaultTimeLocale, parseTimeOrError)

thirtyDaysPastInTest :: String -> IO String
thirtyDaysPastInTest timeStr = do
  zone <- getCurrentTimeZone
  let utc = parseTimeOrError True defaultTimeLocale "%Y/%m/%d" timeStr :: UTCTime
  past30Day <- thirtyDaysPast' zone utc
  return past30Day

specs :: Spec
specs = describe "util functions" $ do
  describe "obtaining unixtime" $ do
    it "with 2008/10/1 10:00" $
      toEpochTimeSecInternal "2008/10/1 10:00" `shouldBe` 1222822800

    it "with 2011/11/22 10:00" $
      toEpochTimeSecInternal "2011/11/22 10:00" `shouldBe` 1321923600

    it "with 2015/12/5 10:00" $
      toEpochTimeSecInternal "2015/12/5 10:00" `shouldBe` 1449277200
  describe "obtaining 30days past" $ do
    it "with 2015/12/01" $ do
      past <- thirtyDaysPastInTest "2015/12/01"
      past `shouldBe` "2015/11/01"

    it "with 2015/01/01" $ do
      past <- thirtyDaysPastInTest "2015/01/01"
      past `shouldBe` "2014/12/02"

main :: IO ()
main = hspec $ specs
