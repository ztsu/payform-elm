module Order.Model exposing (Model, Msg, init, update, subscriptions)

import Json.Decode

import Billing.Model
import Billing.Rest
import Http
import Task
import Http


type Msg
  = FetchSucceed (List Billing.Model.Packet)
  | FetchFail Http.Error


type alias Model =
  { packets: List Billing.Model.Packet
  , errors : List String
  }

init =
  ( Model [] []
  , getPackets
  )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  let
    caseError error =
      case error of
        Http.UnexpectedPayload str -> str
        _ -> "Другая ошибка"

  in
    case msg of

      FetchFail error ->
        ({ model | errors = List.append model.errors [caseError error] }, Cmd.none)

      FetchSucceed packets ->
        ({ model | packets = packets}, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


getPackets : Cmd Msg
getPackets =
  let
    url = "https://pay.ngs.ru/api/v1/packets/"
  in
    Task.perform FetchFail FetchSucceed (Http.get decodePackets url)


decodePackets : Json.Decode.Decoder (List Billing.Model.Packet)
decodePackets =
  Json.Decode.at ["packets"] <| Json.Decode.list <| Billing.Rest.decodePacket
