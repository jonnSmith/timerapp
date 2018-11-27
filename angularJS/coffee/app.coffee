'use strict'

angular
.module('timerApp', [
    'ui.router',
    'satellizer',
    'ngGeolocation',
    'ngMap',
    'ngStorage',
    '720kb.datepicker',
    'n3-line-chart'
])
.config ($stateProvider, $urlRouterProvider, $authProvider, $locationProvider) ->
    $authProvider.loginUrl = '/api/authenticate'
    $urlRouterProvider.otherwise('/dashboard')
    $stateProvider
    .state('auth',
        url: '/auth'
        templateUrl: 'views/auth'
        controller: 'AuthCtrl as auth'
        data: 'noLogin': true)
    .state 'dashboard',
        url: '/dashboard'
        templateUrl: 'views/dashboard'
        controller: 'DashboardCtrl as dashboard'
    .state 'manage',
        url: '/manage'
        templateUrl: 'views/manage'
        controller: 'ManageCtrl as manage'
    .state 'user',
        url: '/users/:uid'
        templateUrl: 'views/user'
        controller: 'UserCtrl as user'
    .state 'group',
        url: '/group/:gid'
        templateUrl: 'views/group'
        controller: 'GroupCtrl as group'
    .state 'settings',
        url: '/settings'
        templateUrl: 'views/settings'
        controller: 'SettingsCtrl as user'
    return
    #$locationProvider
    #.html5Mode
        #enabled: true
        #requireBase: false
.run ($rootScope, $localStorage, $state, $location, $auth, $geolocation, usersFactory,timerFactory) ->
    $rootScope.authenticated = false
    $rootScope.language = 'en'
    $rootScope.title = 'LAB Timer'
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.interval= 30*60*1000
    $rootScope.token = $auth.getToken()
    $rootScope.token_is_refreshing = false
    $rootScope.devmode = false
    $rootScope.perPage = 5
    $geolocation.watchPosition
        timeout: $rootScope.interval
        maximumAge: 250
        enableHighAccuracy: true
    $rootScope.checkRights = () ->
        $user = false
        if $localStorage.user
            $user = JSON.parse($localStorage.user)
        $is_auth = $auth.isAuthenticated()
        if $user && !$rootScope.authenticated && $is_auth
            $rootScope.authenticated = true
            $rootScope.currentUser = $user
            console.log '$state', $state
#            if $state.$urlRouter && $state.$urlRouter.location == '' || $state.$urlRouter.location == '/auth' || $state.$urlRouter.location == 'auth'
#                $location.path('/dashboard')
        else if !$user || !$is_auth
            $rootScope.logout()
            $location.path('/auth')
        return
    $rootScope.$on '$locationChangeStart', (event, next, current) ->
        $rootScope.checkRights($rootScope, $state, $location)
        return
    $rootScope.logout = ->
        $auth.logout().then ( ->
            $state.go 'auth'
            $rootScope.authenticated = false
            timerFactory.saveTimer(false)
            delete $localStorage.startDate
            delete $localStorage.endDate
            delete $localStorage.user
            return
        ), (error) ->
            $rootScope.error = error.data.error
            return
        return
    $rootScope.$watch 'error', ->
        if $rootScope.error
            console.log('Error:', $rootScope.error)
            if $rootScope.error.error && $rootScope.error.error == 'user_not_found'
                $rootScope.logout()
            else
                $rootScope.checkRights()
        return

    $rootScope.$watch 'splash', ->
        if $rootScope.splash
            console.log('Error:', $rootScope.error)
        return