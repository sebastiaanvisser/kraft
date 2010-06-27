{-# LANGUAGE
    TemplateHaskell
  , EmptyDataDecls
  , TypeFamilies
  , TypeOperators
  #-}
module Canvas.User where

import Control.Applicative
import Control.Arrow
import Control.Category
import Data.Record.Label
import Generics.Regular
import Prelude hiding (elem, (.), id)
import Text.XML.Light.Convert
import Text.XML.Light.Trans

type Email = String

data User = User
  { _uuid     :: String
  , _name     :: String
  , _email    :: Email
  , _password :: String
  , _image    :: String
  } deriving (Show, Eq, Ord)

$(deriveAll ''User "PFUser")
type instance PF User = PFUser

$(mkLabels [''User])

instance Xml User where
  fromXml = User
    <$> text . child "uuid"
    <*> text . child "name"
    <*> text . child "email"
    <*> text . child "password"
    <*> text . child "image"
  toXml = mkElem "user"
    [ mkTextElem "uuid"     (arr (getL uuid))
    , mkTextElem "name"     (arr (getL name))
    , mkTextElem "email"    (arr (getL email))
    , mkTextElem "password" (arr (getL password))
    , mkTextElem "image"    (arr (getL image))
    ]


{-

uuidByName :: String -> Content :=> String
uuidByName n = attr "uuid" . isA (is n . text) . child "name" . elem "uuid-by-name"

-}

-- userByName :: String -> Content :=> User
-- userByName n = 
--   do uuid <- uuidByName n
--      from . isA (is uuid . attr "uuid") . child "user" . elem "users"

-- uuidByEmail :: String -> Content :=> String
-- uuidByEmail n = attr "uuid" . isA (is n . text) . child "email" . child "by-email" . elem "users"

