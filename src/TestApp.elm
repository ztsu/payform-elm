import Html exposing (div, text)
import Json.Decode

import Billing.Model
import Billing.Rest
import Order.View

resultToHtml result =
  case result of
    Ok packet -> Order.View.packet packet
    Err message -> text message

jsonchick = """{"id":3447,"name":"Тест","type":{"alias":"kd","title":"Коммерческий доступ"},"client_type":"user","region":{"id":24,"name":"Кемеровская область"},"geo":{"id":0,"name":""},"project":{"id":37,"alias":"","name":""},"period":{"unit":"day","unitWordFormsRu":["день","дня","дней"],"range":{"min":30,"max":90,"step":30}},"activateDate":1361861795,"deactivateDate":0,"services":[{"alias":"offers_limit","title":"Лимит объявлений","visible":true,"changeable":false,"type":"int","defaultValue":200,"unit":"","unitWordFormsRu":["","",""],"min":0,"max":null}]}"""

main =
  div [] [ resultToHtml <| Json.Decode.decodeString Billing.Rest.decodePacket jsonchick ]
