'use strict'

angular
.module('timerApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'ui.router',
    'satellizer'
])
.config ($routeProvider, $locationProvider, $stateProvider, $urlRouterProvider, $authProvider) ->

    $authProvider.loginUrl = '/api/authenticate'

    $urlRouterProvider
    .otherwise('/auth')

    $stateProvider
    .state('auth',
        url: '/auth'
        templateUrl: 'views/auth.html'
        controller: 'AuthCtrl as auth')
    .state 'users',
        url: '/users'
        templateUrl: 'views/user.html'
        controller: 'UserCtrl as user'

    #$locationProvider
    #.html5Mode
        #enabled: true
        #requireBase: false
    return

.run ($rootScope) ->
    $rootScope.language = 'en'
    return

