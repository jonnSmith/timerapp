'use strict'

angular.module('timerApp')
.controller 'GroupCtrl', ($scope, $auth, $state, $rootScope, $stateParams, usersFactory, groupFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    vm.gid = $stateParams.gid
    $rootScope.title = 'Manage group'

    vm.createUser = () ->
        data =
            email: vm.email
            name: vm.name
            password: vm.password
            group_id: vm.group_id.id
        usersFactory.createUser(data).success((user) ->
            $rootScope.splash = 'User added: ' + user.name
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroupUsers = () ->
        gid = vm.gid
        groupFactory.getGroup(gid).success((group) ->
            vm.group = group
            vm.users = group.users
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroupUsers()

    vm.deleteUserFromGroup = (uid) ->
        gid = vm.gid
        groupFactory.removeGroup(gid,uid).success((response) ->
            $rootScope.splash = 'User deleted: ' + response.status
            vm.getGroupUsers()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.createGroup = () ->
        data =
            title: vm.group_name
            description: vm.group_description
        groupFactory.createGroup(data).success((group) ->
            $rootScope.splash = 'Group added: ' + group.title
            vm.getGroups()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups = () ->
        groupFactory.getGroups().success((groups) ->
            vm.getGroupUsers()
            vm.groups = groups
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    vm.deleteGroup = (gid) ->
        groupFactory.deleteGroup(gid).success((response) ->
            $rootScope.splash = 'Group deleted: ' + response.status
            vm.getGroups()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    return
