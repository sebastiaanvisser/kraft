{-# LANGUAGE TypeOperators #-}
module Text.XML.Light.Trans where

import Control.Arrow
import Control.Arrow.List
import Control.Category
import Data.Either
import Prelude hiding (elem, (.), id)
import Text.XML.Light

qname :: String -> QName
qname n = QName n Nothing Nothing

isElem, isText, isCRef :: Content :=> Content
isElem = cond (\c -> case c of Elem {} -> True; _ -> False)
isText = cond (\c -> case c of Text {} -> True; _ -> False)
isCRef = cond (\c -> case c of CRef {} -> True; _ -> False)

tagQ :: Content :=> QName
tagQ = arr (\(Elem e) -> elName e) . isElem

tag :: Content :=> String
tag = arr qName . tagQ

elemQ :: QName -> Content :=> Content
elemQ q = cond (\(Elem e) -> elName e == q) . isElem

elem :: String -> Content :=> Content
elem n = elemQ (qname n)

children :: Content :=> Content
children = arrL (\(Elem e) -> elContent e) . isElem

child :: String -> Content :=> Content
child s = elem s . children

deep :: (Content :=> c) -> Content :=> c
deep e = e <+> deep e . children

cData :: Content :=> String
cData = arr (\(Text c) -> cdData c) . isText

text :: Content :=> String
text = cData . children

attributes :: Content :=> Attr
attributes = arrL (\(Elem e) -> elAttribs e) . isElem

value :: Attr :=> String
value = arr attrVal

attrQ :: QName -> Content :=> String
attrQ k = value . cond (\a -> attrKey a == k) . attributes

attr :: String -> Content :=> String
attr k = attrQ (qname k)

-----------------------------------

mkElemQ :: QName -> [a :=> Content] -> a :=> Content
mkElemQ n = collectL (\cs -> Elem (Element n [] cs Nothing)) . concatA

mkElem :: String -> [a :=> Content] -> a :=> Content
mkElem n = mkElemQ (qname n)

mkText :: String :=> Content
mkText = arr (\s -> Text (CData CDataText s Nothing))

mkTextElem :: String -> (a :=> String) -> a :=> Content
mkTextElem n a = mkElem n [ mkText . a ]

mkElemAttrQ :: QName -> [a :=> Attr] -> [a :=> Content] -> a :=> Content
mkElemAttrQ n as cs =
  collectL (\c -> Elem (Element n (lefts c) (rights c) Nothing))
    $ (fmap Left (concatA as) <+> fmap Right (concatA cs))

mkElemAttr :: String -> [a :=> Attr] -> [a :=> Content] -> a :=> Content
mkElemAttr n = mkElemAttrQ (qname n)

mkAttrQ :: QName -> String :=> Attr
mkAttrQ k = arr (Attr k)

mkAttr :: String -> String :=> Attr
mkAttr k = mkAttrQ (qname k)

