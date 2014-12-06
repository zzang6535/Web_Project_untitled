<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<title>googlemap?!</title>
	<meta charset="utf-8">
	<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
</script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
	<link type="text/css" rel="stylesheet" href="./map/googlemap_show.css">
	<script src="./map/jquery-2.1.1.min.js"></script>
	<script type="text/javascript" src="./map/googlemap_show.js"></script>
</head>
<body>
	<div id="search_bar" class="controls">
    <input id="start_search" type="text"
        placeholder="출발지">
    <input id="dest_search" type="text"
    		placeholder="도착지">
	</div>
    <div id="map"></div>
    
</body>
</html>