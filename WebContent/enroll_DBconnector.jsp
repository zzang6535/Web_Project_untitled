<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	int result = 0;
	String rspX="";
	String rspY="";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		rspX=request.getParameter("sx1");
		
		if(request.getMethod() == "POST"){
			String title = request.getParameter("trip_title");
			String start = request.getParameter("trip_start");
			String dest = request.getParameter("trip_dest");
			String numTrip = request.getParameter("num_member");
			String content = request.getParameter("content");
			String userId = (String)session.getAttribute("id");
			String userName = (String)session.getAttribute("name");
			String geoX = rspX;	
			
			stmt = conn.prepareStatement("INSERT INTO trip(u_id, title, start, dest, tripnum, content, spos_x) VALUES(?, ?, ?, ?, ?, ?, ?)");
			stmt.setString(1, userId);
			stmt.setString(2, title);
			stmt.setString(3, start);
			stmt.setString(4, dest);
			stmt.setString(5, numTrip);
			stmt.setString(6, content);
			stmt.setString(7, geoX);
			
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
		}
	} catch(SQLException e){
					out.println("SQL error");
	} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
	}
%>