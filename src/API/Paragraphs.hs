{-# LANGUAGE OverloadedStrings #-}

module API.Paragraphs where

import System.Random
import Data.Text (Text)
import Data.Vector
import Prelude hiding (length)

import Data.Kantish (fragments)

type Paragraphs = Vector Text

-- | This needs to be in the IO monad because RNG
paragraphs :: Int -> IO Paragraphs
paragraphs qty
  | qty > length fragments = return mempty
  | otherwise = do
    if qty > length fragments then return "" else return mempty
    rng <- getStdGen
    start <- getStdRandom $ randomR (0, (length fragments - (qty + 1)))
    return $ slice start qty fragments
