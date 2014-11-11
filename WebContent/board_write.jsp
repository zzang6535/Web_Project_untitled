<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String pageMode = request.getParameter("pageMode");
	String boardName = "";
%>
<%@ include file="_header.jsp" %>
<div class="bodyWrapper">
	<div class="boardWrapper">
		<!-- 스마트에디터 CSS, 자바스크립트 관련 자료 설정 -->
		<link href="/Co-Traveler/se2/css/smart_editor2.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/Co-Traveler/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
		<form method="post" enctype="multipart/form-data" action="/Co-Traveler/action/board.jsp?mode=write" name="f">
			<table border="1" cellspacing="0" style="width:100%">
				<tr>
					<td>제목</td>
					<td style="text-align:left !important"><input type="text" name="title" size=60/></td>
				</tr>
				<tr>
					<td>내용</td>
					<td>
						<textarea name="content" id="content" style="width:100%;height:300px; display:none;"></textarea>
					</td>
				</tr>
				<tr>
					<td>파일첨부</td>
					<td><input type="file" name="file"/></td>
				</tr>
			</table>
			<input type="button" onclick="_onSubmit(this)" value="저장"></input>
			<input type="hidden" name="pageMode" value="<%=pageMode%>"></input>
		</form>
		<script type="text/javascript" charset="utf-8">
			// 이미지업로드 경로(붙여넣기할때 경로명이 바뀔수도 있으니 조심해야 한다. /로시작하는것은 절대경로를 의미)
			var imagepath = "/Co-Traveler/upload";
			var oEditors = [];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "content",
				sSkinURI: "/Co-Traveler/se2/SmartEditor2Skin.html",
				fCreator: "createSEditorInIFrame"
			});
			function pasteHTML(filepath){
			    var sHTML = '<img src="<%=request.getContextPath()%>/upload/'+filepath+'">';
			    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
			}
			function _onSubmit(elClicked)
			{ 
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
				f.submit();
			}
		</script>
	</div>
</div>	
<%@include file="_footer.jsp" %>