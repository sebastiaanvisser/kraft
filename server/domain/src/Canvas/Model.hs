module Canvas.Model where

import Canvas.User
import Control.Applicative
import Control.Arrow.List
import Control.Category
import Control.Monad
import Control.Monad.Error
import Data.UUID
import Prelude hiding (elem, (.), id)
import System.Directory
import System.Random
import Text.XML.Light.Convert
import XmlStorage
import qualified Data.Map as Map
import qualified Index
import Data.FileStore

data Model = Model 
  { store :: FileStore
  , dataDir
  , usersDir
  , spacesDir
  , projectsDir
  , invitesDir
  , userNameToUuidIdx
  , userEmailToUuidIdx :: FilePath
  }

emptyModel :: Model
emptyModel = Model undefined "" "" "" "" "" "" ""

makeModel :: FilePath -> Model
makeModel path =
  let m = emptyModel 
        { store       = gitFileStore path
        , dataDir     = path
        , usersDir    = "users"
        , spacesDir   = "spaces"
        , projectsDir = "projects"
        , invitesDir  = "invites"
        }
  in m  { userNameToUuidIdx  = usersDir m ++ "/uuid-by-name.xml"
        , userEmailToUuidIdx = usersDir m ++ "/uuid-by-email.xml"
        }

buildModel :: Model -> IO ()
buildModel m =
  do initialize (store m)
     createDirectoryIfMissing True (usersDir    m)
     createDirectoryIfMissing True (spacesDir   m)
     createDirectoryIfMissing True (projectsDir m)
     createDirectoryIfMissing True (invitesDir  m)
     buildInitialIndexFile m (userNameToUuidIdx  m) "name"  "uuid"
     buildInitialIndexFile m (userEmailToUuidIdx m) "email" "uuid"

myself :: Author
myself = Author "Sebastiaan Visser" "sebas@localhost"

buildInitialIndexFile :: Model -> FilePath -> String -> String -> IO ()
buildInitialIndexFile m f k v =
  doesFileExist f >>= \e -> when (not e) $
    writeXmlA (store m) f rev (toXml . constA (Index.empty k v))
  where rev = ("Build index file: " ++ v ++ "-by-" ++ k, myself)

-- userByUuid :: Model -> String -> IO (Maybe User)
-- userByUuid m uid = readValue (userDir m ++ "/" ++ uid ++ "/user.xml")

-- doesUserExist :: Model -> Email -> IO Bool
-- doesUserExist m mail =
--   do doesFileExist (usersDir

data UserError = UserNotFound
instance Error UserError

userUuidByEmail :: Model -> String -> IO (Either UserError (Maybe String))
userUuidByEmail m mail = runErrorT $
  do idx <- lift $ readValue (store m) (userEmailToUuidIdx m)
     case idx of
       Just i  -> return (Map.lookup mail (Index.mapping i))
       Nothing -> throwError UserNotFound

createUser :: Model -> String -> String -> String -> String -> IO ()
createUser m n e p i =
  do uid <- show <$> (randomIO :: IO UUID)
     let user = User uid n e p i
         rev0 = ("Build user: " ++ e,                     myself)
         rev1 = ("Updated index uuid-by-name for:" ++ n,  myself)
         rev2 = ("Updated index uuid-by-email for:" ++ e, myself)
     writeValue (store m) (usersDir m ++ "/" ++ uid ++ ".xml") rev0 user
     withValue  (store m) (userNameToUuidIdx  m)               rev1 (Index.with (Map.insert n uid))
     withValue  (store m) (userEmailToUuidIdx m)               rev2 (Index.with (Map.insert e uid))

