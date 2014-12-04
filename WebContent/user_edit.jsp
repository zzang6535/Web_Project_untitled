<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = "userEdit";
%>
<%@include file="_header.jsp" %>
<script>
	function formSubmit()
	{
		var form = document.registerForm;
		if(form.id.value == '')
		{
			alert('아이디가 입력되지 않았습니다.');
			form.id.focus();
			return;
		}
		if(form.pw.value == '')
		{
			alert('패스워드가 입력되지 않았습니다.');
			form.pw.focus();
			return;
		}
		if(form.name.value == '')
		{
			alert('이름이 입력되지 않았습니다.');
			form.name.focus();
			return;
		}
		if(form.gender.value == '')
		{
			alert('성별이 입력되지 않았습니다.');
			form.gender.focus();
			return;
		}
		if(form.email.value == '')
		{
			alert('Email이 입력되지 않았습니다.');
			form.email.focus();
			return;
		}
		if(form.tel.value == '')
		{
			alert('전화번호가 입력되지 않았습니다.');
			form.tel.focus();
			return;
		}
		form.submit(); 
	}
</script>
<div class="bodyWrapper">
	<div id="registerBox">
		<form name='registerForm' method="POST" action="/Co-Traveler/user">
			<h2 class="setup-form-title">정보수정</h2>
			<br />
			<dl class="form">
				<dt class="input-label">
					<label>ID</label>
				</dt>
				<dd>
					<%=session.getAttribute("id") %>
					<input type="hidden" name="id" value="<%=session.getAttribute("id") %>"/>
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>New Password</label>
				</dt>
				<dd>
					<input name="pw" size="30" type="password">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Name</label>
				</dt>
				<dd>
					<input name="name" size="30" type="text" value="<%=session.getAttribute("name") %>">
					<p class="note"></p>
				</dd>
			</dl>			
			<dl class="form">
				<dt class="input-label">
					<label>Gender</label>
				</dt>
				<dd>
					남
					<input name="gender" value="M" type="radio" <% if(session.getAttribute("gender").equals("M")) out.println("checked=true");%>>
					여
					<input name="gender" value="F" type="radio" <% if(session.getAttribute("gender").equals("F")) out.println("checked=true");%>>
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Email</label>
				</dt>
				<dd>
					<input name="email" size="30" type="text" value="<%=session.getAttribute("email") %>">
					<p class="note"></p>
				</dd>
			</dl>
			<dl class="form">
				<dt class="input-label">
					<label>Tel</label>
				</dt>
				<dd>
					<input name="tel" size="30" type="text" value="<%=session.getAttribute("tel") %>">
					<p class="note"></p>
				</dd>
			</dl>				
			<dl class="form">
				<dt class="input-label">
					<label>선호 출발지</label>
				</dt>
				<dd>
					<input name="start" size="30" type="text" value="<%=session.getAttribute("start") %>">
					<p class="note"></p>
				</dd>
			</dl>	
			<div class="btn">
				<button type="button" OnClick="formSubmit()">수정</button>
			</div>
			<input type="hidden" name="mode" value="edit" />
		</form>
	</div> <!-- /.setup-form-container -->
</div>
<%@include file="_footer.jsp" %>