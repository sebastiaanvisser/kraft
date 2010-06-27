{-# LANGUAGE TypeOperators #-}
module Control.Arrow.List where

import Data.Monoid
import Control.Monad
import Control.Applicative
import Control.Arrow
import Control.Category
import Prelude hiding (elem, (.), id)

newtype a :=> b = L { run :: a -> [b] }

instance Category (:=>) where
  id    = L pure
  a . b = L (run a <=< run b)

instance Arrow (:=>) where
  arr   f = L (pure . f)
  first f = L (\(a, b) -> map (flip (,) b) (run f a) )

instance ArrowZero (:=>) where
  zeroArrow = L (const mempty)

instance ArrowPlus (:=>) where
  a <+> b = L (\n -> run a n ++ run b n)

class ArrowList (~>) where
  arrL :: (a -> [b]) -> a ~> b

instance ArrowList (:=>) where
  arrL = L

instance Functor ((:=>) a) where
  fmap f (L l) = L (map f . l)

instance Applicative ((:=>) a) where
  pure a      = L (const [a])
  L a <*> L b = L (\i -> zipWith ($) (a i) (b i))

instance Monad ((:=>) a) where
  return = pure
  L a >>= b = L (\x -> a x >>= (\z -> run (b z) x))

constA :: Arrow (~>) => b -> a ~> b
constA = arr . const

runSingle :: (a :=> b) -> a -> Maybe b
runSingle a i = let b = run a i in if null b then Nothing else Just (head b)

concatA :: ArrowPlus (~>) => [a ~> b] -> a ~> b
concatA = foldl (<+>) zeroArrow

mapL :: ([b] -> [c]) -> (a :=> b) -> a :=> c
mapL f a = L (f . run a)

collectL :: ([b] -> c) -> (a :=> b) -> a :=> c
collectL f = mapL (pure . f)

constL :: [b] -> a :=> b
constL = arrL . const 

unlistL :: [b] :=> b
unlistL = arrL id

cond :: ArrowList (~>) => (a -> Bool) -> a ~> a
cond f = arrL (\c -> if f c then pure c else mempty)

is :: Eq a => a -> a :=> a
is s = cond (==s)

might :: (a -> Maybe b) -> a :=> b
might f = arrL (maybe mempty pure . f)

isA :: (a :=> b) -> a :=> a
isA c = const <$> id <*> c

nullL :: (a :=> b) -> a :=> Bool
nullL = mapL (pure . null)

notA :: (a :=> b) -> a :=> a
notA a = const <$> id <*> cond id . nullL a

tuple :: [a] :=> (a, a)
tuple = might (\xs -> case xs of [a,b] -> Just (a,b); _ -> Nothing)

