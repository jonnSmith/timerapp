'use strict'

angular.module('timerApp')
.controller 'DashboardCtrl', ($scope, $auth, $rootScope, $state, groupFactory, userFactory, usersFactory, timeFactory, timerFactory, apiTimeFactory, $geolocation) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Dashboard'

    vm.getUsers = () ->
        usersFactory.getUsers().success((users) ->
            vm.users = users
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUsers()

    vm.getGroupUsers = () ->
        gid = $rootScope.currentUser.group_id
        groupFactory.getGroup(gid).success((group) ->
            vm.group = group
            vm.users = group.users
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.deleteUser = (uid) ->
        usersFactory.deleteUser(uid).success((response) ->
            $rootScope.splash = 'User deleted: ' + response.status
            vm.getUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setStrike = (uid) ->
        userFactory.userTime(uid, 'strike?value=1').success((response) ->
            $rootScope.splash = 'Strike set: ' + response.status
            vm.getUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.removeStrike = (uid) ->
        userFactory.userTime(uid, 'strike?value=0').success((response) ->
            $rootScope.splash = 'Strike remove: ' + response.status
            vm.getUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    #refresh_users_interval = 5.05*60*1000

    #setInterval (->
    #    token = $auth.getToken()
    #    $auth.setToken token
    #    vm.getUsers()
    #    return
    #), refresh_users_interval

    time = new Date().getTime()

    vm.time = timeFactory.init(time)
    vm.timer = timerFactory.setTimer(time)

    if $rootScope.currentUser && $rootScope.currentUser.time_open.start && !angular.isUndefined($rootScope.currentUser.time_open.start)
        vm.timer.runTimer(true, $rootScope.currentUser.time_open.start)

    vm.startApiTimer = () ->
        location =  {}
        if $geolocation.position.coords
            location.latitude = $geolocation.position.coords.latitude
            location.longitude = $geolocation.position.coords.longitude
            location.accuracy = $geolocation.position.coords.accuracy
        data =
            location: JSON.stringify(location)
        apiTimeFactory.startTimer(data).success((response) ->
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

    vm.timer_comment = ''

    vm.stopApiTimer = () ->
        location = {}
        if $geolocation.position.coords
            location.latitude = $geolocation.position.coords.latitude
            location.longitude = $geolocation.position.coords.longitude
            location.accuracy = $geolocation.position.coords.accuracy
        data =
            location: JSON.stringify(location)
            comment: vm.timer_comment
        apiTimeFactory.stopTimer(data).success((response) ->
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
