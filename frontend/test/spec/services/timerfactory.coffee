'use strict'

describe 'Service: timerFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  timerFactory = {}
  beforeEach inject (_timerFactory_) ->
    timerFactory = _timerFactory_

  it 'should do something', ->
    expect(!!timerFactory).toBe true
