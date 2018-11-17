'use strict'

describe 'Filter: timestampFilter', ->

  # load the filter's module
  beforeEach module 'timerApp'

  # initialize a new instance of the filter before each test
  timestampFilter = {}
  beforeEach inject ($filter) ->
    timestampFilter = $filter 'timestampFilter'

  it 'should return the input prefixed with "timestampFilter filter:"', ->
    text = 'angularjs'
    expect(timestampFilter text).toBe ('timestampFilter filter: ' + text)
