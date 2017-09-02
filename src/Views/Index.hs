{-# LANGUAGE OverloadedStrings #-}

module Views.Index where

import Text.Blaze.Html5 as H
import Text.Blaze.Html.Renderer.Text
import Data.Text.Lazy (toStrict)
import Data.Text

index :: Text
index = toStrict $ renderHtml $ H.html $ do
    H.body $ do
        H.h1 $ H.text "O, hi"
        H.div $ do
            H.text "This app was inspired by and uses code and samples from Enrico Gregorio’s"
            H.text "kantlipsum package"
            H.text "for LaTeX"
