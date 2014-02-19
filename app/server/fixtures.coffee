"""
Initial data:

  → set a default user CoinsManager
  - create its donation addresses
"""

if Meteor.users.find().count() is 0
  coinsManagerId = Accounts.createUser
    email: Meteor.settings.public.email
    profile:
      favorites:
        fiat: 'USD'
        exchange: 'MtGox'


  # Add public addresses for CoinsManager
  for name, address of Meteor.settings.public.donations
    Addresses.insert
      userId: coinsManagerId
      name: name
      address: address
