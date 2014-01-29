Session.set 'show_complete_form', false


Template.addAddress.helpers
  codes: ->
    _.keys cryptoClassesList
  coin_recognized: ->
    not Session.get 'show_complete_form'


Template.addAddress.events
  'submit form': (e) ->
    e.preventDefault()
    data =
      address: $(e.target).find('[name=address]').val()
      code: $(e.target).find('[name=code]').val()

    Meteor.call 'add_address', data, (error, id) ->
      if error
        # Display the error
        Errors.throw error.reason
  'click .fa-plus-square': (e) ->
    Session.set 'show_complete_form', true
