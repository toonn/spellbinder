#! /usr/bin/env nix-shell
#! nix-shell -i runghc
#! nix-shell -p "haskellPackages.ghcWithPackages (ps: [ ps.optparse-applicative ps.text ])"

{-# LANGUAGE OverloadedStrings #-}

import Options.Applicative
import Data.Semigroup ((<>))
import qualified Data.Text as T
import qualified Data.Text.IO as T
import Data.Char
import Data.List

data Args = Args { root      :: FilePath
                 , bindFiles :: [FilePath]
                 }

args :: Parser Args
args = Args
    <$> strOption
        ( long "root"
       <> short 'r'
       <> metavar "PATH"
       <> help "Root location of the resultant tree" )
    <*> some (strOption
        ( long "binds"
       <> short 'b'
       <> metavar "PATH"
       <> help "Declarative configuration to realize" ))

data Bind = Bind { source :: FilePath
                 , target :: FilePath
                 }

data Binds = Binds { existing  :: [Bind]
                   , necessary :: [Bind]
                   , redundant :: [Bind]
                   }

readBinds :: FilePath -> [FilePath] -> IO [Bind]
readBinds = undefined

readMountpoints :: FilePath -> IO [FilePath]
readMountpoints = undefined

removeMount :: FilePath -> IO ()
removeMount mountpoint = undefined

removeMountpoint :: FilePath -> IO ()
removeMountpoint mountpoint = undefined

removeBind :: Bind -> IO ()
removeBind bind = removeMount tgt >> removeMountpoint tgt
  where tgt = target bind

createMountpoint :: FilePath -> IO ()
createMountpoint mountpoint = undefined

createBind :: Bind -> IO ()
createBind bind = createMountpoint (target bind)

reconcile :: [FilePath] -> [Bind] -> Binds
reconcile mountpoints binds = undefined

type Rule = String

createRule :: Bind -> Rule
createRule bind =
  intercalate "  " [source bind, target bind, "none", "ro,bind"]

replaceFSTab :: [Bind] -> IO ()
-- TODO: include # generated by comment.
replaceFSTab bs = undefined

mountFSTab :: IO ()
mountFSTab = undefined

run :: Args -> IO ()
run as = do
  desiredBinds <- readBinds (root as) (bindFiles as)
  mountpoints <- readMountpoints (root as)
  let binds = reconcile mountpoints desiredBinds 
  mapM removeBind (redundant binds)
  mapM createBind (necessary binds)
  replaceFSTab (necessary binds <> existing binds)
  mountFSTab

main :: IO ()
main = run =<< execParser opts
  where
    versionOption = infoOption "Spellbinder version 1.0" (long "version" <>
                      short 'V' <> help "Show version")
    opts = info (args <**> helper <**> versionOption)
      ( fullDesc
     <> progDesc "Declaratively manage bind mounts"
     <> header "spellbinder - A declarative bind mount manager" )
