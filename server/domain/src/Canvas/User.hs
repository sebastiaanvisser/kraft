{-# LANGUAGE
    TemplateHaskell
  , EmptyDataDecls
  , TypeFamilies
  #-}
module Canvas.User where

import Control.Applicative
import Control.Arrow
import Control.Category
import Generics.Regular
import Prelude hiding (elem, (.), id)
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

