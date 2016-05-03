import Html exposing (Html, div, text)

import Billing.Packet
import Order.View

packet1 : Billing.Packet.Packet
packet1 =
  { id = 1
  , name = "Тест"
  , packetType = {alias = "kd", name = "Коммерческий доступ"}
  , project = {id = 1, alias = "job", name = "Работа"}
  , client = Billing.Packet.User
  , region = {id = 66, name = "Свердловская область"}
  , period = {unit = Billing.Packet.Day, value = Billing.Packet.PeriodList [1, 3, 5]}
  , services = [{alias = "limit", changebale = True, visible = True, unit = Nothing, value = Billing.Packet.ServiceInt { min = 1, max = 10, default = 1} }]
  }



main : Html.Html
main =
  div [] [ Order.View.packet packet1 ]
