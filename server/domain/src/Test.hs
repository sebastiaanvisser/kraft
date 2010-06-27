{-# LANGUAGE TypeOperators #-}
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
  do let mdl = makeModel "../../_data"
     buildModel mdl
     createUser mdl "Sebastiaan Visser" "s@fvisser.nl" "geheim" "none"
     createUser mdl "Nog iemand anders" "t@fvisser.nl" "geheim" "none"
     createUser mdl "Tja, wat wil je r" "v@fvisser.nl" "geheim" "none"
     createUser mdl "Kippensoep en sne" "h@fvisser.nl" "geheim" "none"

