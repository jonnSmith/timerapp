'use strict'

angular.module('timerApp')
.factory 'groupFactory', ($http,$auth,$rootScope) ->
    urlBase = 'api/usergroups'
    token = $auth.getToken()
    data = token: token
    config =
        params: data
    groupFactory = {}
    groupFactory.createGroup = (data) ->
        $http.post(urlBase+'/create', data)
    groupFactory.getGroups = () ->
        $http.get(urlBase)
    groupFactory.getGroup = (gid) ->
        $http.get(urlBase+'/'+gid)
    groupFactory.deleteGroup = (gid) ->
        $http.delete(urlBase+'/'+gid)
    groupFactory.setGroup = (gid, uid) ->
        $http.post(urlBase + '/'+ gid + '/adduser/' + uid)
    groupFactory.removeGroup = (gid, uid) ->
        $http.post(urlBase + '/'+ gid + '/removeuser/' + uid)
    groupFactory
