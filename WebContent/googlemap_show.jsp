<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	//DB connection ready
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	/*
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	*/
	
	String dbUrl = "jdbc:mysql://localhost:3306/test";
	String dbUser = "root";
	String dbPassword = "as613200";
	
	String address="";
	double geoX=0.0;
	double geoY=0.0;
	
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		
%>
<!DOCTYPE html>
<html>
<head>
	<title>googlemap?!</title>
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
	<meta charset="utf-8">
	<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
	</script>
	<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
	<link type="text/css" rel="stylesheet" href="./map/googlemap_show.css">
	<script type="text/javascript">
	function initialize() {
		var mapOptions = {
			center : new google.maps.LatLng(37.555775, 126.972472),
			zoom : 13
		};
		var map = new google.maps.Map(document.getElementById('map'),
				mapOptions);		

		var inputStart =document.getElementById('start_search');
		var inputDest = document.getElementById('dest_search');
		var searchBar = document.getElementById('search_bar');
		
		map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchBar);
	
		var autocompleteStart = new google.maps.places.Autocomplete(inputStart);
		var autocompleteDest = new google.maps.palces.Autocomplete(inputDest);
		autocompleteStart.bindTo('bounds', map);
		autocompleteDest.bindTo('bounds', map);
		
		
		var infowindow = new google.maps.InfoWindow();
		
		google.maps.event.addListener(autocompleteStart, 'place_changed', function() {
			var markers[];
			var place = autocompleteStart.getPlace();
			<%
				stmt = conn.prepareStatement("SELECT * FROM trip WHERE address like ?");
				String st = "%" +"%";
				stmt.setString(1, st);
				
				rs = stmt.executeQuery();
				
				while(rs.next()){
					address = rs.getString("address");
					geoX = rs.getDouble("geox");
					geoY = rs.getDouble("geoy");
			%>
					markers.push(new google.maps.Marker({
					map : map,
					position : new google.maps.LatLng(<%=geoX%>,<%=geoY%>)		
				}));
			<%}%>
		});
		
	}
	google.maps.event.addDomListener(window, 'load', initialize);
	</script>
</head>
<body>
	<div id="search_bar" class="controls">
    <input id="start_search" type="text"
        placeholder="출발지">
    <input id="dest_search" type="text"
    		placeholder="도착지">
	</div>
    <div id="map"></div>
  <% 
			} catch(SQLException e){
					out.println("SQL error");
			} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
	} %>
</body>
</html>