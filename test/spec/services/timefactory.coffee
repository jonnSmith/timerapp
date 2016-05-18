'use strict'

describe 'Service: timeFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  timeFactory = {}
  beforeEach inject (_timeFactory_) ->
    timeFactory = _timeFactory_

  it 'should do something', ->
    expect(!!timeFactory).toBe true
