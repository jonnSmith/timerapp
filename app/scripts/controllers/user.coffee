'use strict'

angular.module('timerApp')
.controller 'UserCtrl', ($scope, $auth, $state, $stateParams, $rootScope, userFactory, usersFactory, groupFactory) ->
    $rootScope.error = false
    $rootScope.splash = false
    vm = this
    vm.uid = $stateParams.uid
    $rootScope.title = 'User Page'

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
        order: 'asc'

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
            user_group_id: vm.user.user_group_id.id
        userFactory.updateUser(vm.uid, data).success((user) ->
            vm.user = user
            usersFactory.setUser()
            $rootScope.title = user.name
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