'use strict'

describe 'Service: groupFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  groupFactory = {}
  beforeEach inject (_groupFactory_) ->
    groupFactory = _groupFactory_

  it 'should do something', ->
    expect(!!groupFactory).toBe true
