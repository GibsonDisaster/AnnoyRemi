module Main where
  import qualified Data.ByteString as B
  import System.Environment (getArgs)
  import Network.HTTP
  import Network.URI (parseURI)

  main :: IO ()
  main = do
    a <- getArgs
    downloadPic (checkInput a)

  checkInput :: [String] -> Int
  checkInput [] = 1
  checkInput (x:xs) = read x

  downloadPic :: Int -> IO ()
  downloadPic num = do
    file <- getArgs
    jpg <- get "http://i.pinimg.com/originals/66/29/33/662933b895ae8aee0447cc0370c93e9d.jpg"
    B.writeFile ("coolpic" ++ (show num) ++ ".jpg") jpg
    if (num == 1) then return () else downloadPic (num-1)
      where
        get url = let uri = case parseURI url of
                              Nothing -> error $ "Invalid URI: " ++ url
                              Just u -> u in
                  simpleHTTP (defaultGETRequest_ uri) >>= getResponseBody