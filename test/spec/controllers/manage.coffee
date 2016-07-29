'use strict'

describe 'Controller: ManageCtrl', ->

# load the controller's module
    beforeEach module 'timerApp'

    ManageCtrl = {}
    scope = {}

    # Initialize the controller and a mock scope
    beforeEach inject ($controller, $rootScope) ->
        scope = $rootScope.$new()
        ManageCtrl = $controller 'ManageCtrl', {
            $scope: scope
        }

    it 'should attach a list of awesomeThings to the scope', ->
        expect(scope.awesomeThings.length).toBe 3
