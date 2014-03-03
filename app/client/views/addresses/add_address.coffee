Session.set "show_complete_form", false
Session.set "show_coin_help", false


Template.addAddress.created = ->
  Meteor.call "implemented_coins", (error, result) ->
    Session.set "cryptos", result


Template.addAddress.helpers
  cryptos: ->
    Session.get "cryptos"
  coin_recognized: ->
    not Session.get "show_complete_form"
  coin_help: ->
    Session.get "show_coin_help"


Template.addAddress.events
  "submit form": (e) ->
    e.preventDefault()
    name = $(e.target).find("[name=name-alpha]").val()
    if not name
      name = $(e.target).find("[name=name]").val()
    address = $(e.target).find("[name=address]").val()

    Meteor.call "verify_address", address, name, (error, result) ->
      if error
        Errors.throw error.reason
      else
        data =
          address: address
          name: name
        if not result
          data.code = $(e.target).find("[name=code]").val()
          data.nb_coin = $(e.target).find("[name=nb_coin]").val()
          data.value = $(e.target).find("[name=value]").val()
        else Errors.throw result

        Meteor.call "add_address", data, (error, id) ->
          if error
            # Display the error
            Errors.throw error.reason

  "click .fa-plus-square": (e) ->
    Session.set "show_complete_form", true

  "click #close-form": (e) ->
    Session.set "show_complete_form", false

  "click .fa-question-circle": (e) ->
    Session.set "show_coin_help", true

  "click #close-coin-help": (e) ->
    Session.set "show_coin_help", false

  "click #close": (e) ->
    Session.set "showCoinForm", false


Template.addAddress.rendered = () ->
  formStatus = Session.get "show_coin_help"
  if Session.get "showAddAddressForm"
    $(".add_address").toggleClass "is_unactive", "is_active"
