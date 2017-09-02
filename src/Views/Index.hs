{-# LANGUAGE OverloadedStrings #-}

module Views.Index where

import Text.Blaze.Html5 as H
import Text.Blaze.Html.Renderer.Text
import Data.Text.Lazy (toStrict)
import Data.Text

index :: Text
index = toStrict $ renderHtml $ H.h1 $ H.text "O, hi"
