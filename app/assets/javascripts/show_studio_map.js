google.maps.event.addDomListener(window, 'load', initMap); 

var map = null;

function constructStudioShowUrl() {
    var url = window.location.pathname;
    var re = /\/+studios\/+([0-9]+)/;
    return "/studios/" + re.exec(url)[1] + "/get_coordinates"; 
}

function initMap() {
    var mapDiv = document.getElementById('show-studio-map-canvas');
    if (mapDiv != null) {
        var url = constructStudioShowUrl();
        jQuery.get(url, function(data) {
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
