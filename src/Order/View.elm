module Order.View where

import Billing.Packet as Packet
import Html exposing (Html, div, text, span, select, option, input, ul, li, label)
import Html.Attributes exposing (type', name)

packet : Packet.Packet -> Html
packet packet =
  div []
    [ div []
      [ input [type' "checkbox"] []
      , text packet.packetType.name
      ]
      , region packet.region
      , period packet.period
      , beginDate
      , services packet.services
    ]

region : Packet.Region -> Html
region region =
  div [] [ text <| "Регион: " ++ region.name ]

period : Packet.Period -> Html
period period =
  div [] [ text "Период: ", periodValue period.value, periodUnit period.unit ]

periodValue : Packet.PeriodValue -> Html
periodValue value =
  case value of
    Packet.PeriodRange range -> div [] [text ("range" ++ "test")]
    Packet.PeriodList list -> select [] (List.map (\n -> option [] [text <| toString n]) list)

periodUnit : Packet.PeriodUnit -> Html
periodUnit unit =
  case unit of
    Packet.Hour -> text "час"
    Packet.Day -> text "день"
    Packet.Month -> text "месяц"

services : List Packet.Service -> Html
services services =
  ul [] (List.map service services)


service : Packet.Service -> Html
service service =
  li [] [ text service.alias ]

beginDate : Html
beginDate =

  div []
  [ label []
      [ input [ type' "radio", name "1"] []
      , span [] [text "с момента оплаты"]
      ]
  , label []
      [ input [ type' "radio", name "1" ] []
      , span [] [text "выбрать дату"]
      ]
  ]
