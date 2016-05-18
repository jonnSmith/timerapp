'use strict'

angular.module('timerApp')
.factory 'timeFactory', [
    '$rootScope'
    '$timeout'
    ($rootScope, $timeout) ->
        obj = {}
        obj.timeOffset = 0

        obj.init = (serverTime) ->
            obj.timeOffset = serverTime - (new Date).getTime()
            obj.updateClock()
            obj

        obj.updateClock = ->
            obj.time = new Date((new Date).getTime() + obj.timeOffset).getTime()
            $timeout obj.updateClock, 1000
            return

        obj
]
