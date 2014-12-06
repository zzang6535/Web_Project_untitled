var map;

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
			var place = autocompleteStart.getPlace();
			var str = "p1="+place.name;
			sendRequest("show_DBconnector.jsp", str, function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					alert(xhr.responseText);
				}
			}, "post", true);
		});	
}
google.maps.event.addDomListener(window, 'load', initialize);