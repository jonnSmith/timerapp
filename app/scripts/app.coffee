'use strict'

angular
.module('timerApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute'
])
.config ($routeProvider, $locationProvider) ->
    $routeProvider
    .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
    .otherwise
            redirectTo: '/'
    $locationProvider
    .html5Mode
            enabled: true
            requireBase: false
    return
.run ($rootScope) ->
    $rootScope.language = 'en'
    return

