'use strict'

angular.module('timerApp')
.filter 'strikedFilter', ->
    (input) ->
        times = 0
        angular.forEach input, (value, key) ->
            if value.end && value.is_strike
                start = Date.parse if angular.isString(value.start) then value.start.replace(/\-/g, '/') else value.start
                end = Date.parse if angular.isString(value.end) then value.end.replace(/\-/g, '/') else value.end
                range = end - start
                if angular.isNumber(range)
                    times = times + range
            return
        times
