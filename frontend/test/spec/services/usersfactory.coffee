'use strict'

describe 'Service: usersFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  usersFactory = {}
  beforeEach inject (_usersFactory_) ->
    usersFactory = _usersFactory_

  it 'should do something', ->
    expect(!!usersFactory).toBe true
