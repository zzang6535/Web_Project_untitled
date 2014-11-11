<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = request.getParameter("pageMode");
	String boardName = "";

%>
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%@ include file="_header.jsp" %>
<script>
	function rm(b_id)
	{
		if(confirm("정말 삭제하시겠습니까?"))
		{
			location.href = "/Co-Traveler/action/board.jsp?mode=delete&b_id="+b_id;	
		}
	}
</script>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<div class="boradContent">
			<%
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
							"SELECT * FROM board " +
							"WHERE b_id=?"
							);
					stmt.setString(1,  request.getParameter("b_id"));
					rs = stmt.executeQuery();							
	
				    while(rs.next())
				    {
				    	if(rs.getString("name").equals("notice"))
				    	{
				    		boardName = "공지사항";
				    	}
				    	else if(rs.getString("name").equals("event"))
				    	{
				    		boardName = "이벤트";
				    	}
				    	else
				    	{
				    		boardName = rs.getString("name");
				    	}
			%>
				<div class="boardTitle"><h2>[<%=boardName%>]&nbsp;&nbsp;&nbsp;<%=rs.getString("title")%></h2></div>
				<div class="boardAuthor">
					작성자 : <%=rs.getString("u_id")%>
					<%
						if(session.getAttribute("id") != null)
						{
							if(session.getAttribute("id").equals(rs.getString("u_id")))
					%>
						<input type="button" value="삭제" onClick="rm('<%=rs.getString("b_id")%>')"/>
					<%
						}
					%>
				</div>
				<div><%=rs.getString("content")%></div>				
			<%
						stmt = conn.prepareStatement(
								"UPDATE board SET cnt = cnt+1 " +
								"WHERE b_id=?"
								);
						stmt.setString(1,  request.getParameter("b_id"));
						stmt.executeUpdate();							
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
			%>
		</div>
	</div>
</div>	
<%@include file="_footer.jsp" %>