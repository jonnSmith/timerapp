'use strict'

angular.module('timerApp')
.directive('addressShow', ($rootScope) ->
    template: '<address></address>'
    restrict: 'E'
    link: (scope, element, attrs) ->
        geocoder = new (google.maps.Geocoder)
        location = JSON.parse(attrs.location)
        latlng = new (google.maps.LatLng)(location.latitude, location.longitude)
        geocoder.geocode { 'latLng': latlng }, (results, status) ->
            if status == google.maps.GeocoderStatus.OK
                if results[0]
                    element.text results[0].formatted_address
                else
                    element.text 'Location not found'
            else
                element.text 'Geocoder failed due to: ' + status
            return
        return
    replace: true
)
