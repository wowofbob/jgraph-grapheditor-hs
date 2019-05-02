{-# LANGUAGE OverloadedStrings #-}
module JGraph.CDN.MxGraph
( jGraphCdnMxGraphApplication
) where

import Network.Wai (Application)
import Network.Wai.Application.Static (staticApp, defaultFileServerSettings)

jGraphCdnMxGraphApplication :: FilePath -> Application
jGraphCdnMxGraphApplication = staticApp . defaultFileServerSettings
