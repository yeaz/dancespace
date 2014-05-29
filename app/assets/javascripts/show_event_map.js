google.maps.event.addDomListener(window, 'load', loadMaps);
var showMap = null; 
var marker = null;
var feedMap = null; 

function constructUrl() {
    var url = window.location.pathname;
    var re = /[.]*\/events\/+([0-9]+)\/*/;
    var reArray = re.exec(url); 
    return "/events/" + reArray[1] + "/get_coordinates"; 
}

function loadMaps() {
    loadMap();
    loadFeedMap("/get_events_in_bounds"); 
}

function loadFeedMap(fn_name) {
    var feedMapDiv = document.getElementById('events-feed-map-canvas');
    if (feedMapDiv != null) {
        feedMap = new google.maps.Map(feedMapDiv, {
            center: new google.maps.LatLng(37.5, -122.2),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
       });
       geocoder = new google.maps.Geocoder();
       google.maps.event.clearInstanceListeners(feedMap); 
       google.maps.event.addListener(feedMap, 'bounds_changed', function() { updateDisplayed(fn_name); });
       $("#code_address_submit").click(function() { codeAddressAndUpdate(fn_name); });
    }
}

function updateDisplayed(fn_name) {
    var bounds = feedMap.getBounds(); 
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    var url = fn_name + "?n=" + encodeURIComponent(ne.lat()) + "&e=" + encodeURIComponent(ne.lng()) + "&s=" + encodeURIComponent(sw.lat()) + "&w=" + encodeURIComponent(sw.lng());
    jQuery.get(url, function(data) {
        document.getElementById('all_events').innerHTML = data; 
    }); 
}

function codeAddressAndUpdateEvents() {
    codeAddressAndUpdate("/get_events_in_bounds"); 
}

function codeAddressAndUpdate(fn_name) {
    var address = document.getElementById('events_feed_address').value;
    var error = document.getElementById('events_feed_error');
    geocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            feedMap.setCenter(results[0].geometry.location);
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
            if (!data["error"]) {
                showMap = new google.maps.Map(mapDiv, {
                    center: new google.maps.LatLng(data["lat"], data["lng"]), 
                    zoom: 10,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                });
                marker = new google.maps.Marker({
                    position: showMap.getCenter(),
                    map: map,
                    visible: true});
            }
            else {
                mapDiv.innerHTML = "No location set"; 
            }
        }); 

    }
}
