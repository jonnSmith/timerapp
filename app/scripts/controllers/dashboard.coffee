'use strict'

angular.module('timerApp')
.controller 'DashboardCtrl', ($scope, $auth, $rootScope, $state, usersFactory, timeFactory) ->
    vm = this

    usersFactory.getUsers().success((users) ->
        vm.users = users
        return
    ).error (error) ->
        vm.error = error
        return

    time = new Date().getTime()

    vm.time = timeFactory.init(time);

    $rootScope.title = 'Dashboard'

    vm.token = $auth.getToken()

    vm.logout = ->
        $auth.logout().then ->
            localStorage.removeItem 'user'
            $rootScope.authenticated = false
            $rootScope.currentUser = null
            $state.go 'auth'
            return
        return

    return
