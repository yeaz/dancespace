google.maps.event.addDomListener(window, 'load', loadShowStudioMap); 

var showMap = null;
var showMarker = null; 

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

function getStudioId() {
    return $("#get_studio_id").text(); 
}

function studioGetAddressUrl() {
    return "/studios/" + getStudioId() + "/get_address";   
}

function studioSetCoordsUrl() {
    return "/studios/" + getStudioId() + "/set_coordinates"; 
}

function loadShowStudioMap() {
    loadShowMap('show-studio-map-canvas', studioSetCoordsUrl, studioGetAddressUrl); 
}

function codeAndSetAddress(address, divName, setCoordsUrlFn) {
    
    console.log('***setting address'); 
    geocoder = new google.maps.Geocoder(); 
    geocoder.geocode( {'address': address}, function(results, status) {
        console.log('HERE'); 
        if (status == google.maps.GeocoderStatus.OK) {
            console.log('GOOD GEOCODE'); 
            var pos = results[0].geometry.location;
            var setCoordsUrl = setCoordsUrlFn() + "?set=1&lat=" + pos.lat() + "&lng=" + pos.lng();
            console.log(setCoordsUrl);
            jQuery.get(setCoordsUrl, function(setdata) {
                console.log('DONE');
                makeMapAndMarker(pos, divName); 

            }); 
        }
        else {
            console.log('BAD GEOCODE');
            var setCoordsUrl = setCoordsUrlFn() + "?set=0";
            console.log(setCoordsUrl);
            jQuery.get(setCoordsUrl, function(setdata) {
                $("#" + divName).text("No location set"); 
                
            });
        }
    }); 
}


function setCoordinates(divName, setCoordsUrlFn, getAddressUrlFn) {
    var url = getAddressUrlFn(); 
    jQuery.get(url, function(data) {
        if (data["address"]) {
            codeAndSetAddress(data["address"], divName, setCoordsUrlFn); 
        }
        else if (data["lat"] && data["lng"]) {
            console.log('setting map'); 
            makeMapAndMarker(new google.maps.LatLng(data["lat"], data["lng"]), divName)
        }
        else if (data["error"]) {
            $("#" + divName).text("No location set"); 
        }

    }); 
}

function loadShowMap(divName, setCoordsUrlFn, getAddressUrlFn) {
    if (divExists(divName)) {
        setCoordinates(divName, setCoordsUrlFn, getAddressUrlFn);
        console.log('SET COORDINATES'); 
    }    
}

function makeMapAndMarker(pos, divName) {
    showMap = makeGenericMap(divName); 
    showMap.setCenter(pos); 
    showMarker = makeMarker(showMap, false); 
    makeStreetView(pos); 
}

function makeStreetView(pos) {
    console.log('street view');
    //size is in pixels
    var width = "600";
    var height = "300"; 
    var url = "http://maps.googleapis.com/maps/api/streetview?size=" +
        width + "x" + height + "&sensor=false&location=" + pos.lat() + "," + pos.lng();
    var img = $('<img/>', { src: url })
    $("#show-studio-streetview-canvas").append(img); 
}
