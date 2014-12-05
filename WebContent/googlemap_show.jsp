<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
/*
	//DB connection ready
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	String rspPlace = request.getParameter("Pot");
	String address="";
	String geoX="";
	String geoY="";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	*/	
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
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?libraries=places&sensor=true"></script>
	<link type="text/css" rel="stylesheet" href="./map/googlemap_show.css">
	<script type="text/javascript" src="./map/googlemap_show.js"></script>
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
    /*
    	if(rspPlace != null){
    		stmt = conn.prepareStatement("SELECT start, spos_x, spos_y FROM trip WHERE start like ?");
				stmt.setString(1, rspPlace);
				
				rs = stmt.executeQuery();
				
				while(rs.next()){
					address = rs.getString("start");
					geoX = rs.getString("spos_x");
					geoY = rs.getString("spos_y");
					response.getWriter().println(address + "," + geoX + "," + geoY);
				}
    	}
		} catch(SQLException e){
					out.println("SQL error");
		} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
	}*/ 
	%>
</body>
</html>