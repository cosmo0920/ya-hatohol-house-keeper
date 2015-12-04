{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
module Events where

import Prelude hiding (id)
import DataSource (defineTable)

$(defineTable
    []
    "hatohol" "events" [])
