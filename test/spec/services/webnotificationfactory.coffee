'use strict'

describe 'Service: webNotificationFactory', ->

  # load the service's module
  beforeEach module 'timerApp'

  # instantiate service
  webNotificationFactory = {}
  beforeEach inject (_webNotificationFactory_) ->
    webNotificationFactory = _webNotificationFactory_

  it 'should do something', ->
    expect(!!webNotificationFactory).toBe true
