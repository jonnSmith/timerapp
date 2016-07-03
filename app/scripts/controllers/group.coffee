'use strict'

angular.module('timerApp')
.controller 'GroupCtrl', ($scope, $auth, $state, $rootScope, $stateParams, $filter, usersFactory, userFactory, groupFactory) ->
    vm = this
    $rootScope.error = false
    $rootScope.splash = false
    vm.gid = $stateParams.gid
    vm.uid = $rootScope.currentUser.id
    $rootScope.title = 'Manage group'

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
            vm.setTimesStatistic(group.users)
            return
        ).error (error) ->
            $rootScope.error = error
            return

    #TODO: Fucking rewrite that shit to normal arch

    vm.range =
        period: 'day'
        offset: 0
        count: 30
        order: 'desc'

    vm.time_options =
        series: [],
        axes: x:
            key: 'x'
            type: 'date'

    vm.time_data =
        usertimes: []

    currentDate = new Date()

    i = 0
    while i <= vm.range.count
        x_day = new Date(currentDate.getTime() - (i*24*60*60*1000))
        day =
            x: new Date($filter('date')(x_day, 'yyyy-MM-dd'))
            day: $filter('date')(x_day, 'yyyy-MM-dd')
        vm.time_data.usertimes.push(day)
        i++

    vm.setTimesStatistic = (users) ->
        range = vm.range
        angular.forEach users, (user, key) ->
            graph =
                axis: 'y'
                dataset: 'usertimes'
                key: 'val_'+ user.id
                label: user.name
                color: '#0293FF'
                type: [ 'line' ]
                id: 'mySeries'+user.id
            vm.time_options.series.push(graph)
            angular.forEach vm.time_data.usertimes, (value,key) ->
                usertime = vm.time_data.usertimes[key]
                usertime['val_'+ user.id] = 0
                vm.time_data.usertimes[key] = usertime
            userFactory.getUserTimes(user.id, range).success((times) ->
                angular.forEach times, (value, key) ->
                    if value.end
                        start = Date.parse if angular.isString(value.start) then value.start.replace(/\-/g, '/') else value.start
                        end = Date.parse if angular.isString(value.end) then value.end.replace(/\-/g, '/') else value.end
                        time_range = end - start
                        angular.forEach vm.time_data.usertimes, (value,key) ->
                            usertime = vm.time_data.usertimes[key]
                            if usertime.day == $filter('date')(new Date(start), 'yyyy-MM-dd')
                                totalSec = parseInt(Math.floor(time_range/1000))
                                hours = parseInt(usertime['val_'+ user.id]) + parseInt(totalSec/3600)
                                minutes = (parseInt(parseInt((usertime['val_'+ user.id] - parseInt(usertime['val_'+ user.id]))*100) + (parseInt(totalSec / 60) % 60)))/100
                                if(minutes > 0.6)
                                    hours++
                                    minutes = minutes - 0.6
                                newTime = hours+minutes
                                usertime['val_'+ user.id] = newTime
                                vm.time_data.usertimes[key] = usertime
                return
            ).error (error) ->
                $rootScope.error = error
                return
        return

   #ENDTODO

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
