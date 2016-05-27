'use strict'

angular.module('timerApp')
.controller 'UserCtrl', ($scope, $auth, $state, $stateParams, $rootScope, userFactory, usersFactory, groupFactory, $filter) ->
    $rootScope.error = false
    $rootScope.splash = false
    vm = this
    vm.uid = $stateParams.uid
    $rootScope.title = 'User Page'

    currentTime = new Date()
    vm.startDate = vm.endDate = vm.currentDate = $filter('date')(currentTime, 'yyyy-MM-dd')

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
        vm.getUserTimes()



    vm.getGroups = () ->
        groupFactory.getGroups().success((groups) ->
            vm.groups = groups
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    vm.getUser = () ->
        userFactory.getUser(vm.uid).success((user) ->
            vm.user = user
            $rootScope.title = user.name
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUser()

    vm.range =
        period: 'day'
        offset: 0
        count: 1
        order: 'desc'

    vm.getUserTimes = () ->
        range = vm.range
        userFactory.getUserTimes(vm.uid, range).success((times) ->
            vm.times = times
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUserTimes()

    vm.updateUser = () ->
        data =
            email: vm.user.email
            name: vm.user.name
            password: vm.user.password
            group_id: vm.group_id
        userFactory.updateUser(vm.uid, data).success((user) ->
            vm.user = user
            usersFactory.setUser()
            $rootScope.title = user.name
            $rootScope.splash = 'User updated: ' + user.name
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setGroup = (gid) ->
        groupFactory.setGroup(gid, vm.user.id).success((response) ->
            $rootScope.splash = 'Change group: ' + response.status
            vm.getUser()
            vm.getGroups()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    return