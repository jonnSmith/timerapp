'use strict'

angular.module('timerApp')
.factory 'colorFactory', () ->
    colorFactory = {}
    colorFactory.getRandomColor = ->
        letters = '0123456789ABCDEF'.split('')
        color = '#'
        i = 0
        while i < 6
            color += letters[Math.floor(Math.random() * 16)]
            i++
        color
    colorFactory