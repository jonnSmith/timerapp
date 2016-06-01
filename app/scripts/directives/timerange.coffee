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
            result = $filter('timestampFilter')(range)
            element.text $filter('date')(start, 'yyyy-MM-dd HH:mm') + ' | ' + result
        if attrs.last
            $rootScope.$watch 'currentUser.time_last_closed.end', ->
                closed = $rootScope.currentUser.time_last_closed
                start = Date.parse if angular.isString(closed.start) then closed.start.replace(/\-/g, '/') else closed.start
                end = Date.parse if angular.isString(closed.end) then closed.end.replace(/\-/g, '/') else closed.end
                range = end - start
                if range
                    result = $filter('timestampFilter')(range)
                    element.text $filter('date')(start, 'yyyy-MM-dd HH:mm') + ' | ' + result
                return
        return
    replace: true
)
