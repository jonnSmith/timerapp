'use strict'

angular.module('timerApp')
.controller 'UserCtrl', ($http, $auth, $rootScope, $state) ->
    vm = this
    vm.users
    vm.error

    vm.getUsers = ->
        $http.get('api/authenticate').success((users) ->
            vm.users = users
            return
        ).error (error) ->
            vm.error = error
            return
        return


    vm.logout = ->
        $auth.logout().then ->
            localStorage.removeItem 'user'
            # Flip authenticated to false so that we no longer
            # show UI elements dependant on the user being logged in
            $rootScope.authenticated = false
            # Remove the current user info from rootscope
            $rootScope.currentUser = null
            # Redirect to auth (necessary for Satellizer 0.12.5+)
            $state.go 'auth'
            return
        return

    return
