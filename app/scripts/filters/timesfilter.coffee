'use strict'

angular.module('timerApp')
.filter 'timesFilter', ->
    (input) ->
        times = 0
        angular.forEach input, (value, key) ->
            if value.end
                start = Date.parse if angular.isString(value.start) then value.start.replace(/\-/g, '/') else value.start
                end = Date.parse if angular.isString(value.end) then value.end.replace(/\-/g, '/') else value.end
                range = end - start
                if angular.isNumber(range)
                    times = times + range
            return
        totalSec = times / 1000
        hours = parseInt(totalSec / 3600)
        minutes = parseInt(totalSec / 60) % 60
        seconds = totalSec % 60
        result = (if hours < 10 then '0' + hours else hours) + ':' + (if minutes < 10 then '0' + minutes else minutes) + ':' + (if seconds < 10 then '0' + seconds else seconds)
        result
