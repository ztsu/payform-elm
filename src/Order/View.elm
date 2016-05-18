module Order.View exposing (packet)

import Billing.Model
import Html exposing (div, text, span, select, option, input, ul, li, label)
import Html.Attributes exposing (type', name)

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

region region =
  div [] [ text <| "Регион: " ++ region.name ]

period period =
  div [] [ text "Период: ", periodValue period.value, periodUnit period.unit ]

periodValue value =
  case value of
    Billing.Model.PeriodRange range -> div [] [text ("range" ++ "test")]
    Billing.Model.PeriodList list -> select [] (List.map (\n -> option [] [text <| toString n]) list)

periodUnit unit =
  case unit of
    Billing.Model.Hour -> text "час"
    Billing.Model.Day -> text "день"
    Billing.Model.Month -> text "месяц"

services services =
  ul [] (List.map service services)


service service =
  li [] [ text service.alias ]


{-|-}
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
