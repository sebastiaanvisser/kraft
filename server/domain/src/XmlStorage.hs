{-# LANGUAGE TypeOperators #-}
module XmlStorage where

import Control.Arrow
import Control.Arrow.List
import Data.List
import System.Lock.FLock
import Text.XML.Light
import Text.XML.Light.Convert

readXmlIO :: FilePath -> ([Content] -> IO a) -> IO a
readXmlIO f act =
  withLock f Shared Block $
    do xml <- readFile f
       act (parseXML xml)

writeXmlIO :: FilePath -> IO [Content] -> IO ()
writeXmlIO f act =
  withLock f Exclusive Block $
    do xml <- act
       writeFile f (intercalate "\n" (map ppContent xml))

withXmlIO :: FilePath -> ([Content] -> IO [Content]) -> IO ()
withXmlIO f act =
  withLock f Exclusive Block $
    do xml <- readFile f
       out <- act (parseXML xml)
       writeFile f (intercalate "\n" (map ppContent out))

-- pure variants

readXml :: FilePath -> ([Content] -> a) -> IO a
readXml f g = readXmlIO f (return . g)

writeXml :: FilePath -> [Content] -> IO ()
writeXml f g = writeXmlIO f (return g)

withXml :: FilePath -> ([Content] -> [Content]) -> IO ()
withXml f g = withXmlIO f (return . g)

-- arrow variants

readXmlA :: FilePath -> ([Content] :=> b) -> IO [b]
readXmlA f g = readXml f (run g)

readXmlA1 :: FilePath -> (Content :=> b) -> IO (Maybe b)
readXmlA1 f g = readXml f (runSingle (g <<< unlistL))

withXmlA :: FilePath -> ([Content] :=> Content) -> IO ()
withXmlA f g = withXml f (run g)

-- threat as true values

readValue :: Xml a => FilePath -> IO (Maybe a)
readValue f = readXmlA1 f from

writeValue :: Xml a => FilePath -> a -> IO ()
writeValue f v = writeXml f (run to v)

withValue :: Xml a => FilePath -> (a -> a) -> IO ()
withValue f g = withXmlA f (to <<< arr g <<< from <<< unlistL)

