module API.Paragraphs where

import Data.ByteString (ByteString)
import Data.Vector
import Prelude hiding (length)

import Data.Kantish (fragments)

type Paragraphs = Vector ByteString

-- | This needs to be in the IO monad because RNG
paragraphs :: Int -> IO Paragraphs
paragraphs qty = do
    start <- getRandom (0, (length fragments - (qty + 1)))
    let end = start + qty
    return $ slice start end fragments
