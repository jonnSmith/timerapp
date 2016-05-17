'use strict'

describe 'Service: AuthService', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  AuthService = {}
  beforeEach inject (_AuthService_) ->
    AuthService = _AuthService_

  it 'should do something', ->
    expect(!!AuthService).toBe true
