'use strict'

describe 'Directive: timeRange', ->

  # load the directive's module
  beforeEach module 'timerApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<time-range></time-range>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the timeRange directive'
