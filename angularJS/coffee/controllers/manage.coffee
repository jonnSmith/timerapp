'use strict'

angular.module('timerApp')
.controller 'ManageCtrl', ($scope, $auth, $state, $rootScope, usersFactory, groupFactory, userFactory, chartTimesFactory, colorFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    $rootScope.title = 'Manage users'
    vm.gid = $rootScope.currentUser.group_id
    vm.uid = $rootScope.currentUser.id

    vm.showNumber = $rootScope.perPage
    vm.showOffset = 0

    vm.showGroupNumber = $rootScope.perPage
    vm.showGroupOffset = 0

    vm.range =
        period: 'day'
        offset: 0
        count: 30
        order: 'desc'

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
            vm.setTimesStatistic(group.users, vm.range)
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.chartTimes = chartTimesFactory.initVariables(vm.range)

    vm.setTimesStatistic = (users, range) ->
        angular.forEach users, (user, key) ->
            vm.chartTimes = chartTimesFactory.initUserChartTimes(user, vm.chartTimes, 'column',  colorFactory.getRandomColor())
            userFactory.getUserTimes(user.id, range).success((times) ->
                vm.chartTimes = chartTimesFactory.setUserChartTimes(times, user, vm.chartTimes)
                return
            ).error (error) ->
                $rootScope.error = error
                return
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

    vm.setStrike = (uid) ->
        userFactory.userTime(uid, 'strike?value=1').success((response) ->
            $rootScope.splash = 'Strike set: ' + response.status
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.removeStrike = (uid) ->
        userFactory.userTime(uid, 'strike?value=0').success((response) ->
            $rootScope.splash = 'Strike remove: ' + response.status
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setUserTime = (uid, action) ->
        userFactory.userTime(uid, action).success((response) ->
            $rootScope.splash = 'Time changed: ' + action + ' - ' + response.status
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.deleteUserFromGroup = (uid, gid) ->
        groupFactory.removeGroup(gid, uid).success((response) ->
            $rootScope.splash = 'User deleted from group ' + response.status
            vm.getGroupUsers()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return


    vm.deleteUser = (uid) ->
        usersFactory.deleteUser(uid).success((response) ->
            $rootScope.splash = 'User deleted: ' + response.status
            vm.getGroupUsers()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    return
