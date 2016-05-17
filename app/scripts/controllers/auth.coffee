'use strict'

angular.module('timerApp')
.controller 'AuthCtrl', ($auth, $state) ->
    vm = this
    vm.login = ->
        credentials =
            email: vm.email
            password: vm.password
        $auth.login(credentials).then (data) ->
            $state.go 'users', {}
            return
        return
    return