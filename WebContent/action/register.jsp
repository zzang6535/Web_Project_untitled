<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "registerAction";
%>
<%@ page import = "java.sql.*" %>   
<%@ page import="java.util.*" %> 
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/project";
	String dbUser = "root";
	String dbPassword = "autoset";
	Class.forName("com.mysql.jdbc.Driver");      
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String email = request.getParameter("email");
	String tel = request.getParameter("tel");
	
	List<String> errorMsgs = new ArrayList<String>();
	int result = 0;
	
	//중복된 아이디 검사
	conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	stmt = conn.prepareStatement(
			"SELECT id FROM users " +
			"WHERE id=?"
			);
	stmt.setString(1,  id);
	rs = stmt.executeQuery();
	if(rs.next())
	{
		errorMsgs.add("이미 "+ id + " 사용자가 있습니다.");
	}
	
	if (id == null || id.trim().length() == 0) {
		errorMsgs.add("ID를 반드시 입력해주세요.");
	}
	
	if (name == null || name.trim().length() == 0) {
		errorMsgs.add("이름을 반드시 입력해주세요.");
	}
	
	if (gender == null || !(gender.equals("M") || gender.equals("F") )) {
		errorMsgs.add("성별에 적합하지 않은 값이 입력되었습니다.");
	}

	if (errorMsgs.size() == 0) 
	{
		try 
		{
			conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			stmt = conn.prepareStatement(
					"INSERT INTO users " +
					"(id, pw, name, gender, email, tel) " +
					"VALUES " +
					"(?, ?, ?, ?, ?, ?)" 
					);
			stmt.setString(1,  id);
			stmt.setString(2,  pw);
			stmt.setString(3,  name);
			stmt.setString(4,  gender);
			stmt.setString(5,  email);
			stmt.setString(6,  tel);
			
			result = stmt.executeUpdate();
			if (result != 1) 
			{
				errorMsgs.add("변경에 실패하였습니다.");
			}
		}
		catch (SQLException e)
		{
			errorMsgs.add(dbUrl);
			errorMsgs.add("SQL 에러: " + e.getMessage());
		} 
		finally
		{
			if (rs != null) try{rs.close();} catch(SQLException e) {}
			if (stmt != null) try{stmt.close();} catch(SQLException e) {}
			if (conn != null) try{conn.close();} catch(SQLException e) {}
		}
	}
%>
<%@include file="../_header.jsp" %>
<div class="bodyWrapper">
	<% if (errorMsgs.size() > 0) { %>
		<div class="alert alert-error">
			<h3>Errors:</h3>
			<ul>
				<% for(String msg: errorMsgs) { %>
					<li><%=msg %></li>
				<% } %>
			</ul>
		</div>
 	<div class="form-action">
 		<a onclick="history.back();" class="btn">뒤로 돌아가기</a>
	</div>
 	<% } else if (result == 1) { %>
 		<div class="alert alert-success">
 			<b><%= name %></b> 가입완료
 		</div>
	 	<div class="form-action">
	 		<a href="/Co-Traveler/index.jsp" class="btn">메인으로</a>
	 	</div>
 	<%}%>	
</div>
<%@include file="../_footer.jsp" %>