'use strict'

describe 'Directive: addressShow', ->

  # load the directive's module
  beforeEach module 'timerApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<address-show></address-show>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the addressShow directive'
