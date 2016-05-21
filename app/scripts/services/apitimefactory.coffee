'use strict'

angular.module('timerApp')
.factory 'apiTimeFactory', ($http,$auth) ->
    urlBase = 'api/time'
    apiTimeFactory = {}
    apiTimeFactory.startTimer = (location) ->
        data =
            location: location
        $http
            method: 'POST'
            url: urlBase+'/start'
            data: data
    apiTimeFactory.stopTimer = (location) ->
        data =
            location: location
        $http
            method: 'POST'
            url: urlBase+'/end'
            data: data
    apiTimeFactory
