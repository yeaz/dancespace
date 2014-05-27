google.maps.event.addDomListener(window, 'load', initMaps);
var map = null;
var geocoder = null; 
var marker = null; 
var studioMap = null; 
var studioGeocoder = null; 
var studioMarker = null; 

function initMaps() {
    initEventMap();
    initStudioMap(); 
}

function initStudioMap() {
    studioGeocoder = new google.maps.Geocoder();
    var studioMapDiv = document.getElementById('set-studio-location-map');
    if (studioMapDiv != null) {
        studioMap = new google.maps.Map(studioMapDiv, {
            center: new google.maps.LatLng(37.4, -122.2),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        studioMarker = new google.maps.Marker({
            position: studioMap.getCenter(),
            map: studioMap,
            draggable: true,
            visible: true}); 
        google.maps.event.addListener(studioMarker, 'drag', function() {
            updateStudioCoordsOnPage(studioMarker.getPosition()); 
        });
        var url = constructGetStudioAddressUrl();
        jQuery.get(url, function(data) {
            if (data["address"]) {
                document.getElementById('address').value = data["address"];
                codeStudioAddress(); 
             }
             else {
                 studioMap.setCenter(new google.maps.LatLng(data["lat"], data["lng"]));
                 studioMarker.setPosition(studioMap.getCenter()); 
             }
        });
    }
}

function constructGetStudioAddressUrl() {
    var url = window.location.pathname;
    var re = /\/studios\/+([0-9]+)\/+set_location/;
    var reArray = re.exec(url);
    return "/studios/" + reArray[1] + "/get_address"; 
}

function initEventMap() {
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
            if (data["address"]) {
                document.getElementById('address').value = data["address"];
                codeAddress(); 
            }
            else {
                map.setCenter(new google.maps.LatLng(data["lat"], data["lng"]));
                marker.setPosition(map.getCenter()); 
            }
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

function codeStudioAddress() {
    var address = document.getElementById('address').value;
    var error = document.getElementById('error'); 
    studioGeocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            studioMap.setCenter(results[0].geometry.location);
            studioMarker.setPosition(studioMap.getCenter());
            updateStudioCoordsOnPage(studioMarker.getPosition());
            error.innerHTML = ""; 
        } else {
            error.innerHTML = "Error - invalid address."; 
        }
    }); 
}

function updateStudioCoordsOnPage(pos) {
    var studio_lat = document.getElementById('studio_lat');
    var studio_lng = document.getElementById('studio_lng');
    studio_lat.value = Math.round(pos.lat() * 10) / 10;
    studio_lng.value = Math.round(pos.lng() * 10) / 10; 
}


function updateCoordsOnPage(pos) {
    var event_lat = document.getElementById('event_lat');
    var event_lng = document.getElementById('event_lng');
    event_lat.value =  Math.round(pos.lat() * 10) / 10;
    event_lng.value =  Math.round(pos.lng() * 10) / 10;
}
