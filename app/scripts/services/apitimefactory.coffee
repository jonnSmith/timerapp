'use strict'

angular.module('timerApp')
.factory 'apiTimeFactory', ($http,$auth) ->
    urlBase = 'api/time'
    apiTimeFactory = {}
    apiTimeFactory.startTimer = () ->
        data =
            start_location: 'test'
        $http
            method: 'POST'
            url: urlBase+'/start'
            data: data
    apiTimeFactory.stopTimer = () ->
        data =
            end_location: 'test'
        $http
            method: 'POST'
            url: urlBase+'/end'
            data: data
    apiTimeFactory
