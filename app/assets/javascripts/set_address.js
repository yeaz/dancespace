google.maps.event.addDomListener(window, 'load', initMaps);
var eventMap = null;
var eventMarker = null; 
var studioMap = null; 
var studioMarker = null; 

function initMaps() {
    initEventMap();
    initStudioMap(); 
}

function makeGenericMap(divName) {
    var mapDiv = document.getElementById(divName);
    if (mapDiv != null) {
        return new google.maps.Map(mapDiv, {
            center: new google.maps.LatLng(37.4, -122.2),
            zoom: 10,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
    }
}

function makeMarker(currMap, toDrag) {
    return new google.maps.Marker({
        position: currMap.getCenter(),
        map: currMap,
        draggable: toDrag,
        visible: true}); 
}

function divExists(name) {
    return document.getElementById(name) != null; 
}

function getAndSetAddress(url, currMap, currMarker) {
    jQuery.get(url, function(data) {
        loc = new google.maps.LatLng(data["lat"], data["lng"]); 
        currMap.setCenter(loc); 
        currMarker.setPosition(loc); 
    }); 
}

function initStudioMap() {
    if (divExists('set-studio-location-map')) {
        studioMap = makeGenericMap('set-studio-location-map');
     
        studioMarker = makeMarker(studioMap, true);
        if (divExists('editing_studio')) {
            var url = '/studios/' + $("#editing_studio").text() + '/get_coordinates'; 
            getAndSetAddress(url, studioMap, studioMarker); 
        }
        google.maps.event.addListener(studioMarker, 'drag', function() {
            updateStudioCoordsOnPage(studioMarker.getPosition()); 
        });
    }
    
}

function initEventMap() {
    if (divExists('set-event-location-map')) {
        eventMap = makeGenericMap('set-event-location-map');
        eventMarker = makeMarker(eventMap, true);
        if (divExists('editing_event')) {
            var url = '/events/' + $("#editing_event").text() + '/get_coordinates';
            getAndSetAddress(url, eventMap, eventMarker); 
        }
        google.maps.event.addListener(eventMarker, 'drag', function() {
            updateCoordsOnPage(eventMarker.getPosition()); 
        });
    }

}

function codeNewEventAddress() {
    codeAddress(eventMap, eventMarker, updateCoordsOnPage); 
}

function codeNewStudioAddress() {
    codeAddress(studioMap, studioMarker, updateStudioCoordsOnPage); 
}

function codeAddress(currMap, currMarker, updateFn) {
    geocoder = new google.maps.Geocoder();  
    var address = document.getElementById('address').value; 
    var error = document.getElementById('error'); 
    geocoder.geocode( { 'address' : address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            currMap.setCenter(results[0].geometry.location);
            currMarker.setPosition(currMap.getCenter());
            updateFn(currMarker.getPosition()); 
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
