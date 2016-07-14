'use strict'

angular.module('timerApp')
.controller 'GroupCtrl', ($scope, $auth, $state, $rootScope, $stateParams, $filter, usersFactory, userFactory, groupFactory, chartTimesFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    vm.gid = $stateParams.gid
    vm.uid = $rootScope.currentUser.id
    $rootScope.title = 'Manage group'

    vm.range =
        period: 'day'
        offset: 0
        count: 30
        order: 'desc'

    if !$rootScope.currentUser.is_super_admin
        $state.go 'dashboard'

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
            vm.setTimesStatistic(group.users, vm.range)
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.chartTimes = chartTimesFactory.initVariables(vm.range)

    vm.setTimesStatistic = (users, range) ->
        angular.forEach users, (user, key) ->
            vm.chartTimes = chartTimesFactory.initUserChartTimes(user, vm.chartTimes, 'column',  getRandomColor())
            userFactory.getUserTimes(user.id, range).success((times) ->
                vm.chartTimes = chartTimesFactory.setUserChartTimes(times, user, vm.chartTimes)
                return
            ).error (error) ->
                $rootScope.error = error
                return
        return

    getRandomColor = ->
        letters = '0123456789ABCDEF'.split('')
        color = '#'
        i = 0
        while i < 6
          color += letters[Math.floor(Math.random() * 16)]
          i++
        color

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

    vm.deleteUser = (uid) ->
        usersFactory.deleteUser(uid).success((response) ->
            $rootScope.splash = 'User deleted: ' + response.status
            vm.getGroupUsers()
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

    vm.deleteGroup = (gid) ->
        groupFactory.deleteGroup(gid).success((response) ->
            $rootScope.splash = 'Group deleted: ' + response.status
            vm.getGroups()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setModerator = (uid) ->
        gid = vm.gid
        groupFactory.setModerator(gid,uid).success((response) ->
            $rootScope.splash = 'Moderator changed: ' + response.status
            vm.getGroupUsers()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return


    vm.updateGroup = () ->
        data =
            title: vm.group.title
            description: vm.group.description
        groupFactory.updateGroup(vm.gid,data).success((response) ->
            $rootScope.splash = 'Group changed: ' + response.status
            vm.getGroupUsers()
            vm.getGroups()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.setGroup = (gid) ->
        groupFactory.setGroup(gid, vm.uid).success((response) ->
            $rootScope.splash = 'Change group: ' + response.status
            vm.getGroupUsers()
            vm.getGroups()
            usersFactory.setUser()
            return
        ).error (error) ->
            $rootScope.error = error
            return

    vm.getGroups()

    return
