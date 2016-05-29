import Html.App

import Order.View
import Order.Model

main : Program Never
main
  = Html.App.program
  { init = Order.Model.init
  , view = Order.View.view
  , update = Order.Model.update
  , subscriptions = Order.Model.subscriptions
  }
