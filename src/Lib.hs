{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( serve
    ) where


import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Control.Monad.IO.Class
import Data.Monoid
import Data.IORef
import qualified Data.Text as T

import Views.Index
import API.Paragraphs

data MySession = EmptySession
data MyAppState = DummyAppState ()

serve :: IO ()
serve = do
    spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ())
    runSpock 8880 (spock spockCfg app)

app :: SpockM () MySession MyAppState ()
app = do
    get root $ html index
    get ("paragraphs" <//> var ,"qty") $ \qty -> do
        payload <- liftIO $ paragraphs qty
        json payload
