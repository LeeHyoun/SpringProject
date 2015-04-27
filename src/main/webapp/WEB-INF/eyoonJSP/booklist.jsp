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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">

<style type="text/css">
pre {
	white-space: pre-wrap; /* CSS3*/
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-all; /* Internet Explorer 5.5+ */
}
</style>

<title>도서리스트</title>

<script>
	var login_flag = 0;
	var getlist_flag = 0;

	 $(document).ready(function(){ 		
		$("#loginbox").hide();
		$("#accordion").accordion({
			collapsible : true
		});
	 });
	 
	 
	// 로그인 <div> 보이기
	function loginshow(){
		if (login_flag == 0) {
			$("#loginbox").show("slow");
			login_flag = 1;
		} else {
			$("#loginbox").hide("slow");
			login_flag = 0;
		}
	}
	
	//로그인 처리
	function login() {
		//document.loginform.submit();
	
		var formData = $("#loginform").serialize(); // form의 데이터를 가져온다.
		//alert(formData);
		
		$.ajax({
			type : "POST",
		   	url : "usrlogin",
		   	data : formData,
		   	success :function(data) {
			
		   		// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
		   		$("#loginbox").hide();
		   		login_flag = 0;
		   		location.replace('/'); 
			}
		});
			 
	}
	

	function logout(usrId) {
		alert(usrId);
		$.ajax({
			type : "POST",
		   	url : "logout",
		   	data : {
		   		"usrId" : usrId
		   	},
		   	success :function(data) {
		   		$("#listbox").show();
				alert('로그아웃 되었습니다.');
				
				location.replace('/');
			}
		});
	}

	
	function bookshow(bookNo) {
		//alert(bookNo);
		$.ajax({
			// type을 설정합니다.
			type : 'post',
			url : "detailbook",
			data : {
				"bookNo" : bookNo
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(data) {
				// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
				alert(data.val());
			}
		});
	}

	function bookupdate(bookno) {
		alert(bookno);
	}

	function bookdelete(bookno) {
		alert(bookno);
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
						method="POST">
						<div class="form-group">
							<label for="inputId" class="col-sm-3 control-label">ID</label>
							<div class="col-sm-5">
								<input type="text" id="inputid" class="form-control"
									name="usrId" placeholder="ID" />
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword" class="col-sm-3 control-label">Password</label>
							<div class="col-sm-5">
								<input type="password" id="inputPassword" class="form-control"
									name="usrPw" placeholder="Password" />
							</div>
							<div id="loginbtn" class="form-group" style="float: left;">
								<div class="col-sm-offset-2 col-sm-9">
									<input type="button" class="btn btn-default" onclick="login();"
										value="Log in" />
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
						<c:if test="${empty sessionScope.usr}">
						<input type="button" class="btn btn-default" onclick="loginshow()"
							value="Login" style="color: red; font-size: 12pt;" />
						</c:if>
						
						<c:if test="${not empty sessionScope.usr}">
						<input type="button" id="logout" class="btn btn-default" onclick="logout('${usr.usrId}')"
							value="Logout" style="color: red; font-size: 12pt;" />
						</c:if>
					</div>
				</div>
			</h3>
		</div>
		<div class="panel-body">
			<!-- 레코드 출력 -->
			<c:if test="${bookPageDTO.pageCount == 0 }">
				<tr>
					<td colspan="6" align="center" style="color: red;"><b>레코드가없습니다.</b></td>
				</tr>
			</c:if>

			<div id="accordion">
				<c:if test="${bookPageDTO.pageCount != 0 }">
					<c:forEach items="${list }" var="Book" varStatus="status">

						<h3 onclick="bookshow('${Book.bookNo}')">
							번호:${Book.bookNo}&nbsp;&nbsp;청구번호:${Book.bookCallnumber}&nbsp;&nbsp;&nbsp;&nbsp;제목:${Book.bookTitle}
						</h3>
						<!-- details Book-->
						<div class="panel-body">
							<div id="libraryinfo" class="posts">
								<div style="float: left;">
									<div
										style="width: 140px; height: 110px; overflow: hidden; margin-left: -20px;"
										class="col-sm-4 col-md-3 bookimg">
										<div class="thumbnail">
											<img src="images/book/${Book.bookImg}" alt="없음."
												style="width: 110px; height: auto;">
										</div>
									</div>

									<div>
										<p>도서이름 : ${Book.bookTitle}</p>
										<p>저자 : ${Book.bookWriter}</p>
										<p>출판사 : ${Book.bookCompany}</p>
										<p>청구번호 : ${Book.bookCallnumber}</p>
										<p style="padding-left: 120px;">ISBN : ${Book.bookIsbn}</p>
										<p>줄거리</p>
										<p>
										<pre>${Book.bookContent}</pre>
										</p>
									</div>
								</div>
							</div>
							<div style="margin-left: 50px; float: right;">
								<input type="button" value="수정"
									onclick="bookupdate('${Book.bookNo}')"> <input
									type="button" value="삭제" onclick="bookdelete('${Book.bookNo}')">
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>
