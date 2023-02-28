import Control.Concurrent
import System.Process
import Control.Monad (void)

main :: IO ()
main = callMeDaddy

callMeDaddy = do
    callJS
    callMeDaddy


callJS :: IO ()
callJS = do
    myT <- myThreadId
    print $ "generating new thread" <> show myT
    void . forkIO . void . spawnCommand $ "node ./client2.js " <> show myT