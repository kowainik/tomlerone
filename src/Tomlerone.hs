module Tomlerone
       ( runTomlerone
       ) where

import Control.Monad.IO.Class (liftIO)
import Miso (App (..), Effect, View, br_, button_, defaultEvents, div_, noEff, onClick, startApp,
             text, (<#))
import Miso.String (ms)

import qualified Language.Javascript.JSaddle.Warp as JSaddle


runTomlerone :: IO ()
runTomlerone = do
    putStrLn "Working on http://localhost:8000"

    JSaddle.run 8000 $ startApp $ App
        { initialAction = NoEvent
        , model         = defaultModel
        , update        = updateApp
        , view          = viewApp
        , events        = defaultEvents
        , subs          = []
        , mountPoint    = Nothing
        }


type Model = Int

defaultModel :: Model
defaultModel = 0

data Event
    = NoEvent
    | Inc
    | Dec
    | SayHello
    deriving (Eq, Show)

updateApp :: Event -> Model -> Effect Event Model
updateApp event model = case event of
    NoEvent -> noEff model
    Inc     -> noEff $ succ model
    Dec     -> noEff $ pred model
    SayHello -> model <# do
        liftIO $ putStrLn "Hello!"
        pure NoEvent

viewApp :: Model -> View Event
viewApp model = div_ []
    [ text "Tomland Checker"
    , br_ []
    , button_ [ onClick Inc ] [ text "+" ]
    , text $ ms model
    , button_ [ onClick Dec ] [ text "-" ]
    , br_ []
    , button_ [ onClick SayHello ] [ text "Say Hello!" ]
    ]
