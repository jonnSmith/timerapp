'use strict'

describe 'Service: colorFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  colorFactory = {}
  beforeEach inject (_colorFactory_) ->
    colorFactory = _colorFactory_

  it 'should do something', ->
    expect(!!colorFactory).toBe true
