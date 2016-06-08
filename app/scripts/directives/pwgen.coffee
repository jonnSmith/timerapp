'use strict'

angular.module('timerApp')
.directive('pwgen', ($timeout) ->
    {
        scope:
            model: '=ngModel'
            disabled: '=ngDisabled'
            length: '@'
            placeholder: '@'
        require: 'ngModel'
        restrict: 'E'
        replace: 'true'
        template: '' + '<div class="angular-bootstrap-pwgen">' +
          '<div class="input-group">' +
          '<input class="form-control" ng-model="password" ng-disabled="disabled" ng-class="{\'angular-bootstrap-pwgen-fixed-font\': passwordNotNull}" minlength="4" placeholder="{{placeholder}}">' +
          '<span class="input-group-btn">' +
          '<button class="btn btn-default btn-pwgen bg-primary" type="button" ng-disabled="disabled" ng-click="generatePasswordStart()">' +
          '<i class="material-icons color-text">vpn_key</i>' +
          '</button>' +
          '</span>' +
          '</div>' +
          '</div>'
        link: (scope, elem, attrs, modelCtrl) ->
            scope.$watch 'model', ->
                scope.password = scope.model
                return
            scope.passwordNotNull = false
            scope.$watch 'password', ->
                scope.model = scope.password
                if scope.password != undefined and scope.password != null and scope.password != ''
                    scope.passwordNotNull = true
                else
                    scope.passwordNotNull = false
                return
            scope.progressDivShow = false

            scope.generatePasswordStart = ->
                scope.progressDivShow = true
                scope.progressValue = 0
                scope.progressWidth = 'width': scope.progressValue + '%'
                scope.generatePasswordProgress()
                return

            scope.generatePasswordProgress = ->
                $timeout (->
                    if scope.progressValue < 100
                        scope.password = scope.generatePassword(scope.length, false)
                        scope.progressValue += 1
                        scope.progressWidth = 'width': scope.progressValue + '%'
                        scope.generatePasswordProgress()
                    else
                        scope.progressDivShow = false
                    return
                ), 10
                return

            scope.vowel = /[aeiouAEIOU]$/
            scope.consonant = /[bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]$/

            scope.generatePassword = (length, memorable, pattern, prefix) ->
                char = undefined
                n = undefined
                if length == undefined or length == null
                    length = 10
                if memorable == undefined or memorable == null
                    memorable = true
                if pattern == undefined or pattern == null
                    pattern = /[a-zA-Z0-9]/
                if prefix == undefined or prefix == null
                    prefix = ''
                if prefix.length >= length
                    return prefix
                if memorable
                    if prefix.match(scope.consonant)
                        pattern = scope.vowel
                    else
                        pattern = scope.consonant
                n = Math.floor(Math.random() * 100) % 94 + 33
                char = String.fromCharCode(n)
                if memorable
                    char = char.toLowerCase()
                if !char.match(pattern)
                    return scope.generatePassword(length, memorable, pattern, prefix)
                scope.generatePassword length, memorable, pattern, '' + prefix + char

            return
    }
)
