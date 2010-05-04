{-# LANGUAGE TypeOperators, Arrows #-}
module Test where

-- import Control.Arrow.List
-- import Control.Category
-- import Prelude hiding (elem, (.), id)
-- import Text.XML.Light
-- import Text.XML.Light.Trans
-- import Text.XML.Light.Convert
-- import Canvas.User
import Canvas.Model

main :: IO ()
main =
  do let mdl = makeModel "../../../data"
     uuid <- userUuidByName mdl "sebas"
     case uuid of
       Nothing -> putStrLn "error: no such user in index"
       Just u  -> userByUuid mdl u >>= print

