google.maps.event.addDomListener(window, 'load', initMap); 

var map = null;
var geocoder = null; 

function initMap() {
    var mapDiv = document.getElementById('studios-feed-map-canvas');
    if (mapDiv != null) {
        map = new google.maps.Map(mapDiv, {
            center: new google.maps.LatLng(37.5, -122.2),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        geocoder = new google.maps.Geocoder();
        google.maps.event.addDomListener(map, 'bounds_changed', updateDisplayedStudios); 
    }
}

function codeAddressAndUpdateStudios() {
    var address = document.getElementById('studio_feed_address').value;
    var error = document.getElementById('studios_feed_error');
    geocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            error.innerHTML = "";
            updateDisplayedStudios();
        }
        else {
            error.innerHTML = "Error - invalid address"; 
        }
     }); 
}

function updateDisplayedStudios() {
    var bounds = map.getBounds(); 
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    var url = "/get_studios_in_bounds?n=" + encodeURIComponent(ne.lat()) + "&e=" + encodeURIComponent(ne.lng()) + "&s=" + encodeURIComponent(sw.lat()) + "&w=" + encodeURIComponent(sw.lng());
    jQuery.get(url, function(data) {
        document.getElementById('all_studios').innerHTML = data; 
    }); 
}
