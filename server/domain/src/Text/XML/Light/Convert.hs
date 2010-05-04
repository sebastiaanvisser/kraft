{-# LANGUAGE TypeOperators  #-}
module Text.XML.Light.Convert where

import Control.Arrow.List
import Text.XML.Light

class Xml a where
  from :: Content :=> a
  to   :: a :=> Content

