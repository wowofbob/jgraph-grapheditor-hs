{-# LANGUAGE OverloadedStrings #-}
module JGraph.GraphEditor
( jGraphGraphEditorApplication
) where

import System.FilePath

import Network.Wai
import Network.HTTP.Types

import qualified Data.Map.Lazy as Map

import qualified Data.Text as Text
import qualified Data.Text.Encoding as TextEncoding

jGraphGraphEditorApplication :: FilePath -> Application
jGraphGraphEditorApplication graphEditorFilePath = \request respond ->
  respond $ case
    Map.lookup
      (requestMethod request)
      (Map.fromList
        [ ( methodGet
          , let
              filePath = graphEditorFilePath ++ Text.unpack (TextEncoding.decodeUtf8 (rawPathInfo request)) 
            in responseFile
                 status200
                 [
                   ( "Content-Type"
                   , case takeExtension filePath of
                       ".css"  -> "text/css"
                       ".html" -> "text/html"
                       ".js"   -> "application/javascript"
                       _       -> "text/plain"
                   )
                 ]
                 filePath
                 Nothing
          )
        ])
  of
    Nothing       -> responseLBS status400 [] ""
    Just response -> response
