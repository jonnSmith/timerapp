'use strict'

angular.module('timerApp')
.factory 'usersFactory', ($http) ->
    urlBase = 'api/authenticate'
    usersFactory = {}
    usersFactory.getUsers = () ->
        $http.get urlBase
    usersFactory