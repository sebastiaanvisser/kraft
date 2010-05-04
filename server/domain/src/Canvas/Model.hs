module Canvas.Model where

-- import Control.Arrow
-- import Control.Arrow.List
-- import Text.XML.Light
-- import Text.XML.Light.Convert
import XmlStorage
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

userUuidByName :: Model -> String -> IO (Maybe String)
userUuidByName mdl uuid = readXmlA1 (userIndex mdl) (uuidByName uuid)

userByUuid :: Model -> String -> IO (Maybe User)
userByUuid mdl uuid = readValue (userDir mdl ++ "/" ++ uuid ++ "/user.xml")

