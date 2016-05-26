'use strict'

describe 'Service: userFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  userFactory = {}
  beforeEach inject (_userFactory_) ->
    userFactory = _userFactory_

  it 'should do something', ->
    expect(!!userFactory).toBe true
