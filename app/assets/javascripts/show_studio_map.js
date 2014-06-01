google.maps.event.addDomListener(window, 'load', loadShowStudioMap); 

var showMap = null;
var showMarker = null; 

function constructStudioShowUrl() {
    return "/studios/" + getStudioId() + "/get_coordinates"; 
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
                showMap = makeGenericMap(divName); 

                showMap.setCenter(pos); 
                showMarker = makeMarker(showMap, false); 
            }); 
        }
        else {
            console.log('BAD GEOCODE');
            var setCoordsUrl = setCoordsUrlFn() + "?set=0";
            console.log(setCoordsUrl);
            jQuery.get(setCoordsUrl, function(setdata) {
                $(divName).text("No location set"); 
                
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
            showMap = makeGenericMap(divName);
            showMap.setCenter(new google.maps.LatLng(data["lat"], data["lng"]));
            showMarker = makeMarker(showMap, false); 
        }
        else if (data["error"]) {
            $(divName).text("No location set"); 
        }

    }); 
}

function loadShowMap(divName, setCoordsUrlFn, getAddressUrlFn) {
    if (divExists(divName)) {
        setCoordinates(divName, setCoordsUrlFn, getAddressUrlFn);
        console.log('SET COORDINATES'); 
    }    
}
