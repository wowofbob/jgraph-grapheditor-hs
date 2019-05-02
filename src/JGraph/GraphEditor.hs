{-# LANGUAGE OverloadedStrings #-}
module JGraph.GraphEditor
( jGraphGraphEditorApplication
) where

import Network.Wai (Application, requestMethod, responseLBS)
import Network.HTTP.Types (methodGet, status405)
import Network.Wai.Application.Static (staticApp, defaultFileServerSettings)

import qualified Data.Map.Lazy as Map

jGraphGraphEditorApplication :: FilePath -> Application
jGraphGraphEditorApplication graphEditorFilePath = let
  serveGraphEditorResources = staticApp (defaultFileServerSettings graphEditorFilePath)
  in \request respond -> case
    Map.lookup
      (requestMethod request)
      (Map.fromList
        [ (methodGet, serveGraphEditorResources request respond)
        ])
    of
      Just result -> result
      Nothing     -> respond $ responseLBS status405 [] ""
