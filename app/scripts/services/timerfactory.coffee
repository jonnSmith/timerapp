'use strict'

angular.module('timerApp')
.factory 'timerFactory', [
    '$rootScope'
    '$timeout'
    ($rootScope, $timeout) ->
        obj = {}
        obj.is_start = false

        obj.setTimer = (startTime) ->
            obj.start = startTime
            obj.updateTimer()
            obj

        obj.runTimer = (run) ->
            obj.is_start = run
            obj.timer = Math.floor(obj.timer/1000)*1000
            obj.start = new Date().getTime() - obj.timer
            obj.setTimer(obj.start)
            return

        obj.clearTimer = () ->
            obj.start = new Date().getTime()
            obj.is_start = false
            obj.updateTimer()
            return

        obj.saveTimer = () ->
            $rootScope.timerValue = obj.timer
            obj.clearTimer()
            return

        obj.updateTimer = () ->
            obj.timer = new Date().getTime() - obj.start
            if obj.is_start
                $timeout obj.updateTimer, 1000
            return

        obj
]