'use strict'

describe 'Service: addressFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  addressFactory = {}
  beforeEach inject (_addressFactory_) ->
    addressFactory = _addressFactory_

  it 'should do something', ->
    expect(!!addressFactory).toBe true
