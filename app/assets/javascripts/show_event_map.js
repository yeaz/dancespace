google.maps.event.addDomListener(window, 'load', loadMaps);
var map = null; 
var marker = null;
var eventsMap = null; 
var eventsGeocoder = null; 

function constructUrl() {
    var url = window.location.pathname;
    var re = /[.]*\/events\/+([0-9]+)\/*/;
    var reArray = re.exec(url); 
    return "/events/" + reArray[1] + "/get_coordinates"; 
}

function loadMaps() {
    loadMap();
    loadEventFeedMap(); 
}

function loadEventFeedMap() {
    var eventsMapDiv = document.getElementById('events-feed-map-canvas');
    if (eventsMapDiv != null) {
        eventsMap = new google.maps.Map(eventsMapDiv, {
            center: new google.maps.LatLng(37, 122),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
       });
       geocoder = new google.maps.Geocoder(); 
    }
}

function codeAddressAndUpdateEvents() {
    var address = document.getElementById('events_feed_address').value;
    var error = document.getElementById('events_feed_error');
    geocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            eventsMap.setCenter(results[0].geometry.location);
            error.innerHTML = "";
        }
        else {
            error.innerHTML = "Error - invalid address"; 
        }
    }); 
}

function loadMap() {
    var mapDiv = document.getElementById('show-event-map-canvas'); 
    if (mapDiv != null) {
        var url = constructUrl(); 
        jQuery.get(url, function(data) {
            console.log(data); 
            if (!data["error"]) {
                map = new google.maps.Map(mapDiv, {
                    center: new google.maps.LatLng(data["lat"], data["lng"]), 
                    zoom: 10,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });
                marker = new google.maps.Marker({
                    position: map.getCenter(),
                    map: map,
                    visible: true});
            }
            else {
                mapDiv.innerHTML = "No location set"; 
            }
        }); 

    }
}
