'use strict'

angular
.module('timerApp', [
    'ui.router',
    'satellizer',
    'ui.bootstrap'
])
.config ($stateProvider, $urlRouterProvider, $authProvider, $locationProvider) ->
    $authProvider.loginUrl = '/api/authenticate'
    $urlRouterProvider.otherwise('/auth')
    $stateProvider
    .state('auth',
        url: '/auth'
        templateUrl: 'views/auth.html'
        controller: 'AuthCtrl as auth'
        data: 'noLogin': true)
    .state 'dashboard',
        url: '/dashboard'
        templateUrl: 'views/dashboard.html'
        controller: 'DashboardCtrl as dashboard'
    return
    #$locationProvider
    #.html5Mode
        #enabled: true
        #requireBase: false
.run ($rootScope, $state, $location) ->
    $rootScope.authenticated = false
    $rootScope.lamguage = 'en'
    $rootScope.title = 'LAB Timer'
    $rootScope.checkRights = ($rootScope, $state, $location) ->
        $user = JSON.parse(localStorage.getItem('user'))
        console.log $state.$urlRouter.location
        if $user && !$rootScope.authenticated
            console.log $user
            $rootScope.authenticated = true
            $rootScope.currentUser = $user
            if $state.$urlRouter.location == '' || $state.$urlRouter.location == '/auth' || $state.$urlRouter.location == 'auth'
                $location.path('/dashboard')
        else if !$user
            $location.path('/auth')
        return
    $rootScope.$on '$locationChangeStart', (event, next, current) ->
        $rootScope.checkRights($rootScope, $state, $location)
        return

