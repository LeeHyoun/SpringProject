<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">

<title>?????</title>

<script>
	var login_flag = 0;
	var getlist_flag = 0;
	//로그인 버튼을 눌렀을떄
	$(function() {
		$("#loginbox").hide();
		$("#showgetlist").hide();
		$("#accordion").accordion({
			collapsible : true
		});
	});

	function login() {
		if (loginflag == 0) {
			$("#loginbox").show();
			loginflag = 1;
		} else if (loginflag == 1) {
			$("#loginbox").hide();
			loginflag = 0;
		}
	}

	function bookshow(no) {
		
		
		$.ajax({
			// type을 설정합니다.
			type : 'GET',
			url : "test",
			// 사용자가 입력하여 id로 넘어온 값을 서버로 보냅니다.
			data : {
				"no" : no
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(data) {
				// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
			}
		});
	}
</script>



</head>

<body>

	<div id="loginbox" class="panel panel-primary">
		<div class="panel-heading">
			<h3>로그인</h3>
		</div>
		<!-- ###################################################################################   로그인  -->
		<!-- 로그인 안했을때 로그인박스시작 -->
		<div class="panel-body">

			<c:if test="${empty sessionScope.usr }">
				<div id="loginbox">
					<form id="loginform" class="form-horizontal" name="loginform"
						method="POST" action="usrlogin">
						<div class="form-group">
							<label for="inputId" class="col-sm-3 control-label">ID</label>
							<div class="col-sm-5">
								<input type="text" id="inputid" class="form-control"
									name="usrId" placeholder="ID">
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="col-sm-3 control-label">Password</label>
							<div class="col-sm-5">
								<input type="password" id="inputPassword" class="form-control"
									name="usrPw" placeholder="Password">
							</div>
							<div id="loginbtn" class="form-group" style="float: left;">
								<div class="col-sm-offset-2 col-sm-9">
									<input type="button" class="btn btn-default" onclick="login();"
										value="Log in">
								</div>
							</div>
						</div>
					</form>
				</div>
			</c:if>
		</div>
	</div>

	<!-- ###################################################################################   리스트 보기  -->
	<div id="listbox" class="panel panel-success">
		<div class="panel-heading">
			<h3>
				리스트보기
				<div id="loginbtn" class="form-group"
					style="float: right; padding-right: 3%;">
					<div class="col-sm-offset-2 col-sm-9">
						<input type="button" class="btn btn-default" onclick="login();"
							value="Log in" style="color: red; font-size: 12pt">
					</div>
				</div>
			</h3>
		</div>
		<div class="panel-body">
			<!-- 레코드 출력 -->
			<c:if test="${bookPageDTO.pageCount == 0 }">
				<tr>
					<td colspan="6" align="center" style="color: red;"><b>레코드가
							없습니다.</b></td>
				</tr>
			</c:if>

			<c:if test="${bookPageDTO.pageCount != 0 }">
				<c:forEach items="${list }" var="Book" varStatus="status">
					<div id="accordion" onclick="bookshow('${Book.bookNo}')">
						<h3>
							번호:${Book.bookNo}/청구번호:${Book.bookCallnumber}:제목:${Book.bookTitle}</h3>
						<div class="getdata"></div>
					</div>
				</c:forEach>
			</c:if>
		</div>
	</div>

</body>
</html>
