'use strict'

angular.module('timerApp')
.filter 'locationFilter', ->
    (input) ->
        location = JSON.parse(input)
        location.latitude+','+location.longitude
