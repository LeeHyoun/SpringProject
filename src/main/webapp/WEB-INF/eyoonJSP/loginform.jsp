<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">

<title>로그인</title>

<script type="text/javascript">
//로그인 처리
	function login() {
		//document.loginform.submit();
	
		var formData = $("#loginform").serialize(); // form의 데이터를 가져온다.
		//alert(formData);
		
		$.ajax({
			type : "POST",
			url : "usrlogin",
			data : formData,
			success : function(data) {
				alert('로그인되었습니다.')
			}
		});
	}
	
	
	function logout(usrId) {
		//alert(usrId);
		$.ajax({
			type : "POST",
			url : "logout",
			data : {
				"usrId" : usrId
			},
			success : function(data) {
				alert('로그아웃 되었습니다.');
			}
		});
	}
</script>

</head>
<body>
	<!-- ###################################################################################   로그인  -->
	<div id="loginbox" class="panel panel-primary">
		<div class="panel-heading">
			<h3>로그인</h3>
		</div>
		<div class="panel-body">
			<div id="loginbox">
				<form id="loginform" class="form-horizontal" name="loginform"
					method="POST">
					<div class="form-group">
						<label for="inputId" class="col-sm-3 control-label">ID</label>
						<div class="col-sm-5">
							<input type="text" id="inputid" class="form-control" name="usrId"
								placeholder="ID" />
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
							<div id="loginbtn" class="form-group"
								style="float: right; padding-right: 5%;">
								<div class="col-sm-offset-2 col-sm-9">
									<c:if test="${empty sessionScope.usr}">
										<input type="button" class="btn btn-default"
											onclick="loginshow()" value="Login"
											style="color: red; font-size: 12pt;" />
									</c:if>

									<c:if test="${not empty sessionScope.usr}">
										<div style="width: 300px;">
											<input type="button" id="logout" class="btn btn-default"
												onclick="logout('${usr.usrId}')" value="Logout"
												style="float: right; color: red; font-size: 12pt;" /> 
										</div>
									</c:if>
								</div>
							</div>
						</div>
					</div>
					<p align="center" style="color: red">
						<strog>* 해당 페이지는 로그인을 해야 합니다.</strog>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>