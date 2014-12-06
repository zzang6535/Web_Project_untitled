var map;
var markersArray = [];

function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(37.555775, 126.972472),
			zoom : 13,
		};
		map = new google.maps.Map(document.getElementById("map"),
				mapOptions);		
		
		var inputStart = document.getElementById('start_search');
		var inputDest = document.getElementById('dest_search');
		var searchBar = document.getElementById('search_bar');
		var options = {
			componentRestrictions : {
				country : 'kr'
			}
		}
		
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBar);
		
		var autocompleteStart = new google.maps.places.Autocomplete(inputStart, options);
		var autocompleteDest = new google.maps.places.Autocomplete(inputDest, options);
		autocompleteStart.bindTo('bounds', map);
		autocompleteDest.bindTo('bounds', map);
		
		var infowindow = new google.maps.InfoWindow();
		
		google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
			markersArray=[];
			var place = autocompleteStart.getPlace();
			var str = "p1="+place.name;
			sendRequest("show_DBconnector.jsp", str, function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					var Location = (xhr.responseText).split(',');
					for(var i=0; i < Location.length/2; i++){
						var latLng = new google.maps.LatLng
							(Location[(i*2)], Location[(i*2)+1]);
						addMarker(latLng);
						alert(Location[(i*2)]);
						alert(Location[(i*2)+1]);
					}
					showOverlays();
				}
			}, "post", true);
		});	
}

function addMarker(location) {
	  var marker = new google.maps.Marker({
	    position: location,
	    map: map
	  });
	  markersArray.push(marker);
}

function showOverlays() {
	if (markersArray) {
		for (i in markersArray) {
	      markersArray[i].setMap(map);
	    }
	}
}
google.maps.event.addDomListener(window, 'load', initialize);