'use strict'

angular.module('timerApp')
.factory 'chartTimesFactory', ($filter) ->

    chartTimesFactory = {}

    chartTimesFactory.initVariables = (range) ->
        chartTimes = {}
        chartTimes.time_options =
            series: [],
            axes: x:
                key: 'x'
                type: 'date'
        chartTimes.time_data =
            usertimes: []
        currentDate = new Date()
        i = 0
        unit = 24*60*60*1000
        while i <= range.count
            x_day = new Date(currentDate.getTime() - (i*unit))
            day =
                x:  new Date($filter('date')(x_day, 'yyyy-MM-dd'))
                day: $filter('date')(x_day, 'yyyy-MM-dd')
            chartTimes.time_data.usertimes.push(day)
            i++
        chartTimes

    chartTimesFactory.initUserChartTimes = (user, chartTimes, type, color) ->
        graph =
            axis: 'y'
            dataset: 'usertimes'
            key: 'val_'+ user.id
            label: user.name
            color: color
            type: [ type ]
            id: 'mySeries'+user.id
        chartTimes.time_options.series.push(graph)
        angular.forEach chartTimes.time_data.usertimes, (value,key) ->
            usertime = chartTimes.time_data.usertimes[key]
            usertime['val_'+ user.id] = 0
            chartTimes.time_data.usertimes[key] = usertime
        chartTimes

    chartTimesFactory.setUserChartTimes = (times, user, chartTimes) ->
        angular.forEach times, (value, key) ->
            if value.end
                start = Date.parse if angular.isString(value.start) then value.start.replace(/\-/g, '/') else value.start
                end = Date.parse if angular.isString(value.end) then value.end.replace(/\-/g, '/') else value.end
                time_range = end - start
                angular.forEach chartTimes.time_data.usertimes, (value,key) ->
                    usertime = chartTimes.time_data.usertimes[key]
                    if usertime.day == $filter('date')(new Date(start), 'yyyy-MM-dd')
                        totalSec = parseInt(Math.floor(time_range/1000))
                        hours = parseInt(usertime['val_'+ user.id]) + parseInt(totalSec/3600)
                        minutes = (parseInt(parseInt((usertime['val_'+ user.id] - parseInt(usertime['val_'+ user.id]))*100) + (parseInt(totalSec / 60) % 60)))/100
                        if(minutes >= 0.6)
                            hours++
                            minutes = minutes - 0.6
                        newTime = hours+minutes
                        usertime['val_'+ user.id] = newTime
                        chartTimes.time_data.usertimes[key] = usertime
        chartTimes

    chartTimesFactory

