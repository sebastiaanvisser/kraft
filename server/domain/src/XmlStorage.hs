{-# LANGUAGE TypeOperators #-}
module XmlStorage where

import Control.Applicative
import Control.DeepSeq
import Control.Arrow
import Control.Arrow.List
import Data.List
import Text.XML.Light
import Text.XML.Light.Convert
import Data.FileStore

type Message = (Description, Author)

readXmlIO :: FileStore -> FilePath -> ([Content] -> IO a) -> IO a
readXmlIO fs f act =
  do xml <- retrieve fs f Nothing
     act (parseXML xml)

writeXmlIO :: FileStore -> FilePath -> Message -> IO [Content] -> IO ()
writeXmlIO fs f (d, a) act =
  do xml <- intercalate "\n" . map ppContent <$> act
     save fs f a d xml

withXmlIO :: FileStore -> FilePath -> Message -> ([Content] -> IO [Content]) -> IO ()
withXmlIO fs f (d, a) act =
  do xml <- retrieve fs f Nothing
     out <- act (parseXML xml)
     case deepseq xml () of
       () -> save fs f a d (intercalate "\n" (map ppContent out))

readXml :: FileStore -> FilePath -> ([Content] -> a) -> IO a
readXml fs f g = readXmlIO fs f (return . g)

writeXml :: FileStore -> FilePath -> Message -> [Content] -> IO ()
writeXml fs f d g = writeXmlIO fs f d (return g)

withXml :: FileStore -> FilePath -> Message -> ([Content] -> [Content]) -> IO ()
withXml fs f d g = withXmlIO fs f d (return . g)

readXmlA :: FileStore -> FilePath -> ([Content] :=> b) -> IO [b]
readXmlA fs f g = readXml fs f (run g)

readXmlA1 :: FileStore -> FilePath -> (Content :=> b) -> IO (Maybe b)
readXmlA1 fs f g = readXml fs f (runSingle (g <<< unlistL))

writeXmlA :: FileStore -> FilePath -> Message -> (() :=> Content) -> IO ()
writeXmlA fs f d g = writeXml fs f d (run g ())

withXmlA :: FileStore -> FilePath -> Message -> ([Content] :=> Content) -> IO ()
withXmlA fs f d g = withXml fs f d (run g)

readValue :: Xml a => FileStore -> FilePath -> IO (Maybe a)
readValue fs f = readXmlA1 fs f fromXml

writeValue :: Xml a => FileStore -> FilePath -> Message -> a -> IO ()
writeValue fs f d v = writeXml fs f d (run toXml v)

withValue :: Xml a => FileStore -> FilePath -> Message -> (a -> a) -> IO ()
withValue fs f d g = withXmlA fs f d (toXml <<< arr g <<< fromXml <<< unlistL)

