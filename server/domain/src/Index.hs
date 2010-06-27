{-# LANGUAGE TypeOperators #-}
module Index where

import Control.Applicative
import Control.Arrow
import Control.Arrow.List
import Control.Category
import Data.List.Split
import Data.Map
import Prelude hiding (elem, (.), id)
import Text.XML.Light
import Text.XML.Light.Convert
import Text.XML.Light.Trans
import qualified Data.Map as Map

data Index = Index
  { key, value :: String
  , mapping    :: Map String String
  } deriving Show

with :: (Map String String -> Map String String) -> Index -> Index
with f (Index k v m) = Index k v (f m)

instance Xml Index where
   fromXml = from
   toXml   = to

from :: Content :=> Index
from =
  do (v, k) <- tuple . arr (splitOn "-by-") . tag
     collectL (Index k v . fromList)
       $ ((,) <$> text <*> attr v) . child k

to :: Index :=> Content
to =
  do Index k v _ <- id
     mkElem (v ++ "-by-" ++ k)
       [ mkElemAttr k
           [ mkAttr v . arr snd ]
           [ mkText   . arr fst ]
         . arrL (toList . mapping)
       ]

empty :: String -> String -> Index
empty k v = Index k v Map.empty

test :: Index
test = Index "name" "uuid" (fromList [("hallo", "23423"),("doei", "hahaha"),("aap", "kip")])

