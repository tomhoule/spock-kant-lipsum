{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( serve
    ) where


import Web.Spock hiding (static)
import Web.Spock.Config

import Control.Monad.Trans
import Control.Monad.IO.Class
import Data.Monoid
import Data.IORef
import qualified Data.Text as T
import Network.Wai.Middleware.Static (staticPolicy, hasPrefix)

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
    middleware $ staticPolicy (hasPrefix "css")
    get root $ html $ index Nothing
    post root $ do
        qty <- param "paragraphs"
        txt <- liftIO $ mapM paragraphs qty
        html $ index txt
    get ("paragraphs" <//> var) $ \qty -> do
        payload <- liftIO $ paragraphs qty
        json payload
