module Billing.Rest where

import Json.Decode exposing ((:=))

import Billing.Model

--

(&=) : Json.Decode.Decoder (a -> b) -> Json.Decode.Decoder a -> Json.Decode.Decoder b
(&=) func value =
  Json.Decode.object2 (<|) func value

-- Decoders

decodePacketType : Json.Decode.Decoder Billing.Model.PacketType
decodePacketType =
  Json.Decode.object2 Billing.Model.PacketType
    ("alias" := Json.Decode.string)
    ("title" := Json.Decode.string)


decodeProject : Json.Decode.Decoder Billing.Model.Project
decodeProject =
  Json.Decode.object3 Billing.Model.Project
    ("id" := Json.Decode.int)
    ("alias" := Json.Decode.string)
    ("name" := Json.Decode.string)


decodeRegion : Json.Decode.Decoder Billing.Model.Region
decodeRegion =
  Json.Decode.object2 Billing.Model.Region
    ("id" := Json.Decode.int)
    ("name" := Json.Decode.string)


decodeClient : Json.Decode.Decoder Billing.Model.ClientType
decodeClient =
  Json.Decode.string `Json.Decode.andThen` \client ->
    case client of
      "user" -> Json.Decode.succeed Billing.Model.User
      _ -> Json.Decode.fail "client doesnt't recognized"


decodePeriodUnit : Json.Decode.Decoder Billing.Model.PeriodUnit
decodePeriodUnit =
  Json.Decode.string `Json.Decode.andThen` \unit ->
    case unit of
      "hour" -> Json.Decode.succeed Billing.Model.Hour
      "day" -> Json.Decode.succeed Billing.Model.Day
      "month" -> Json.Decode.succeed Billing.Model.Month
      _ -> Json.Decode.fail "period unit doesn't recognize"

decodePeriodValueRange : Json.Decode.Decoder Billing.Model.PeriodValue
decodePeriodValueRange =
  Json.Decode.succeed <| Billing.Model.PeriodList [1,2,3,4]


decodePeriod : Json.Decode.Decoder Billing.Model.Period
decodePeriod =
  Json.Decode.object2 Billing.Model.Period
    ("unit" := decodePeriodUnit)
    (Json.Decode.oneOf [ ("range" := decodePeriodValueRange) ])

decodeServiceUnit : Json.Decode.Decoder Billing.Model.ServiceUnit
decodeServiceUnit =
  Json.Decode.succeed Billing.Model.M

decodeServiceValue : Json.Decode.Decoder Billing.Model.ServiceValue
decodeServiceValue =
  Json.Decode.succeed <| Billing.Model.ServiceList {values = [1,2,3], default = 1}

decodeService : Json.Decode.Decoder Billing.Model.Service
decodeService =
  Json.Decode.object5 Billing.Model.Service
    ("alias" := Json.Decode.string)
    ("changeable" := Json.Decode.bool)
    ("visible" := Json.Decode.bool)
    ("unit" := Json.Decode.maybe decodeServiceUnit)
    (decodeServiceValue)

decodePacket : Json.Decode.Decoder Billing.Model.Packet
decodePacket =
  Json.Decode.map Billing.Model.Packet
    ("id" := Json.Decode.int)
    &= ("name" := Json.Decode.string)
    &= ("type" := decodePacketType)
    &= ("project" := decodeProject)
    &= ("client_type" := decodeClient)
    &= ("region" := decodeRegion)
    &= ("period" := decodePeriod)
    &= ("services" := Json.Decode.list decodeService)