var map;

function initialize() {
	geocoder = new google.maps.Geocoder();
	var myLating = new google.maps.LatLng(37.555775, 126.972472);
	var mapOptions = {
		center : myLating,
		zoom : 12
	};
	map = new google.maps.Map(document.getElementById("map"), mapOptions);

	var inputStart = document.getElementById('tstart');
	var inputDest = document.getElementById('tdest');
	
	var autocompleteStart = new google.maps.places.Autocomplete(inputStart);
	var autocompleteDest = new google.maps.places.Autocomplete(inputDest);
	
	autocompleteStart.bindTo('bounds', map);
	autocompleteDest.bindTo('bounds', map);
	
	var infowindow = new google.maps.InfoWindow();
	
	var markerStart = new google.maps.Marker({
		map : map,
		anchorPoint : new google.maps.Point(0, -29)
	});
	var markerDest = new google.maps.Marker({
		map : map,
		anchorPoint : new google.maps.Point(0, -29)
	});

	google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
		infowindow.close();
		markerStart.setVisible(false);
		var place = autocompleteStart.getPlace();
		if (!place.geometry) {
			return;
		}

		// If the place has a geometry, then present it on a map.
		if (place.geometry.viewport) {
			map.fitBounds(place.geometry.viewport);
		} else {
			map.setCenter(place.geometry.location);
			map.setZoom(17);
		}

		markerStart.setPosition(place.geometry.location);
		markerStart.setVisible(true);
		
		var address = '';
		if (place.address_components) {
			address = [
					(place.address_components[2]
							&& place.address_components[2].short_name || ''),
					(place.address_components[1]
							&& place.address_components[1].short_name || ''),
					(place.address_components[0]
							&& place.address_components[0].short_name || '')
			].join(' ');
		}

		infowindow.setContent('<div><strong>' + place.name + '</strong><br>'
				+ address);
		infowindow.open(map, markerStart);
	});
	
	google.maps.event.addListener(autocompleteDest, 'place_changed', function() {
		infowindow.close();
		markerDest.setVisible(false);
		var place = autocompleteDest.getPlace();
		if (!place.geometry) {
			return;
		}

		// If the place has a geometry, then present it on a map.
		if (place.geometry.viewport) {
			map.fitBounds(place.geometry.viewport);
		} else {
			map.setCenter(place.geometry.location);
			map.setZoom(17);
		}

		markerDest.setPosition(place.geometry.location);
		markerDest.setVisible(true);
		
		var address = '';
		if (place.address_components) {
			address = [
					(place.address_components[2]
							&& place.address_components[2].short_name || ''),
					(place.address_components[1]
							&& place.address_components[1].short_name || ''),
					(place.address_components[0]
							&& place.address_components[0].short_name || '')
			].join(' ');
		}

		infowindow.setContent('<div><strong>' + place.name + '</strong><br>'
				+ address);
		infowindow.open(map, markerDest);
	});
}

google.maps.event.addDomListener(window, 'load', initialize);