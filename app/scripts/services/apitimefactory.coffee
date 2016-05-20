'use strict'

angular.module('timerApp')
.factory 'apiTimeFactory', ($http,$auth) ->
    urlBase = 'api/time'
    apiTimeFactory = {}
    apiTimeFactory.startTimer = () ->
        $http.get urlBase+'/start'
    apiTimeFactory.stopTimer = () ->
        $http.get urlBase+'/end'
    apiTimeFactory
