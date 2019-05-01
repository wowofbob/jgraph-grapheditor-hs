{-# LANGUAGE OverloadedStrings #-}
module Main where

import JGraph.CDN.MxGraph
import JGraph.GraphEditor

import Control.Applicative

import Network.Wai.UrlMap
import Network.Wai.Handler.Warp (run)

main = run 3000 $
  mapUrls $ mount "cdn"
    (
      mount "mxgraph" (jGraphCdnMxGraphApplication "data/mxgraph")
    )
  <|> mountRoot (jGraphGraphEditorApplication "data/grapheditor")
