'use strict'

angular.module('timerApp')
.controller 'SettingsCtrl', ($scope, $auth, $state, $rootScope, $localStorage, userFactory, usersFactory, groupFactory, $filter) ->
    $rootScope.error = false
    $rootScope.splash = false
    vm = this
    vm.uid = $rootScope.currentUser.id
    $rootScope.title = 'My settings'

    vm.showNumber = $rootScope.perPage
    vm.showOffset = 0

    vm.showGroupNumber = $rootScope.perPage
    vm.showGroupOffset = 0

    vm.range =
        period: 'day'
        offset: 0
        count: 1
        order: 'desc'

    currentTime = new Date()
    vm.currentDate = $filter('date')(currentTime, 'yyyy-MM-dd')

    myStartDate = $localStorage.startDate
    if myStartDate
        vm.startDate = myStartDate
    else
        vm.startDate = $filter('date')(currentTime, 'yyyy-MM-dd')

    myEndDate = $localStorage.endDate

    if myEndDate
        vm.endDate = myEndDate
    else
        vm.endDate = $filter('date')(currentTime, 'yyyy-MM-dd')

    $scope.$watch 'user.startDate', ->
        vm.setRange()
        return

    $scope.$watch 'user.endDate', ->
        vm.setRange()
        return

    vm.setRange = () ->
        start = Date.parse if angular.isString(vm.startDate) then vm.startDate.replace(/\-/g, '/') else vm.startDate
        end = Date.parse if angular.isString(vm.endDate) then vm.endDate.replace(/\-/g, '/') else vm.endDate
        current = Date.parse if angular.isString(vm.currentDate) then vm.currentDate.replace(/\-/g, '/') else vm.currentDate
        vm.range.offset = (current - end)/(1000*60*60*24)
        vm.range.count = (end - start)/(1000*60*60*24) + 1
        $localStorage.startDate = vm.startDate
        $localStorage.endDate = vm.endDate
        vm.getUserTimes()

    vm.getGroups = () ->
        groupFactory.getGroups().success((groups) ->
            vm.groups = groups
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUser = () ->
        userFactory.getUser(vm.uid).success((user) ->
            vm.user = user
            vm.group_id = vm.user.group_id
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUserTimes = () ->
        range = vm.range
        userFactory.getUserTimes(vm.uid, range).success((times) ->
            vm.times = times
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.updateUser = () ->
        data =
            email: vm.user.email
            name: vm.user.name
            password: vm.user.password
        userFactory.updateUser(vm.uid, data).success((user) ->
            vm.user = user
            usersFactory.setUser()
            vm.getGroups()
            $rootScope.title = user.name
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setGroup = (gid) ->
        groupFactory.setGroup(gid, vm.uid).success((response) ->
            $rootScope.splash = 'Change group: ' + response.status
            vm.getUser()
            usersFactory.setUser()
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return


    vm.getUser()
    vm.getGroups()

    return
