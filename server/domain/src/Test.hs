{-# LANGUAGE TypeOperators, Arrows #-}
module Test where

import Control.Arrow.List
import Control.Category
import Prelude hiding (elem, (.), id)
import Text.XML.Light
import Text.XML.Light.Trans
import Text.XML.Light.Convert
import Canvas.User

main :: IO ()
main = 
  do file <- readFile "../../../data/users/users-by-name-and-email.xml"
     let xml = parseXML file
         usr = run (userByName "sebas" . unlistL) xml
         bck = run (to . unlistL) usr
     mapM_ print usr
     putStrLn "---------------"
     mapM_ (putStrLn . ppContent) bck

uuidByName :: String -> Content :=> String
uuidByName n = attr "uuid" . isA (is n . text) . child "name" . child "by-name" . elem "users"

uuidByEmail :: String -> Content :=> String
uuidByEmail n = attr "uuid" . isA (is n . text) . child "email" . child "by-email" . elem "users"

userByName :: String -> Content :=> User
userByName n = 
  do uuid <- uuidByName n
     from . isA (is uuid . attr "uuid") . child "user" . elem "users"

