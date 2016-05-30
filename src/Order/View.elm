module Order.View exposing (..)

import Html exposing (Html, div, text, span, select, option, input, ul, li, label)
import Html.Attributes exposing (type', name)

import Billing.Model
import Order.Model exposing (Model)


view : Model -> Html Order.Model.Msg
view model =
  div []
  [ div [] [ text <| "Тарифы (" ++ (toString <| List.length model.packets) ++ "):"]
  , div [] (List.map packet model.packets)
  , div [] (List.map text model.errors)
  ]


packet : Billing.Model.Packet -> Html Order.Model.Msg
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


region : Billing.Model.Region -> Html Order.Model.Msg
region region =
  div [] [ text <| "Регион: " ++ region.name ]


period : Billing.Model.Period -> Html Order.Model.Msg
period period = case period of
  Billing.Model.OneTime ->
    div [] [ text "Одноразово" ]

  Billing.Model.Period unit value ->
    div [] [ text "Период: ", periodValue value, periodUnit unit ]


periodValue : Billing.Model.PeriodValue -> Html Order.Model.Msg
periodValue value =
  case value of
    Billing.Model.PeriodRange range -> div [] [text ("range" ++ "test")]
    Billing.Model.PeriodList list -> select [] (List.map (\n -> option [] [text <| toString n]) list)

periodUnit : Billing.Model.PeriodUnit -> Html Order.Model.Msg
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
beginDate : Html Order.Model.Msg
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
