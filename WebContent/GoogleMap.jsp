<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	//DB connection ready
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/test";
	String dbUser = "googlemap";
	String dbPassword = "asdf";
	
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="map/googlemap.css" type="text/css">
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
</script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script type="text/javascript" src="./map/googlemaps.js"></script>
<script src="./map/jquery-2.1.1.min.js"></script>
<title>Google Map!?</title>
</head>
<body>
	<div id=wrap>
		<div id="map"></div>
		<div id="enroll">
			<% if(request.getMethod() == "POST"){
					request.setCharacterEncoding("UTF-8");
	
					String title = request.getParameter("trip_title");
					String start = request.getParameter("trip_start");
					String dest = request.getParameter("trip_dest");
					String numTrip = request.getParameter("num_member");
					String content = request.getParameter("content");
					
					stmt = conn.prepareStatement("INSERT INTO trip(title, start, dest, tripnum, content) VALUES(?, ?, ?, ?, ?)");
					stmt.setString(1, title);
					stmt.setString(2, start);
					stmt.setString(3, dest);
					stmt.setString(4, numTrip);
					stmt.setString(5, content);

					result = stmt.executeUpdate();
					if(result != 1){
						out.println("실패");
					}
				} else { %>
			<form class="form-trip" method="post">
				<table>
					<tr>
						<th>Trip</th>
						<td><input type="text" name="trip_title"></td>
					</tr>
					<tr>
						<th>출발지</th>
						<td><input type="text" name="trip_start" id="tstart"></td>
					</tr>
					<tr>
						<th>도착지</th>
						<td><input type="text" name="trip_dest" id="tdest"></td>
					</tr>
					<tr>
						<th>모집인원</th>
						<td><select name="num_member">
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
						</select></td>
					</tr>
					<tr>
						<td>내용</td>
						<th><textarea rows="20" cols="20" name="content"></textarea></th>
					</tr>
				</table>
				<input type="submit" value="Geocode">
			</form>
			<% }
			} catch(SQLException e){
					out.println("SQL error");
			} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
			} %>
		</div>
	</div>
</body>
</html>