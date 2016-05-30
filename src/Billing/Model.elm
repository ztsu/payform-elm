module Billing.Model exposing (..)

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
  = Advert
  | Company
  | Gift
  | Profile
  | Resume
  | User
  | Vacancy
  | Wallet



type alias Region =
  { id: Int
  , name: String
  }


type Period
  = Period PeriodUnit PeriodValue
  | OneTime


type PeriodUnit
  = Hour
  | Day
  | Month


type PeriodValue
  = PeriodRange {min : Int, max: Int, step: Int}
  | PeriodList (List Int)


type alias Service =
  { alias : String
  , changebale : Bool
  , visible : Bool
  , unit : Maybe ServiceUnit
  , value : ServiceValue
  }


type ServiceUnit
  = NoUnit
  | Meter


type ServiceValue
  = ServiceInt { min : Int, max : Int, default : Int }
  | ServiceList { values : List Int, default : Int }
