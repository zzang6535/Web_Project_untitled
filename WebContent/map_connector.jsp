<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	//DB connection ready
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://54.68.109.68/project?characterEncoding=UTF-8";
	String dbUser = "seunggabi";
	String dbPassword = "co-traveler";
	
	String rspPlace="";
	String address="";
	String geoX="";
	String geoY="";
	
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		
		//DB Connection
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
 		rspPlace = request.getParameter("p1");
 		
    if(!rspPlace.equals("")){
    	stmt = conn.prepareStatement("SELECT start, spos_x, spos_y FROM trip WHERE start LIKE ?");
			stmt.setString(1, "%" + rspPlace + "%");
		
			rs = stmt.executeQuery();
				
				while(rs.next()){
					address = rs.getString("start");
					geoX = rs.getString("spos_x");
					geoY = rs.getString("spos_y");
					out.println(address + "," + geoX + "," + geoY);
				}
    	} else{
    		out.println("DB를 읽어오지 못했습니다");
    	}
		} catch(SQLException e){
					out.println("SQL error");
		} finally {
					if(rs != null) try{rs.close();} catch(SQLException e){}
					if(stmt != null) try{stmt.close();} catch(SQLException e){}
					if(conn != null) try{conn.close();} catch(SQLException e){}
		}
	%>
