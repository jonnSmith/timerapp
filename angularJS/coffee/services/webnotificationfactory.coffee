'use strict'

angular.module('timerApp')
.factory 'webNotificationFactory', (webNotification) ->

    webNotificationFactory = {}

    webNotificationFactory.showMessage = (title, text, icon) ->
        interval = 15*1000
        webNotification.showNotification title, {
            body: text
            icon: icon
            autoClose:  interval
        }, (error, hide) ->
            if error
                console.log 'Unable to show notification: ' + error.message
            else
                setTimeout (->
                    console.log 'Hiding notification....'
                    hide()
                    return
                ), interval
            return
        return

    webNotificationFactory
