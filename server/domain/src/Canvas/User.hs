{-# LANGUAGE
    TemplateHaskell
  , EmptyDataDecls
  , TypeFamilies
  , TypeOperators
  #-}
module Canvas.User where

import Control.Applicative
import Control.Arrow
import Control.Arrow.List
import Control.Category
import Generics.Regular
import Prelude hiding (elem, (.), id)
import Text.XML.Light
import Text.XML.Light.Convert
import Text.XML.Light.Trans

data User = User
  { name     :: String
  , email    :: String
  , password :: String
  , image    :: String
  } deriving (Show, Eq, Ord)

$(deriveAll ''User "PFUser")
type instance PF User = PFUser

instance Xml User where
  from = User
    <$> text . child "name"
    <*> text . child "email"
    <*> text . child "password"
    <*> text . child "image"
  to = mkElem "user"
    [ mkTextElem "name"     (arr name)
    , mkTextElem "email"    (arr email)
    , mkTextElem "password" (arr password)
    , mkTextElem "image"    (arr image)
    ]

uuidByName :: String -> Content :=> String
uuidByName n = attr "uuid" . isA (is n . text) . child "name" . elem "uuid-by-name"

-- userByName :: String -> Content :=> User
-- userByName n = 
--   do uuid <- uuidByName n
--      from . isA (is uuid . attr "uuid") . child "user" . elem "users"

-- uuidByEmail :: String -> Content :=> String
-- uuidByEmail n = attr "uuid" . isA (is n . text) . child "email" . child "by-email" . elem "users"

