module API.Paragraphs where

import System.Random
import Data.Text (Text)
import Data.Vector
import Prelude hiding (length)

import Data.Kantish (fragments)

type Paragraphs = Vector Text

-- | This needs to be in the IO monad because RNG
paragraphs :: Int -> IO Paragraphs
paragraphs qty = do
    rng <- getStdGen
    start <- getStdRandom $ randomR (0, (length fragments - (qty + 1)))
    let end = start + qty
    return $ slice start end fragments
