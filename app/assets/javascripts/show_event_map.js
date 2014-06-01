google.maps.event.addDomListener(window, 'load', loadMaps);
var showEventMap = null; 
var showEventMarker = null;
var feedMap = null; 

function constructUrl() {
    var url = window.location.pathname;
    var re = /[.]*\/events\/+([0-9]+)\/*/;
    var reArray = re.exec(url); 
    return "/events/" + reArray[1] + "/get_coordinates"; 
}

function loadMaps() {
    loadShowEventMap(); 
    loadFeedMap("/get_events_in_bounds"); 
}

function loadFeedMap(fn_name) {
    if (divExists('events-feed-map-canvas')) {
        feedMap = makeGenericMap('events-feed-map-canvas'); 
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

function loadShowEventMap() {
    loadShowMap('show-event-map-canvas', eventSetCoordsUrl, eventGetAddressUrl);
}

function eventGetAddressUrl() {
    return "/events/" + getEventId() + "/get_address"; 
}

function getEventId() {
    return $("#get_event_id").text(); 
}

function eventSetCoordsUrl() {
    return "/events/" + getEventId() + "/set_coordinates"; 
}
