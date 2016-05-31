'use strict'

angular.module('timerApp')
.directive('timeRange', ($compile,$filter,$rootScope) ->
    template: '<time></time>'
    restrict: 'E'
    link: (scope, element, attrs) ->
        start = Date.parse if angular.isString(attrs.start) then attrs.start.replace(/\-/g, '/') else attrs.start
        end = Date.parse if angular.isString(attrs.end) then attrs.end.replace(/\-/g, '/') else attrs.end
        range = end - start
        if range
            totalSec = range / 1000
            hours = parseInt(totalSec / 3600)
            minutes = parseInt(totalSec / 60) % 60
            seconds = totalSec % 60
            result = (if hours < 10 then '0' + hours else hours) + ':' + (if minutes < 10 then '0' + minutes else minutes) + ':' + (if seconds < 10 then '0' + seconds else seconds)
            element.text $filter('date')(start, 'yyyy-MM-dd') + ' : ' + result
        if attrs.last
            $rootScope.$watch 'currentUser.time_last_closed.end', ->
                closed = $rootScope.currentUser.time_last_closed
                start = Date.parse if angular.isString(closed.start) then closed.start.replace(/\-/g, '/') else closed.start
                end = Date.parse if angular.isString(closed.end) then closed.end.replace(/\-/g, '/') else closed.end
                range = end - start
                if range
                    totalSec = range / 1000
                    hours = parseInt(totalSec / 3600)
                    minutes = parseInt(totalSec / 60) % 60
                    seconds = totalSec % 60
                    result = (if hours < 10 then '0' + hours else hours) + ':' + (if minutes < 10 then '0' + minutes else minutes) + ':' + (if seconds < 10 then '0' + seconds else seconds)
                    element.text $filter('date')(start, 'yyyy-MM-dd') + ' : ' + result
                return
        return
    replace: true
)
