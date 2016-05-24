'use strict'

angular.module('timerApp')
.factory 'usersFactory', ($http,$auth,$rootScope) ->
    urlBase = 'api/authenticate'
    token = $auth.getToken()
    data = token: token
    config =
        params: data
    usersFactory = {}
    usersFactory.getUsers = () ->
        $http.get urlBase
    usersFactory.setUser = () ->
        $http.get(urlBase+'/user').then (response) ->
            user = JSON.stringify(response.data.user)
            localStorage.setItem 'user', user
            $rootScope.currentUser = response.data.user
            return
    usersFactory.refreshUser = () ->
        $http.get(urlBase+'/refresh')
    usersFactory