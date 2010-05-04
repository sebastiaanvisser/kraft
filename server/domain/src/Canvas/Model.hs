module Canvas.Model where

import Data.List
import System.Lock.FLock
import Control.Arrow
import Control.Arrow.List
import Text.XML.Light
import Text.XML.Light.Convert
import Canvas.User

data Model = Model 
  { dataDir   :: FilePath
  , userDir   :: FilePath
  , userIndex :: FilePath
  }

makeModel :: FilePath -> Model
makeModel path =
  let userdir = path ++ "/users"
      useridx = userdir ++ "/index.xml"
  in Model { dataDir   = path
           , userDir   = userdir
           , userIndex = useridx
           }

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

readXml :: FilePath -> ([Content] -> a) -> IO a
readXml f g = readXmlIO f (return . g)

writeXml :: FilePath -> [Content] -> IO ()
writeXml f g = writeXmlIO f (return g)

withXml :: FilePath -> ([Content] -> [Content]) -> IO ()
withXml f g = withXmlIO f (return . g)





userUuidByName :: Model -> String -> IO (Maybe String)
userUuidByName mdl uuid =
  readXml (userIndex mdl) (runSingle (uuidByName uuid <<< unlistL))

userByUuid :: Model -> String -> IO (Maybe User)
userByUuid mdl uuid =
  readXml (userDir mdl ++ "/" ++ uuid ++ "/user.xml") (runSingle (from <<< unlistL))

