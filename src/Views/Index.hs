{-# LANGUAGE OverloadedStrings #-}

module Views.Index where

import Data.Foldable (foldr)
import Data.Maybe (maybe)
import API.Paragraphs
import Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes as A
import Text.Blaze.Html.Renderer.Text
import Data.Text.Lazy (toStrict)
import Data.Text (Text, pack)
import Data.Monoid ((<>))
import Text.Blaze.Html
import Prelude hiding (length)
import Data.Vector (length)

klass = A.class_

displayParagraphs :: Paragraphs -> Html
displayParagraphs pars = H.textarea ! klass "textarea lipsum" $ H.text $ foldr (\acc par -> acc <> "\n\n" <> par) "" pars

defaultValue :: Maybe Paragraphs -> Text
defaultValue = maybe "4" (pack . show . length)

index :: Maybe Paragraphs -> Text
index out = toStrict $ renderHtml $ H.docTypeHtml $ do
  H.head $ do
    H.title "kantlipsum"
    H.link ! (A.href "/css/index.css" <> A.rel "stylesheet")
  H.body $ do
    H.section ! klass "hero is-primary is-medium is-bold" $ do
      H.div ! klass "hero-body" $ do
        H.div ! klass "container" $ do
          H.h1 ! klass "title" $ H.text "kantlipsum"
          H.h2 ! klass "subtitle" $ H.text "bringing lorem ipsum to the noumenal world"
          H.div $ H.text "“Phenomenal” - Salomon Maimon"
    H.div ! klass "section" $ do
      H.div ! A.class_ "container" $ do
        H.form ! (A.action "/" <> A.method "post") $
          H.div ! klass "is-horizontal field" $ do
            H.div ! klass "field-label is-normal" $ do
              H.label ! klass "label" $ do
                H.text "Number of paragraphs"
            H.div ! klass "field-body" $ do
              H.div ! klass "field has-addons" $ do
                H.p ! klass "control" $ do
                  H.input ! (klass "input" <> A.value (textValue $ defaultValue out) <> A.type_ "text" <> A.name "paragraphs")
                H.p ! klass "control" $ do
                  H.button ! klass "button" $ H.text "Ratiocinate!"
        H.div $ maybe mempty displayParagraphs out
    H.section ! klass "footer" $ do
      H.div ! klass "container" $ do
        H.div ! klass "content has-text-centered" $ do
          H.p $ do
            H.text "This app was inspired by and uses code and samples from Enrico Gregorio’s"
            H.a ! A.href "https://www.ctan.org/pkg/kantlipsum" $ H.text " kantlipsum package"
            H.text " for LaTeX"
          H.p $ do
            H.text "Made with love and moral certainty by "
            H.a ! A.href "https://twitter.com/_tomhoule" $ H.text "@_tomhoule"
          H.p $ do
            H.a ! A.href "https://github.com/tomhoule/spock-kant-lipsum" $ H.text "Browse source on Github"
