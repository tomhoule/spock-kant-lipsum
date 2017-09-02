{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( serve
    ) where


import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T

import Views.Index

data MySession = EmptySession
data MyAppState = DummyAppState ()

serve :: IO ()
serve = do
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ())
    runSpock 8880 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app = do
    get root $ html index
