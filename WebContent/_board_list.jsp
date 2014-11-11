<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%@include file="_header.jsp" %>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<h2><%=pageName%></h2>
		<%
			if(session.getAttribute("id") != null)
			{
		%>
		<div class="menu"><a href="/Co-Traveler/board_write.jsp?pageMode=<%=pageMode%>">글쓰기</a></div>
		<%
			}
		%>
		<div class="borad">
			<table>
				<thead>
					<tr>
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="author">작성자</th>
						<th class="wtime">작성일</th>
						<th class="cnt">조회수</th>
					</tr>
				</thead>
				<tbody>
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
									"SELECT count(*) AS total FROM board " +
									"WHERE name=? ORDER BY b_id DESC"
									);
							stmt.setString(1,  pageMode);
							rs = stmt.executeQuery();
							int cnt=0;
						    while(rs.next())
						    {                
						    	cnt = rs.getInt("total");
						    }
							
							stmt = conn.prepareStatement(
									"SELECT * FROM board " +
									"WHERE name=? ORDER BY b_id DESC"
									);
							stmt.setString(1,  pageMode);
							rs = stmt.executeQuery();							

						    while(rs.next())
						    {                  
					%>
					<tr>
						<td><%=cnt%></td>
						<td><a href='/Co-Traveler/board_view.jsp?b_id=<%=rs.getInt("b_id")%>&pageMode=<%=pageMode%>'><%=rs.getString("title")%></a></td>
						<td><%=rs.getString("u_id")%></td>
						<td><%=rs.getString("wtime")%></td>
						<td><%=rs.getInt("cnt")%></td>
					</tr>					
					<%
							cnt--;
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
				</tbody>
				<tfoot>
				</tfoot>
			</table>
		</div>
	</div>
</div>	
<%@include file="_footer.jsp" %>