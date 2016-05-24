'use strict'

angular
.module('timerApp', [
    'ui.router',
    'satellizer',
    'ngGeolocation'
])
.config ($stateProvider, $urlRouterProvider, $authProvider, $locationProvider) ->
    $authProvider.loginUrl = '/api/authenticate'
    $urlRouterProvider.otherwise('/dashboard')
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
    .state 'create_user',
        url: '/create_user'
        templateUrl: 'views/create_user.html'
        controller: 'CreateuserCtrl as create_user'
    return
    #$locationProvider
    #.html5Mode
        #enabled: true
        #requireBase: false
.run ($rootScope, $state, $location, $auth, $geolocation,usersFactory) ->
    $rootScope.authenticated = false
    $rootScope.language = 'en'
    $rootScope.title = 'LAB Timer'
    $rootScope.error = false
    $rootScope.interval= 10*60*1000
    $rootScope.token = $auth.getToken()
    $geolocation.watchPosition
        timeout: $rootScope.interval
        maximumAge: 250
        enableHighAccuracy: true
    $rootScope.checkRights = ($rootScope, $state, $location) ->
        $user = JSON.parse(localStorage.getItem('user'))
        $is_auth = $auth.isAuthenticated()
        if $user && !$rootScope.authenticated && $is_auth
            $rootScope.authenticated = true
            $rootScope.currentUser = $user
            if $state.$urlRouter.location == '' || $state.$urlRouter.location == '/auth' || $state.$urlRouter.location == 'auth'
                $location.path('/dashboard')
        else if !$user || !$is_auth
            $rootScope.logout()
            $location.path('/auth')
        return
    $rootScope.refreshToken = ->
        $is_auth = $auth.isAuthenticated()
        if $is_auth
            usersFactory.refreshUser().success((response) ->
                token = response.token
                $rootScope.token = token
                $auth.setToken token
                return
            ).error (error) ->
                $rootScope.error = error
                return
        return
    setInterval (->
        $rootScope.refreshToken()
        return
    ), $rootScope.interval
    $rootScope.$on '$locationChangeStart', (event, next, current) ->
        $rootScope.checkRights($rootScope, $state, $location)
        return
    $rootScope.logout = ->
        $auth.logout().then ( ->
            localStorage.removeItem 'user'
            $rootScope.authenticated = false
            $rootScope.currentUser = null
            $state.go 'auth'
            return
        ), (error) ->
            $rootScope.error = error.data.error
            return
        return
    $rootScope.$watch 'error', ->
        if $rootScope.error
            if $rootScope.error.error && $rootScope.error.error == 'user_not_found'
                $rootScope.logout()
            else
                $rootScope.checkRights($rootScope, $state, $location)
        return