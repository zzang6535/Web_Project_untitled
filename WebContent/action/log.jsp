<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "logPage";
%>    
<%@ page import = "java.sql.*" %>   
<%@ page import = "java.util.*" %> 
<%
	if(request.getMethod() == "POST")
	{
		String logMode = request.getParameter("logMode");
		if(logMode.equals("login"))
		{
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			String dbUrl = "jdbc:mysql://localhost:3306/project";
			String dbUser = "root";
			String dbPassword = "autoset";
			Class.forName("com.mysql.jdbc.Driver");			
			request.setCharacterEncoding("utf-8");
			try 
			{
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
				stmt = conn.prepareStatement(
						"SELECT * FROM users " +
						"WHERE id=? AND pw=? "
						);
				stmt.setString(1,  id);
				stmt.setString(2,  pw);
				
				rs = stmt.executeQuery();
			    
				while(rs.next())
			    {                  
			        session.setAttribute("id",rs.getString("id"));
			        session.setAttribute("name",rs.getString("name"));
			        session.setAttribute("gender",rs.getString("gender"));
			        session.setAttribute("email",rs.getString("email"));
			        session.setAttribute("tel",rs.getString("tel"));
			    }				
			}
			catch (SQLException e)
			{
			} 
			finally
			{
				if (rs != null) try{rs.close();} catch(SQLException e) {}
				if (stmt != null) try{stmt.close();} catch(SQLException e) {}
				if (conn != null) try{conn.close();} catch(SQLException e) {}
			}
		}
		else
		{
			session.invalidate();
		}
	}
	response.sendRedirect("/Co-Traveler/index.jsp");
%>