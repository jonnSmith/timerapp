'use strict'

angular.module('timerApp')
.factory 'ipLocationFactory', ($http, $auth, $rootScope) ->
    urlBase = 'http://ipinfo.io/'
    ipLocationFactory = {}
    ipLocationFactory.getLocationByIP = (ip) ->
        $http.get(urlBase + ip)
    ipLocationFactory