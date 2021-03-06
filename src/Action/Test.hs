{-# LANGUAGE ViewPatterns, TupleSections, RecordWildCards, ScopedTypeVariables, PatternGuards #-}

module Action.Test(actionTest) where

import Query
import Action.CmdLine
import Action.Search
import Action.Server
import General.Util
import Input.Type
import System.IO.Extra

import Control.Monad
import Output.Items
import General.Store
import Control.DeepSeq
import Control.Exception


actionTest :: CmdLine -> IO ()
actionTest Test{..} = withBuffering stdout NoBuffering $ do
    putStrLn "Quick tests"
    general_util_test
    input_type_test
    query_test
    action_search_test
    action_server_test
    putStrLn ""
    when deep $ storeReadFile "output/all.hoo" $ \store -> do
        putStrLn "Deep tests"
        let xs = map itemItem $ listItems store
        evaluate $ rnf xs
        putStrLn $ "Loaded " ++ show (length xs) ++ " items"

