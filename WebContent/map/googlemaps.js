var geocoder;
var map;

function initialize() {
	geocoder = new google.maps.Geocoder();
	var myLating = new google.maps.LatLng(37.555775, 126.972472);
	var mapOptions = {
		center : myLating,
		zoom : 12
	};
	map = new google.maps.Map(document.getElementById("map"), mapOptions);
}

function startAddress() {
	var address = document.getElementById('tstart').value;
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location
			});
		} else {
			alert('Geocode was not successful for the following reason: '
					+ status);
		}
	});
}

function destAddress() {
	var address = document.getElementById('tdest').value;
	geocoder.geocode({
		'address' : address
	}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({
				map : map,
				position : results[0].geometry.location
			});
		} else {
			alert('Geocode was not successful for the following reason: '
					+ status);
		}
	});
}