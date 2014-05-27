google.maps.event.addDomListener(window, 'load', loadMap);
var map = null; 
var marker = null;

function constructUrl() {
    var url = window.location.pathname;
    var re = /[.]*\/events\/+([0-9]+)\/*/;
    var reArray = re.exec(url); 
    return "/events/" + reArray[1] + "/get_coordinates"; 
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
