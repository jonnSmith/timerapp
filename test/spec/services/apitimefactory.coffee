'use strict'

describe 'Service: apiTimeFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  apiTimeFactory = {}
  beforeEach inject (_apiTimeFactory_) ->
    apiTimeFactory = _apiTimeFactory_

  it 'should do something', ->
    expect(!!apiTimeFactory).toBe true
