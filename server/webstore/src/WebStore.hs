{-# LANGUAGE FlexibleContexts, TypeOperators #-}
module Main where

import Data.FileStore
import Network.Salvia
import Network.Salvia.Handler.ColorLog
import Network.Salvia.Handler.FileStore
import Network.Salvia.Handler.CrossDomain
import Network.Socket (inet_addr, SockAddr (..))
import System.Directory
import System.Environment
import System.IO

main :: IO ()
main =
  do args <- getArgs
     case args of
       [dir] ->
          do setCurrentDirectory dir
             addr <- inet_addr "0.0.0.0"
             start defaultConfig { listenOn = [SockAddrInet 8000 addr] } (hDefaultEnv handler) ()
          where
          handler =
             do hCrossDomainFrom "http://localhost" (hFileStore store author ".")
                hColorLog stdout

       _ -> hPutStrLn stderr
              "Please specify repository directory to expose."

author :: Author
author  = Author "sebas" "root@localhost"

store :: FileStore
store = gitFileStore "."

