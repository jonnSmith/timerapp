'use strict'

angular.module('timerApp')
.factory 'timerFactory', [
    '$rootScope'
    '$timeout'
    ($rootScope, $timeout) ->
        obj = {}
        obj.is_start = false
        obj.step = 1000

        obj.setTimer = (startTime) ->
            obj.start = startTime
            obj.updateTimer()
            obj

        obj.runTimer = (run, startTime = false) ->
            obj.is_start = run
            runTime = new Date().getTime()
            if startTime
                runTime = Date.parse if angular.isString(startTime) then startTime.replace(/\-/g, '/') else startTime
                console.log runTime + ' - ' + startTime
            obj.timer = Math.floor(obj.timer/obj.step)*obj.step
            obj.start = runTime - obj.timer
            obj.setTimer(obj.start)
            runTime

        obj.clearTimer = () ->
            obj.start = new Date().getTime()
            obj.is_start = false
            obj.updateTimer()
            return

        obj.saveTimer = () ->
            obj.clearTimer()
            obj.start

        obj.updateTimer = () ->
            obj.timer = new Date().getTime() - obj.start
            if obj.is_start
                $timeout obj.updateTimer, obj.step
            return

        obj
]