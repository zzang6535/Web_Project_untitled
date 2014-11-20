var markersArray = [];
var map;
var goldStar = {
		  path: 'M 125,5 155,90 245,90 175,145 200,230 125,180 50,230 75,145 5,90 95,90 z',
		  fillColor: "yellow",
		  fillOpacity: 0.8,
		  scale: 1,
		  strokeColor: "gold",
		  strokeWeight: 14
		};

function initialize() {
		var myLating = new google.maps.LatLng(-25.363882,131.044922);
        var mapOptions = {
          center: myLating,
          zoom: 2,
          mapTypeId: google.maps.MapTypeId.TERRAIN
        };
        map = new google.maps.Map(document.getElementById("map"),
            mapOptions);
        
        google.maps.event.addListener(map, 'click', function(event){
        	addMarker(event.latLng);
        });
}

google.maps.event.addDomListener(window, 'load', initialize);

function addMarker(location){
	marker = new google.maps.Marker({
		position: location,
		map: map
	});
	markersArray.push(marker);
	marker.setMap(map);
}
