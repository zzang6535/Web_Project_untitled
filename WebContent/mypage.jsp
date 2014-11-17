<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "mypage";
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
<div class="bodyWrapper">
	<div id="myPageBox">
		<form name="withdrawal" method="POST" action="/Co-Traveler/user">
			<div class="input-group">
				<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
				<input type="hidden" name="mode" value="withdrawal">
	     		<input type="PASSWORD" name="pw" class="form-control">
	     		<span class="input-group-btn">
					<input type="button" class="btn btn-default" value="회원탈퇴" onclick="checkForm()"/>
	     		</span>
	   		</div>
	   	</form>
	   	<br/><br/><br/>	
	   	<a href="user_edit.jsp">
	   		<input type="button" class="btn btn-default" value="정보수정"/>
	   	</a>
	</div>
</div>
<%@include file="_footer.jsp" %>