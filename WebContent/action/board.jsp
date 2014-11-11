<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import = "java.sql.*" %>   
<%@ page import = "java.util.*" %> 
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String dbUrl = "jdbc:mysql://localhost:3306/project";
	String dbUser = "root";
	String dbPassword = "autoset";
	Class.forName("com.mysql.jdbc.Driver");      
	request.setCharacterEncoding("utf-8");
	if(request.getParameter("mode").equals("delete"))
	{
		String b_id = request.getParameter("b_id");
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		stmt = conn.prepareStatement(
				"SELECT * FROM board " +
				"WHERE b_id=? "
				);
		stmt.setString(1,  b_id);
		
		rs = stmt.executeQuery();
		String u_id = "";
		String name = "";
		while(rs.next())
	    {                  
	        name = rs.getString("name");
	        u_id = rs.getString("u_id");
	    }
		
		List<String> errorMsgs = new ArrayList<String>();
		int result = 0;
		if (!session.getAttribute("id").equals(u_id)) {
			errorMsgs.add("작성자만 삭제할 수 있습니다.");
		}
		
		if (errorMsgs.size() == 0) 
		{
			try 
			{
				stmt = conn.prepareStatement(
						"DELETE FROM board " +
						"WHERE b_id=? "
						);
				stmt.setString(1,  b_id);
				
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
		<script>
			location.href="/Co-Traveler/"+"<%=name%>"+".jsp";
		</script>
		<%
	}
	else
	{
		//업로드 폴더의 실제 경로 얻어오기
		String dir = "C:/Users/Seunggabi/github/workspace/Co-Traveler/WebContent/upload";
		System.out.println(dir);
		//MultipartRequest 객체 생성하기.(파일하고 같이 넘어오기 때문에 mr을 써줘야 한다.)
		MultipartRequest mr=new MultipartRequest(request,
		dir, 1024*1024*5, "utf-8", 
		new DefaultFileRenamePolicy());
		
		String id = (String)session.getAttribute("id");
		String pageMode = mr.getParameter("pageMode");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		
		//원본 파일명 얻어오기
		String orgFileName=mr.getOriginalFileName("file");
		//파일 시스템에 저장된 파일명 얻어오기
		String saveFileName=mr.getFilesystemName("file");
		//전송된정보를 테스트로 출력해보기
		
		List<String> errorMsgs = new ArrayList<String>();
		int result = 0;
			
		if (title == null || title.trim().length() == 0) {
			errorMsgs.add("제목 반드시 입력해주세요.");
		}
		
		if (content == null || content.trim().length() == 0) {
			errorMsgs.add("내용을 반드시 입력해주세요.");
			errorMsgs.add(content);
		}
		
		if (id == null || id.trim().length() == 0) {
			errorMsgs.add("회원만 이용할 수 있습니다.");
		}
		
		if (errorMsgs.size() == 0) 
		{
			try 
			{
				conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
				stmt = conn.prepareStatement(
						"INSERT INTO board " +
						"(name, title, content, u_id, ofilename, sfilename, wtime) " +
						"VALUES " +
						"(?, ?, ?, ?, ?, ?, NOW())" 
						);
				stmt.setString(1,  pageMode);
				stmt.setString(2,  title);
				stmt.setString(3,  content);
				stmt.setString(4,  id);
				stmt.setString(5,  orgFileName);
				stmt.setString(6,  saveFileName);
				
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
 			<b><%= title %></b> 작성완료
 		</div>
	 	<div class="form-action">
	 		<a href="/Co-Traveler/index.jsp" class="btn">메인으로</a>
	 	</div>
 	<%}%>	
</div>
<%@include file="../_footer.jsp" %>
<%	}%>