'use strict'

angular.module('timerApp')
.factory 'usersFactory', ($http,$auth) ->
    urlBase = 'api/authenticate'
    #$token = $auth.getToken()
    #data = token: $token
    #config =
    #    params: data
    usersFactory = {}
    usersFactory.getUsers = () ->
        #$http.get(urlBase, config)
        $http.get urlBase
    usersFactory