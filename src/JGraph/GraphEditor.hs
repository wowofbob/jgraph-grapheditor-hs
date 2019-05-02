{-# LANGUAGE OverloadedStrings #-}
module JGraph.GraphEditor
( jGraphGraphEditorMiddleware
, jGraphGraphEditorApplication
) where

import Network.Wai (Application, Middleware, requestMethod, responseLBS)
import Network.HTTP.Types (methodGet, methodHead, status400)
import Network.Wai.Application.Static (staticApp, defaultFileServerSettings)

-- Intercept GET or HEAD request to serve grapheditor's resources.
jGraphGraphEditorMiddleware :: FilePath -> Middleware
jGraphGraphEditorMiddleware graphEditorResourcesFilePath application = let
  serveGraphEditorResources = staticApp
    (defaultFileServerSettings graphEditorResourcesFilePath)
  in \request respond -> let
    method = requestMethod request
    in (if method == methodGet || method == methodHead
      then serveGraphEditorResources
      else application) request respond

jGraphGraphEditorApplication :: Application
jGraphGraphEditorApplication =
  -- Should handle few grapheditor specific requests
  -- like POST on /open. Not sure what should be done
  -- actually, but we'll be ready (later).
  \_ respond -> respond $ responseLBS status400 [] ""
