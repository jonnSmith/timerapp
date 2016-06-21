'use strict'

describe 'Service: ipLocationFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  ipLocationFactory = {}
  beforeEach inject (_ipLocationFactory_) ->
    ipLocationFactory = _ipLocationFactory_

  it 'should do something', ->
    expect(!!ipLocationFactory).toBe true
