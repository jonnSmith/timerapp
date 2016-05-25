'use strict'

angular.module('timerApp')
.controller 'UsersCtrl', ($scope, $auth, $state, $rootScope, usersFactory) ->
    $rootScope.error = false
    $rootScope.title = 'Create user'
    vm = this

    vm.createUser = () ->
        data =
            email: vm.email
            name: vm.name
            password: vm.password
        usersFactory.createUser(data).success((user) ->
            console.log user
            $state.go 'dashboard'
            return
        ).error (error) ->
            $rootScope.error = error
            return
        return

    return
