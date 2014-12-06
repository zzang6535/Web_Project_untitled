<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	if(session.getAttribute("id") == null)
	{
%>
<script>
	alert('회원만 여행을 등록할 수 있습니다.');
	history.back();
</script>
<%
	return;
	}
	
	String pageMode = "trip";

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	int result = 0;
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	
%>
<%@include file="_header.jsp" %>
<script>
	function checkForm()
	{
		if(confirm("정말 탈퇴하시겠습니까?"))
		{
			document.withdrawal.submit();			
		}
	}
</script>
<link rel="stylesheet" href="map/googlemap.css" type="text/css">
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?
	key=AIzaSyBEJKMd2ye82eIix9TBpMo9ZzOWcfNgFoo&sensor=TRUE">
</script>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=places"></script>
<script type="text/javascript" src="./map/googlemaps.js"></script>
<script type="text/javascript" src="./map/httpRequest.js"></script>
<script src="./map/jquery-2.1.1.min.js"></script>
	<div id="wrap">
		<div id="map"></div>
		<div id="enroll">
			<% if(request.getMethod() == "POST"){
					request.setCharacterEncoding("UTF-8");
	
					String title = request.getParameter("trip_title");
					String start = request.getParameter("trip_start");
					String dest = request.getParameter("trip_dest");
					String numTrip = request.getParameter("num_member");
					String content = request.getParameter("content");
					String userId = (String)session.getAttribute("id");
					String userName = (String)session.getAttribute("name");
					String startX = String.valueOf(request.getParameter("sp1"));
					
					out.println(startX);
					stmt = conn.prepareStatement("INSERT INTO trip(u_id, title, start, dest, tripnum, content, spos_x) VALUES(?, ?, ?, ?, ?, ?)");
					stmt.setString(1, userId);
					stmt.setString(2, title);
					stmt.setString(3, start);
					stmt.setString(4, dest);
					stmt.setString(5, numTrip);
					stmt.setString(6, content);
					stmt.setString(7, startX);
					
					result = stmt.executeUpdate();
					if(result != 1){
						out.println("실패");
					}
				} else { 
					String userId = (String)session.getAttribute("id");
					String userName = (String)session.getAttribute("name");
					String userLink = userId;
					if(session.getAttribute("join_type") != null)
					{
						if(session.getAttribute("join_type").equals("facebook"))
						{
							userLink = "<a href = 'https://www.facebook.com/app_scoped_user_id/"+userId+"'>"+userName+"</a>";
						}
					}
					%>
			<form class="form-trip" method="post">
				<table>
					<tr>
						<th>주최</th>
						<td><%=userLink%></td>
					</tr>
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
						<th><textarea rows="10" cols="15" name="content"></textarea></th>
					</tr>
				</table>
				<input type="submit" value="여행 등록">
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
<%@include file="_footer.jsp" %>