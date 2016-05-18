'use strict'

angular
.module('timerApp', [
    'ui.router',
    'satellizer'
])
.config ($stateProvider, $urlRouterProvider, $authProvider) ->
    $authProvider.loginUrl = '/api/authenticate'
    $urlRouterProvider
    .otherwise('/auth')
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

.run ($rootScope, $state) ->
    $rootScope.authenticated = false

    $rootScope.checkRights = ($rootScope, $state) ->
        $user = JSON.parse(localStorage.getItem('user'))
        if $user && !$rootScope.authenticated
            $rootScope.authenticated = true
            $rootScope.currentUser = $user
        else if !$user
            $state.go 'auth'
        return

    $rootScope.$on '$locationChangeStart', (event, next, current) ->
        $rootScope.checkRights($rootScope, $state)
        return

