'use strict'

angular.module('timerApp')
  .factory 'AuthService', ->
    # Service logic
    # ...

    meaningOfLife = 42

    # Public API here
    {
      someMethod: ->
        meaningOfLife
    }
