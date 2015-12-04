{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module ActionLogs where

import Prelude hiding (id)
import DataSource (defineTable)

$(defineTable
    []
    "hatohol" "action_logs" [])
