'use strict'

angular.module('timerApp')
.factory 'apiTimeFactory', ($http,$auth) ->
    urlBase = 'api/time'
    apiTimeFactory = {}
    apiTimeFactory.startTimer = (data) ->
        $http
            method: 'POST'
            url: urlBase+'/start'
            data: data
    apiTimeFactory.stopTimer = (data) ->
        $http
            method: 'POST'
            url: urlBase+'/end'
            data: data
    apiTimeFactory
