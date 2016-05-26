'use strict'

angular.module('timerApp')
.controller 'UsersCtrl', ($scope, $auth, $state, $rootScope, usersFactory, groupFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Create user'

    vm.createUser = () ->
        data =
            email: vm.email
            name: vm.name
            password: vm.password
        usersFactory.createUser(data).success((user) ->
            $rootScope.splash = 'User added: ' + user.name
            return
        ).error (error) ->
            $rootScope.error = error
            return
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
        return

    vm.getGroups = () ->
        groupFactory.getGroups().success((groups) ->
            vm.groups = groups
            #console.log vm.groups
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    vm.deleteGroup = (gid) ->
        groupFactory.deleteGroup(gid).success((response) ->
            $rootScope.splash = 'Group deleted: ' + response.status
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    return
