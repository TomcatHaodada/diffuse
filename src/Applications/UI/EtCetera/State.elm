module UI.EtCetera.State exposing (..)

import Alien
import Common exposing (Switch(..))
import Monocle.Lens as Lens
import Notifications
import Return
import Return.Ext as Return
import Time
import UI.Authentication as Authentication
import UI.Common.State as Common
import UI.Ports as Ports
import UI.Sources.State as Sources
import UI.Types as UI exposing (..)
import User.Layer exposing (..)



-- 🔱


setIsOnline : Bool -> Manager
setIsOnline bool model =
    if bool then
        -- We're caching the user's data in the browser while offline.
        -- If we're back online again, sync all the user's data.
        (case model.authentication of
            Authentication.Authenticated (Dropbox _) ->
                syncHypaethralData

            Authentication.Authenticated (RemoteStorage _) ->
                syncHypaethralData

            _ ->
                Return.singleton
        )
            { model | isOnline = True }

    else
        -- The app went offline, cache everything
        -- (if caching is supported).
        ( { model | isOnline = False }
        , case model.authentication of
            Authentication.Authenticated (Dropbox _) ->
                Ports.toBrain (Alien.trigger Alien.SyncHypaethralData)

            Authentication.Authenticated (RemoteStorage _) ->
                Ports.toBrain (Alien.trigger Alien.SyncHypaethralData)

            _ ->
                Cmd.none
        )


setCurrentTime : Time.Posix -> Manager
setCurrentTime time model =
    model
        |> (\m -> { m | currentTime = time })
        |> Lens.modify Sources.lens (\s -> { s | currentTime = time })
        |> Return.singleton



-- ⚗️


syncHypaethralData : Manager
syncHypaethralData model =
    model
        |> Common.showNotification (Notifications.warning "Syncing")
        |> Return.command (Ports.toBrain <| Alien.trigger Alien.SyncHypaethralData)
