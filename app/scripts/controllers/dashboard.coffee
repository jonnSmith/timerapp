'use strict'

angular.module('timerApp')
.controller 'DashboardCtrl', ($scope, $auth, $rootScope, $state, usersFactory, timeFactory, timerFactory, apiTimeFactory, $geolocation) ->

    $rootScope.error = false
    $rootScope.title = 'Dashboard'
    vm = this

    usersFactory.getUsers().success((users) ->
        vm.users = users
        return
    ).error (error) ->
        $rootScope.error = error
        return

    vm.refreshUsers = () ->
        usersFactory.getUsers().success((users) ->
            vm.users = users
            return
        ).error (error) ->
            $rootScope.error = error
            return

    time = new Date().getTime()

    vm.time = timeFactory.init(time)
    vm.timer = timerFactory.setTimer(time)

    vm.timer.runTimer(true, $rootScope.currentUser.time_open.start)

    vm.startApiTimer = () ->
        location =  {}
        if $geolocation.position.coords
            location.latitude = $geolocation.position.coords.latitude
            location.longitude = $geolocation.position.coords.longitude
            location.accuracy = $geolocation.position.coords.accuracy
        location = JSON.stringify(location)
        apiTimeFactory.startTimer(location).success((response) ->
            usersFactory.setUser()
            vm.timer.runTimer(true, $rootScope.currentUser.time_open.start)
            usersFactory.getUsers().success((users) ->
                vm.users = users
                return
            ).error (error) ->
                $rootScope.error = error
                return
            return
        ).error (error) ->
            $rootScope.error = error
            return
        return

    vm.stopApiTimer = () ->
        location = {}
        if $geolocation.position.coords
            location.latitude = $geolocation.position.coords.latitude
            location.longitude = $geolocation.position.coords.longitude
            location.accuracy = $geolocation.position.coords.accuracy
        location = JSON.stringify(location)
        apiTimeFactory.stopTimer(location).success((response) ->
            usersFactory.setUser()
            vm.timer.saveTimer()
            usersFactory.getUsers().success((users) ->
                vm.users = users
                return
            ).error (error) ->
                $rootScope.error = error
                return
            return
        ).error (error) ->
            $rootScope.error = error
            return
        return

    vm.token = $auth.getToken()

    vm.logout = ->
        $auth.logout().then ->
            localStorage.removeItem 'user'
            $rootScope.authenticated = false
            $rootScope.currentUser = null
            $state.go 'auth'
            return
        return

    return
