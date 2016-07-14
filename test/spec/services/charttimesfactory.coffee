'use strict'

describe 'Service: chartTimesFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  chartTimesFactory = {}
  beforeEach inject (_chartTimesFactory_) ->
    chartTimesFactory = _chartTimesFactory_

  it 'should do something', ->
    expect(!!chartTimesFactory).toBe true
