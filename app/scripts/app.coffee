'use strict'

angular
.module('timerApp', [
    'ui.router',
    'satellizer',
    'ngGeolocation',
    'ngMap',
    'ngStorage',
    '720kb.datepicker',
    'n3-line-chart',
    'angular-web-notification'
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
    .state 'manage',
        url: '/manage'
        templateUrl: 'views/manage.html'
        controller: 'ManageCtrl as manage'
    .state 'user',
        url: '/users/:uid'
        templateUrl: 'views/user.html'
        controller: 'UserCtrl as user'
    .state 'group',
        url: '/group/:gid'
        templateUrl: 'views/group.html'
        controller: 'GroupCtrl as group'
    .state 'settings',
        url: '/settings'
        templateUrl: 'views/settings.html'
        controller: 'SettingsCtrl as user'
    return
    #$locationProvider
    #.html5Mode
        #enabled: true
        #requireBase: false
.run ($rootScope, $localStorage, $state, $location, $auth, $geolocation,usersFactory,timerFactory,webNotificationFactory) ->
    $rootScope.authenticated = false
    $rootScope.language = 'en'
    $rootScope.title = 'LAB Timer'
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.interval= 10*60*1000
    $rootScope.token = $auth.getToken()
    $rootScope.token_is_refreshing = false
    $rootScope.devmode = false
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
            if $state.$urlRouter.location == '' || $state.$urlRouter.location == '/auth' || $state.$urlRouter.location == 'auth'
                $location.path('/dashboard')
        else if !$user || !$is_auth
            $rootScope.logout()
            $location.path('/auth')
        return
    $rootScope.refreshToken = ->
        $is_auth = $auth.isAuthenticated()
        if $is_auth
            $rootScope.token_is_refreshing = true
            usersFactory.refreshUser().success((response) ->
                token = response.token
                $rootScope.token = token
                $auth.setToken token
                $rootScope.token_is_refreshing = false
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
            webNotificationFactory.showMessage('Error:', $rootScope.error, 'images/notification.png')
            if $rootScope.error.error && $rootScope.error.error == 'user_not_found'
                $rootScope.logout()
            else
                $rootScope.checkRights()
        return

    $rootScope.$watch 'splash', ->
        if $rootScope.splash
            webNotificationFactory.showMessage('Action:', $rootScope.splash, 'images/notification.png')
        return