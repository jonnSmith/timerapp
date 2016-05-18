'use strict'

angular.module('timerApp')
.controller 'DashboardCtrl', ($scope, usersFactory, $auth, $rootScope, $state) ->
    vm = this

    usersFactory.getUsers().success((users) ->
        vm.users = users
        return
    ).error (error) ->
        vm.error = error
        return

    vm.logout = ->
        $auth.logout().then ->
            localStorage.removeItem 'user'
            $rootScope.authenticated = false
            $rootScope.currentUser = null
            $state.go 'auth'
            return
        return

    return
