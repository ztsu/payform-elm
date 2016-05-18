module Billing.Model where

{-| Packet
-}
type alias Packet =
  { id : Int
  , name : String
  , packetType : PacketType
  , project : Project
  , client : ClientType
  , region : Region
  , period : Period
  , services : List Service
  }

type alias PacketType =
  { alias: String
  , name: String
  }

type alias Project =
  { id: Int
  , alias: String
  , name: String
  }

type ClientType
  = User
  | Advert
  | Company

type alias Region =
  { id: Int
  , name: String
  }

type alias Period = { unit: PeriodUnit, value: PeriodValue }

type PeriodUnit = Hour | Day | Month

type PeriodValue = PeriodRange {min : Int, max: Int, step: Int} | PeriodList (List Int)


type alias Service =
  { alias : String
  , changebale : Bool
  , visible : Bool
  , unit : Maybe ServiceUnit
  , value : ServiceValue
  }


type ServiceUnit = Cm | M

type ServiceValue
  = ServiceInt { min : Int, max : Int, default : Int }
  | ServiceList { values : List Int, default : Int }
