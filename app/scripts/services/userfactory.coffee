'use strict'

angular.module('timerApp')
.factory 'userFactory', ($http, $auth, $rootScope) ->
    urlBase = 'api/users/'
    token = $auth.getToken()
    data = token: token
    config =
        params: data
    userFactory = {}
    userFactory.getUser = (uid) ->
        $http.get(urlBase + uid)
    userFactory.updateUser = (uid, data) ->
        $http.put(urlBase + uid, data)
    userFactory