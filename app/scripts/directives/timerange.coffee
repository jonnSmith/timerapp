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
            element.text $filter('date')(range, 'HH:mm:ss', 'UTC')
        #$rootScope.$watch 'currentUser.time_last_closed', ->
        #    start = Date.parse if angular.isString(attrs.start) then attrs.start.replace(/\-/g, '/') else attrs.start
        #    end = Date.parse if angular.isString(attrs.end) then attrs.end.replace(/\-/g, '/') else attrs.end
        #    range = end - start
        #    if range
        #        element.text $filter('date')(range, 'HH:mm:ss', 'UTC')
        #   return
        return
    replace: true
)
