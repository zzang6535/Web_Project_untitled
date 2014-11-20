<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map { width: 100; height: 100% }
  </style>
	<script type="text/javascript" 
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
  </script>
  <script type="text/javascript" src="./map/googlemaps.js"></script>
	<title>Google Map!?</title>
</head>
<body onload="initialize()">
	<div id="search_bar">
		<input type="text" name="search">
		<input type="submit" value="search!">
	</div>
	<div id="map">
	</div>
</body>
</html>