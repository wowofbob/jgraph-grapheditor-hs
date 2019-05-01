{-# LANGUAGE OverloadedStrings #-}
module JGraph.CDN.MxGraph
( jGraphCdnMxGraphApplication
) where

import System.FilePath

import Network.Wai
import Network.HTTP.Types

import qualified Data.Text as Text
import qualified Data.Text.Encoding as TextEncoding

jGraphCdnMxGraphApplication :: FilePath -> Application
jGraphCdnMxGraphApplication mxGraphFilePath = \request respond ->
  respond $
    if requestMethod request == methodGet
      then let
        filePath = mxGraphFilePath ++ Text.unpack (TextEncoding.decodeUtf8 (rawPathInfo request)) 
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
      else responseLBS status400 [] ""
