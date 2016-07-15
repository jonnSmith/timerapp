'use strict'

angular.module('timerApp')
.controller 'DashboardCtrl', ($scope, $auth, $rootScope, $geolocation, $filter , $localStorage, $state, groupFactory, userFactory, usersFactory, timeFactory, timerFactory, apiTimeFactory, ipLocationFactory, webNotificationFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Dashboard'

    vm.showNumber = $rootScope.perPage
    vm.showOffset = 0

    vm.getUsers = () ->
        usersFactory.getUsers().success((users) ->
            vm.users = users
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

    vm.setUserTime = (uid, action) ->
        userFactory.userTime(uid, action).success((response) ->
            $rootScope.splash = 'Time changed: ' + action + ' - ' + response.status
            vm.getUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.deleteUserFromGroup = (uid, gid) ->
        groupFactory.removeGroup(gid, uid).success((response) ->
            $rootScope.splash = 'User deleted from group ' + response.status
            vm.getUsers()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setModerator = (uid, gid) ->
        groupFactory.setModerator(gid, uid).success((response) ->
            $rootScope.splash = 'Moderator changed: ' + response.status
            vm.getUsers()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    time = new Date().getTime()

    vm.time = timeFactory.init(time)
    vm.timer = timerFactory.setTimer(time)

    if $rootScope.currentUser != null && $rootScope.currentUser.time_is_open
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
            $rootScope.splash = 'Time start: ' + response.status
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

    comment = $localStorage.comment

    if comment
        vm.timer_comment = comment
    else
        vm.timer_comment = ''

    $scope.$watch 'dashboard.timer_comment', ->
        $localStorage.comment = vm.timer_comment
        return

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
            delete $localStorage.comment
            vm.timer_comment = ''
            $rootScope.splash = 'Time stop: ' + response.status
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

    vm.getIpLocation = (ip) ->
        ipLocationFactory.getLocationByIP(ip).success((response) ->
            location = {}
            location.latitude = response.loc.split(',')[0]
            location.longitude = response.loc.split(',')[1]
            location
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUsers()

    interval = 1*60*1000

    setInterval (->
        if !$rootScope.token_is_refreshing
            vm.getUsers()
            usersFactory.setUser()
            if $rootScope.devmode
                webNotificationFactory.showMessage('Background:', 'Users updated', 'images/notification.png')
        return
    ), interval

    return