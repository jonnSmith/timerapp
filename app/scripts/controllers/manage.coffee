'use strict'

angular.module('timerApp')
.controller 'ManageCtrl', ($scope, $auth, $state, $rootScope, usersFactory, groupFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Manage users'
    vm.gid = $rootScope.currentUser.group_id
    vm.uid = $rootScope.currentUser.id

    if !($rootScope.currentUser.is_super_admin || $rootScope.currentUser.is_moderator)
        $state.go 'dashboard'

    vm.createUser = () ->
        data =
            email: vm.email
            name: vm.name
            password: vm.password
        if vm.group_id
            data.group_id = vm.group_id.id
        else
            data.group_id = vm.gid
        usersFactory.createUser(data).success((user) ->
            $rootScope.splash = 'User added: ' + user.name
            vm.getGroups()
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

    vm.deleteUserFromGroup = (uid) ->
        gid = vm.gid
        groupFactory.removeGroup(gid, uid).success((response) ->
            $rootScope.splash = 'User deleted: ' + response.status
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setModerator = (uid) ->
        gid = vm.gid
        groupFactory.setModerator(gid, uid).success((response) ->
            $rootScope.splash = 'Moderator changed: ' + response.status
            vm.getGroups()
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
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups = () ->
        groupFactory.getGroups().success((groups) ->
            vm.groups = groups
            usersFactory.setUser()
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.deleteGroup = (gid) ->
        groupFactory.deleteGroup(gid).success((response) ->
            $rootScope.splash = 'Group deleted: ' + response.status
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setGroup = (gid) ->
        groupFactory.setGroup(gid, vm.uid).success((response) ->
            $rootScope.splash = 'Change group: ' + response.status
            vm.gid = gid
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    return
