google.maps.event.addDomListener(window, 'load', initMap);
var map = null;
var geocoder = null; 
var marker = null; 

function initMap() {
    geocoder = new google.maps.Geocoder();
    var mapDiv = document.getElementById('set-location-map-canvas');
    if (mapDiv != null) {
        map = new google.maps.Map(mapDiv, {
            center: new google.maps.LatLng(37.4, -122.2),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        marker = new google.maps.Marker({
            position: map.getCenter(),
            map: map,
            draggable: true,
            visible: true}); 
        google.maps.event.addListener(marker, 'drag', function() {
            updateCoordsOnPage(marker.getPosition()); 
        });
        var url = constructGetAddressUrl(); 
        jQuery.get(url, function(data) {
            document.getElementById('address').value = data["address"];
            codeAddress(); 
        });
    }

}

function constructGetAddressUrl() {
    var url = window.location.pathname;
    var re = /\/events\/+([0-9]+)\/+set_location/;
    var reArray = re.exec(url);
    return "/events/" + reArray[1] + "/get_address/"; 
}

function codeAddress() {
    var address = document.getElementById('address').value; 
    var error = document.getElementById('error'); 
    geocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            marker.setPosition(map.getCenter());
            updateCoordsOnPage(marker.getPosition());
            error.innerHTML = ""; 
        } else {
            error.innerHTML = "Error - invalid address."; 
        }
    }); 
}

function updateCoordsOnPage(pos) {
    var event_lat = document.getElementById('event_lat');
    var event_lng = document.getElementById('event_lng');
    event_lat.value =  Math.round(pos.lat() * 10) / 10;
    event_lng.value =  Math.round(pos.lng() * 10) / 10;
}
