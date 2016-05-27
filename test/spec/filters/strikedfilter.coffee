'use strict'

describe 'Filter: strikedFilter', ->

  # load the filter's module
  beforeEach module 'timerApp'

  # initialize a new instance of the filter before each test
  strikedFilter = {}
  beforeEach inject ($filter) ->
    strikedFilter = $filter 'strikedFilter'

  it 'should return the input prefixed with "strikedFilter filter:"', ->
    text = 'angularjs'
    expect(strikedFilter text).toBe ('strikedFilter filter: ' + text)
