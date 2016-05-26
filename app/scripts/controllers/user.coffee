'use strict'

angular.module('timerApp')
.controller 'UserCtrl', ($scope, $auth, $state, $stateParams, $rootScope, userFactory, groupFactory) ->
    $rootScope.error = false
    $rootScope.splash = false
    vm = this
    vm.uid = $stateParams.uid
    $rootScope.title = 'User ' + vm.uid

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
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getUser()

    vm.updateUser = () ->
        data =
            email: vm.user.email
            name: vm.user.name
            user_group_id: vm.user.user_group_id.id
        userFactory.updateUser(vm.uid, data).success((user) ->
            vm.user = user
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setGroup = (gid) ->
        groupFactory.setGroup(gid, vm.user.id).success((response) ->
            $rootScope.splash = response.status
            vm.getUser()
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    return