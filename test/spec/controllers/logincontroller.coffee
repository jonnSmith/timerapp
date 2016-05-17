'use strict'

describe 'Controller: LogincontrollerCtrl', ->

  # load the controller's module
  beforeEach module 'timerApp'

  LogincontrollerCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LogincontrollerCtrl = $controller 'LogincontrollerCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
