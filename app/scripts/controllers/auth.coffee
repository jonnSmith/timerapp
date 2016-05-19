'use strict'

angular.module('timerApp')
.controller 'AuthCtrl', ($auth, $state,$http,$rootScope) ->
    vm = this
    vm.loginError = false
    vm.loginErrorText
    $rootScope.title = 'Login'
    vm.login = ->
        credentials =
            email: vm.email
            password: vm.password
        $auth.login(credentials).then (->
            $http.get('api/authenticate/user').then (response) ->
                user = JSON.stringify(response.data.user)
                localStorage.setItem 'user', user
                $rootScope.authenticated = true
                $rootScope.currentUser = response.data.user
                $state.go 'dashboard'
                return
            ), (error) ->
                vm.loginError = true
                vm.loginErrorText = error.data.error
                return
        return
    return