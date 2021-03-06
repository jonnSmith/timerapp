'use strict'

angular.module('timerApp')
.factory 'usersFactory', ($http,$auth,$rootScope,$localStorage,timerFactory) ->
    urlBase = 'api'
    token = $auth.getToken()
    data = token: token
    config =
        params: data
    usersFactory = {}
    usersFactory.getUsers = () ->
        $http.get(urlBase + '/users')
    usersFactory.setUser = () ->
        $http.get(urlBase+'/authenticate/user').then (response) ->
            user = JSON.stringify(response.data)
            $localStorage.user = user
            $rootScope.currentUser = response.data
            if !response.data.time_is_open
                timerFactory.clearTimer()
            return
    usersFactory.createUser = (data) ->
        $http.post(urlBase+'/user/create', data)
    usersFactory.deleteUser = (uid) ->
        $http.delete(urlBase+'/users/'+uid)
    usersFactory