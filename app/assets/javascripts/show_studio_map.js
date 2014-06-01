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
    loadShowMap('show-studio-map-canvas', constructStudioShowUrl); 
}

function codeAndSetAddress(address) {
    console.log('***setting address'); 
    geocoder = new google.maps.Geocoder(); 
    geocoder.geocode( {'address': address}, function(results, status) {
        console.log('HERE'); 
        if (status == google.maps.GeocoderStatus.OK) {
            console.log('GOOD GEOCODE'); 
            var pos = results[0].geometry.location;
            var setCoordsUrl = studioSetCoordsUrl() + "?set=true&lat=" + pos.lat() + "&lng=" + pos.lng();
            console.log(setCoordsUrl);
            jQuery.get(setCoordsUrl, function(setdata) {
                console.log('DONE');
                showMap = makeGenericMap('show-studio-map-canvas'); 

                showMap.setCenter(pos); 
                showMarker = makeMarker(showMap, false); 
            }); 
        }
        else {
            console.log('BAD GEOCODE');
            var setCoordsUrl = studioSetCoordsUrl() + "?set=false";
            console.log(setCoordsUrl);
            jQuery.get(setCoordsUrl, function(setdata) {
                $("#show-studio-map-canvas").text("No location set"); 
                
            });
        }
    }); 
}


function setCoordinates() {
    var url = studioGetAddressUrl(); 
    jQuery.get(url, function(data) {
        if (data["address"]) {
            codeAndSetAddress(data["address"]); 
        }
        else if (data["lat"] && data["lng"]) {
            console.log('setting map'); 
            showMap = makeGenericMap('show-studio-map-canvas');
            showMap.setCenter(new google.maps.LatLng(data["lat"], data["lng"]));
            showMarker = makeMarker(showMap, false); 
        }
        else if (data["error"]) {
            $("#show-studio-map-canvas").text("No location set"); 
        }

    }); 
}

function loadShowMap(divName, getUrlFn) {
    if (divExists(divName)) {
        setCoordinates();
        console.log('SET COORDINATES'); 
        // var url = getUrlFn(); 
        // jQuery.get(url, function(data) {
        //     console.log('getting loc'); 
        //     if (!data["error"]) {
        //         showMap = makeGenericMap(divName); 

        //         showMap.setCenter(new google.maps.LatLng(data["lat"], data["lng"])); 
        //         showMarker = makeMarker(showMap, false); 
        //     }
        //     else {
        //         $("#" + divName).text("No location set.");
        //     }
        // }); 
    }    
}
