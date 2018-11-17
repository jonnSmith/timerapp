'use strict'

describe 'Filter: locationFilter', ->

  # load the filter's module
  beforeEach module 'timerApp'

  # initialize a new instance of the filter before each test
  locationFilter = {}
  beforeEach inject ($filter) ->
    locationFilter = $filter 'locationFilter'

  it 'should return the input prefixed with "locationFilter filter:"', ->
    text = 'angularjs'
    expect(locationFilter text).toBe ('locationFilter filter: ' + text)
