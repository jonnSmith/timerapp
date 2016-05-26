'use strict'

angular.module('timerApp')
.factory 'usersFactory', ($http,$auth,$rootScope) ->
    urlBase = 'api'
    token = $auth.getToken()
    data = token: token
    config =
        params: data
    usersFactory = {}
    usersFactory.getUsers = () ->
        $http.get(urlBase + '/authenticate')
    usersFactory.setUser = () ->
        $http.get(urlBase+'/authenticate/user').then (response) ->
            user = JSON.stringify(response.data.user)
            localStorage.setItem 'user', user
            $rootScope.currentUser = response.data.user
            return
    usersFactory.refreshUser = () ->
        $http.get(urlBase+'/authenticate/refresh')
    usersFactory.createUser = (data) ->
        $http.post(urlBase+'/user/create', data)
    usersFactory.deleteUser = (uid) ->
        $http.delete(urlBase+'/users/'+uid)
    usersFactory