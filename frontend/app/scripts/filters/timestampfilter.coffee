'use strict'

angular.module('timerApp')
.filter 'timestampFilter', ->
    (input) ->
        totalSec = Math.floor(input / 1000)
        hours = parseInt(totalSec / 3600)
        minutes = parseInt(totalSec / 60) % 60
        seconds = totalSec % 60
        result = (if hours < 10 then '0' + hours else hours) + ' : ' + (if minutes < 10 then '0' + minutes else minutes) + ' : ' + (if seconds < 10 then '0' + seconds else seconds)
        result
