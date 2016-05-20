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

    time = new Date().getTime()

    vm.time = timeFactory.init(time)
    vm.timer = timerFactory.setTimer(time)

    vm.startTimer = () ->
        startTime = vm.timer.runTimer(true)
        timerStart =
            uid: $rootScope.currentUser.id
            time: startTime
        if $geolocation.position.coords
            timerStart.latitude = $geolocation.position.coords.latitude
            timerStart.longitude = $geolocation.position.coords.longitude
            timerStart.accuracy = $geolocation.position.coords.accuracy
        localStorage.setItem 'timer.start',  JSON.stringify(timerStart)
        return

    vm.startApiTimer = () ->
        apiTimeFactory.startTimer().success((response) ->
            usersFactory.setUser()
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

    vm.stopTimer = () ->
        stopTime = vm.timer.saveTimer()
        timerStop =
            uid: $rootScope.currentUser.id
            time: stopTime
        if $geolocation.position.coords
            timerStop.latitude = $geolocation.position.coords.latitude
            timerStop.longitude = $geolocation.position.coords.longitude
            timerStop.accuracy = $geolocation.position.coords.accuracy
        localStorage.setItem 'timer.stop',  JSON.stringify(timerStop)
        return

    vm.stopApiTimer = () ->
        apiTimeFactory.stopTimer().success((response) ->
            usersFactory.setUser()
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

    vm.getTimer = () ->
        $rootScope.timerStart = JSON.parse(localStorage.getItem('timer.start'))
        $rootScope.timerStop = JSON.parse(localStorage.getItem('timer.stop'))
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
