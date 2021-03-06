'use strict'

angular.module('timerApp')
.controller 'AuthCtrl', ($auth, $state,$http,$rootScope, $localStorage) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Login'
    vm.login = ->
        credentials =
            email: vm.email
            password: vm.password
        $auth.login(credentials).then (->
            $http.get('api/authenticate/user').then (response) ->
                user = JSON.stringify(response.data)
                $localStorage.user = user
                $rootScope.authenticated = true
                $rootScope.currentUser = response.data
                $rootScope.token = $auth.getToken()
                $state.go 'dashboard'
                return
            ), (error) ->
                $rootScope.error = error.data.error
                return
    return