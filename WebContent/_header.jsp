<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mode = pageMode;
	if(mode == "")
	{
		mode = "index";
	}
%>
<!DOCTYPE html> 
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Co-Traveler</title>
		<link rel="stylesheet" href="/Co-Traveler/common/css/common.css">
		<link rel="stylesheet" href="/Co-Traveler/bootstrap/css/bootstrap.min.css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="/Co-Traveler/bootstrap/js/bootstrap.min.js"></script>	
	</head>
	<body>
	<!-- 민기형   -->
		<div id="header">
			<div class="navbar navbar-inverse navbar-fixed-top">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="/Co-Traveler/index.jsp">Co-Traveler</a>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav">
							<li<%if(mode.equals("notice")){%> class="active"<%}%>><a href="/Co-Traveler/notice.jsp">공지사항</a></li>
							<li<%if(mode.equals("event")){%> class="active"<%}%>><a href="/Co-Traveler/event.jsp">이벤트</a></li>
							<li<%if(mode.equals("rank")){%> class="active"<%}%>><a href="/Co-Traveler/rank.jsp">관광지 랭킹</a></li>
							<li<%if(mode.equals("mypage")){%> class="active"<%}%>><a href="/Co-Traveler/mypage.jsp">나의 여행 일지</a></li>
						</ul>
						<form class="navbar-form navbar-right" action="/Co-Traveler/action/log.jsp" method="POST">
						<%
							if(session.getAttribute("id") == null)
							{
						%>
							<div class="form-group">
								<input name='id' type="text" placeholder="ID" class="form-control">
							</div>
							<div class="form-group">
								<input name='pw' type="password" placeholder="Password" class="form-control">
							</div>
							<button type="submit" class="btn btn-success">Sign in</button>
							<a href="register.jsp"><button type="button" class="btn btn-success">Sign up</button></a>
							<input type="hidden" name="logMode" value="login" />
						<%
							}
							else
							{
						%>
							<button type="submit" class="btn btn-success">Logout</button>
							<input type="hidden" name="logMode" value="logout" />
						<%
							}
						%>
						</form>
					</div>
				</div>
			</div>
		</div>
