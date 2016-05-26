'use strict'

describe 'Filter: timesFilter', ->

  # load the filter's module
  beforeEach module 'timerApp'

  # initialize a new instance of the filter before each test
  timesFilter = {}
  beforeEach inject ($filter) ->
    timesFilter = $filter 'timesFilter'

  it 'should return the input prefixed with "timesFilter filter:"', ->
    text = 'angularjs'
    expect(timesFilter text).toBe ('timesFilter filter: ' + text)
