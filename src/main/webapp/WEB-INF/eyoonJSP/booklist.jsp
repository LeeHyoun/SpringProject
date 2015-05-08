<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	
<!DOCTYPE html >
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
<script src="//code.jquery.com/jquery-1.10.2.js" charset="UTF-8"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->

<title>도서관리 시스템</title>
<style type="text/css">
pre {
	white-space: pre-wrap; /* CSS3*/
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-all; /* Internet Explorer 5.5+ */
}
</style>


<script>
	$(function() {
		$("#datepicker").datepicker({
			dateFormat : "yy/mm/dd"
		});
	});
</script>

<script>
	var login_flag = 0;
	var getlist_flag = 0;
	var addbook_flag = 0;
	var update_flag = 0;

	$(document).ready(function() {
		$("#loginbox").hide("slow");
		//$("#listbox").hide();
		$("#addbookbox").hide();
		$("#updatebody").hide();
		$("#accordion").accordion({
			collapsible : true,
			active : false

		});
	});

	function addbookshow() {

		if (addbook_flag == 0) {
			$("#addbookbox").show();
			addbook_flag = 1;
		} else {
			$("#addbookbox").hide();
			addbook_flag = 0;
		}
	}
	
	// 수정할 도서 상세보기
	function updateshow(bookNo) {

		if (update_flag == 0) {
			$("#updatebody").show();

			$.ajax({
				// type을 설정합니다.
				type : 'GET',
				url : "detailbook",
				dataTpe : "json",
				//dataType : "JSON",
				data : {
					"bookNo" : bookNo
				},
				// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
				success : function(data) {
					//alert(data.bookTitle);
					// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
					$('input[name=bookNo]').val(data.bookNo);
					$('input[name=bookTitle]').val(data.bookTitle);
					$('input[name=bookWriter]').val(data.bookWriter);
					$('input[name=bookCallnumber]').val(data.bookCallnumber);
					$('input[name=bookCompany]').val(data.bookCompany);
					$('input[name=bookIsbn]').val(data.bookIsbn);
					$('input[name=bookPrice]').val(data.bookPrice);
					$('textarea#bookContent').val(data.bookContent);
					$('input[name=bookState]').val(data.bookState);
					document.updatefrm.genreCode.value = data.genreCode;
					$('input[name=bookBringout]').val(data.bookBringout);
										
					if (data.bookStored == "구매") {
						//alert("구매");
						document.updatefrm.bookStored[0].checked = true;
					} else {
						//alert("기증");
						document.updatefrm.bookStored[1].checked = true;
					}

					document.updatefrm.bookImg.value = data.bookImg;
					
				}
			});

			update_flag = 1;
		} else {
			$("#updatebody").hide("slow");
			update_flag = 0;
		}
	}
	
	//도서 상세보기
	function detailbook(bookNo) {

		$.ajax({
					// type을 설정합니다.
					type : 'GET',
					url : "detailbook",
					//dataType : "JSON",
					data : {
						"bookNo" : bookNo
					},
					// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
					success : function(data) {
						// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
						var thumbnail = "";

						thumbnail += "<img src='images/book/" + data.bookImg + "'  style=' width: 110px; height: auto;'>";

						var HTML = "";

						HTML += "<label>도서이름 : " + data.bookTitle + "</label>";

						HTML += "<p>저자 : " + data.bookWriter + " </p>";
						HTML += "<p>출판사 : " + data.bookCompany + "</p>";
						HTML += "<p>청구번호 : " + data.bookCallnumber + "</p>";
						HTML += "<p style='padding-left: 120px;'>ISBN : "
								+ data.bookIsbn + "</p>";
						HTML += "<p>줄거리</p>";
						HTML += "<p>";
						HTML += "<pre>" + data.bookContent + "</pre>";
						HTML += "</p>";

						$("#thumbnail" + data.bookNo).empty();
						$("#detailsbook" + data.bookNo).empty();

						$("#thumbnail" + data.bookNo).append(thumbnail);
						$("#detailsbook" + data.bookNo).append(HTML);
					}
				});
	}

	function bookdelete(bookno) {
		alert(bookno);
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
				$("#listDiv").empty();
				$("#loginbox").show("slow");
			}
		});
	}
	
</script>

<!-- 도서 등록 -->
<script type="text/javascript">
	function addbook() {
		var bookTitle = document.addBook.bookTitle.value;
		if (document.addBook.bookTitle.value == "") {
			alert("제목을 입력해주세요.");
			document.addBook.bookTitle.focus();
			return false;
		}

		var bookWriter = document.addBook.bookWriter.value;
		if (bookWriter == "") {
			alert("저자를 입력해주세요.");
			document.addBook.bookWriter.focus();
			return;
		}
		var bookCallnumber = document.addBook.bookCallnumber.value;
		if (bookCallnumber == "") {
			alert("청구번호를 입력해주세요.");
			document.addBook.bookCallnumber.focus();
			return;
		}
		var bookImg = document.addBook.bookImg.value;
		if (bookImg == "") {
			alert("이미지를 등록 해주세요.");
			document.addBook.bookImg.focus();
			return;
		}
		var bookState = document.addBook.bookState.value;
		if (bookState == "") {
			alert("도서상태를 입력 해주세요.");
			document.addBook.bookState.focus();
			return;
		}
		var bookBringout = document.addBook.datepicker.value;
		if (bookBringout == "") {
			alert("발행년도를 선택 해주세요.");
			document.addBook.datepicker.focus();
			return;
		}
		var bookCompany = document.addBook.bookCompany.value;
		if (bookCompany == "") {
			alert("출판사를 입력 해주세요.");
			document.addBook.bookCompany.focus();
			return;
		}
		var bookIsbn = document.addBook.bookIsbn.value;
		if (bookIsbn == "") {
			alert("Isbn를 입력 해주세요.");
			document.addBook.bookIsbn.focus();
			return;
		}

		if (!(bookIsbn >= '0' && bookIsbn <= '9')
				&& (bookIsbn >= 'a' && bookIsbn <= 'z')) {
			alert("Isbn을 숫자로 입력 해주세요.(13자리)");
			document.addBook.bookIsbn.focus();
			return;
		}

		if (bookIsbn.length != 13) {
			alert("Isbn을 입력 해주세요.(13자리)");
			document.addBook.bookIsbn.focus();
			document.addBook.bookIsbn.select();
			return;
		}

		var bookPrice = document.addBook.bookPrice.value;
		if (!(bookPrice >= '0' && bookPrice <= '9')) {
			alert("가격을 숫자로 입력 해주세요.");
			document.addBook.bookPrice.focus();
			document.addBook.bookPrice.select();
			return;
		}
		var bookContent = document.addBook.bookContent.value;
		if (bookContent == "") {
			alert("내용을 입력 해주세요.");
			document.addBook.bookContent.focus();
			return;
		}
		var genreCode = document.addBook.genreCode.value;
		var bookStored = document.addBook.bookStored.value;

		$.ajax({
			type : 'POST',
			url : "write",
			data : {
				"bookTitle" : bookTitle,
				"bookWriter" : bookWriter,
				"bookCallnumber" : bookCallnumber,
				"bookImg" : bookImg.substring(12),
				"bookState" : bookState,
				"bookBringout" : datepicker,
				"bookCompany" : bookCompany,
				"bookIsbn" : bookIsbn,
				"bookPrice" : bookPrice,
				"bookContent" : bookContent,
				"genreCode" : genreCode,
				"bookStored" : bookStored
			},
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(data) {
				// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.
				location.href = "/";
				$("#addbook").reset();
				$("#addbookbox").hide();
				addbook_flag = 0;
			}
		});
	}
</script>

<!-- 도서 수정 -->
<script type="text/javascript" >
	function bookupdate() {
		 var updateData = $("#updatefrm").serialize();
		$.ajax({
			url : "bookupdate",
			type : 'POST',
			data : updateData,
			// 성공적으로 값을 서버로 보냈을 경우 처리하는 코드입니다.
			success : function(data) {
				// 서버에서 Return된 값으로 중복 여부를 사용자에게 알려줍니다.	
				alert(data);
				$("#updatebody").hide();
				update_flag = 0;
				
				$("#Book").html(data);
			}
		});
	}
</script>


</head>
<body>
	
	<!-- ###########################   add Book -->
	<div id="addbookbox" class="panel panel-primary">
		<div class="panel-heading">
			<h3>도서등록</h3>
		</div>
		<div class="panel-body" align="center">
			<div style="width: 60;">
				<form method="POST" name="addBook" id="addBook">
					<h1>도서등록</h1>
					<table class="table table-hover">
						<tr>
							<td>제목</td>
							<td><input type="text" name="bookTitle" id="bookTitle"></td>
							<td>발행년도</td>
							<td><input type="text" id="datepicker" name="bookBringout"></td>
						</tr>
						<tr>
							<td>저자</td>
							<td><input type="text" name="bookWriter" id="bookWriter"></td>
							<td>장르</td>
							<td><select name="genreCode" id="genreCode">
									<option value="1" selected="selected">소설</option>
									<option value="2">교육</option>
									<option value="3">참고서</option>
									<option value="4">잡지</option>
									<option value="5">컴퓨터</option>
							</select></td>
						</tr>
						<tr>
							<td>입고방법</td>
							<td><input type="radio" id="bookStored" name="bookStored"
								value="구매" checked="checked"> 구매 <input type="radio"
								id="bookStored" value="기증" name="bookStored">기증</td>
							<td>출판사</td>
							<td><input type="text" name="bookCompany" id="bookCompany"></td>
						</tr>
						<tr>
							<td>이미지</td>
							<td><input type="file" name="bookImg" id="bookImg">
							</td>
							<td>ISBN</td>
							<td><input type="text" name="bookIsbn" id="bookIsbn"
								maxlength="13"></td>
						</tr>
						<tr>
							<td>청구번호</td>
							<td><input type="text" name="bookCallnumber"
								id="bookCallnumber"></td>
							<td>가격</td>
							<td><input type="text" name="bookPrice" id="bookPrice">원</td>
						</tr>

						<tr>
							<td>도서상태</td>
							<td><input type="text" name="bookState" id="bookState"
								placeholder="정상"></td>
							<td>내용</td>
							<td><textarea cols="25" rows="5" type="text"
									name="bookContent" id="bookContent"></textarea></td>
						</tr>
						<tr align="right">
							<td colspan="3"></td>
							<td><input type="reset" class="btn btn-default" value="초기화">
								<input type="button" class="btn btn-default" onclick="addbook()"
								value="등록"> <input type="reset" class="btn btn-default"
								onclick="addbookshow()" value="닫기"></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- ############################   update form  -->
	<div id="updatebody" class="panel panel-primary">
		<div class="panel-heading">
			<h3>도서 수정</h3>
		</div>
		<div class="panel-body">
			<div width: 60%;">
				<form method="get" id="updatefrm" name="updatefrm">
					<table class="table table-hover">
						<tr>
							<td>도서번호</td>
							<td><input type="text" id="bookNo" name="bookNo"
								readonly="readonly"></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input type="text" id="bookTitle" name="bookTitle" ></td>
							<td>발행년도</td>
							<td><input type="text" id="datepicker" name="bookBringout"></td>
						</tr>
						<tr>
							<td>저자</td>
							<td><input type="text" id="bookWriter" name="bookWriter"></td>
							<td>장르</td>
							<td>
								<select id="genreCode" name="genreCode">
									<option value="1">소설</option>
									<option value="2">교육</option>
									<option value="3">참고서</option>
									<option value="4">잡지</option>
									<option value="5">컴퓨터</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>입고방법</td>
							<td>
								<input type="radio" id="stored" name="bookStored" value="구매"  > 구매 
								<input type="radio"	id="stored" name="bookStored" value="기증"  >기증 
							</td>
							<td>출판사</td>
							<td><input type="text" id="bookCompany" name="bookCompany"></td>
						</tr>
						<tr>
							<td>청구번호</td>
							<td><input type="text" id="bookCallnumber"
								name="bookCallnumber"></td>
							<td>ISBN</td>
							<td><input type="text" id="bookIsbn" name="bookIsbn"></td>
						</tr>
						<tr>
							<td>이미지</td>
							<td><input type="text" id="bookImg" name="bookImg"></td>

							<td>가격</td>
							<td><input type="text" id="bookPrice" name="bookPrice">원</td>
						</tr>
						<tr>
							<td>도서상태</td>
							<td><input type="text" id="bookState" name="bookState"></td>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="3">
								<textarea type="text" id="bookContent"
									name="bookContent" cols="70" rows="10"></textarea>
							</td>
						</tr>
						<tr align="right">
							<td colspan="4" style="width: 440px;">
								<%-- <input type="hidden" name="page" value=${bookPageDTO.page }> --%>
								<input type="button" class="btn btn-default" value="수정" onclick="bookupdate()">
								<input type="button" class="btn btn-default" value="취소" onclick="updateshow()">
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>

	<!-- #####################################################   리스트 보기  -->
	
	<div id="listbox" class="panel panel-success">
		<div class="panel-heading">
			<h3>
				리스트
				<div id="loginbtn" class="form-group"
					style="float: right; padding-right: 5%;">
					<div class="col-sm-offset-2 col-sm-9">
						<c:if test="${not empty sessionScope.usr}">

							<!-- ######################################## 로그아웃 , 도서등록 -->
							<div style="width: 300px;">
								<input type="button" id="logout" class="btn btn-default"
									onclick="logout('${usr.usrId}')" value="Logout"
									style="float: right; color: red; font-size: 12pt;" />
							</div>
							<div class="col-sm-offset-2 col-sm-9">
								<input type="button" class="btn btn-default"
									onclick="addbookshow()" value="도서등록"
									style="float: right; color: green; font-size: 12pt;" />
							</div>
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
					<c:forEach items="${Book }" var="Book" varStatus="status">

						<h3 onclick="detailbook('${Book.bookNo}');">
							번호:${Book.bookNo}&nbsp;&nbsp;청구번호:${Book.bookCallnumber}&nbsp;&nbsp;&nbsp;&nbsp;제목:${Book.bookTitle}
						</h3>
						<!-- details Book-->
						<div class="panel-body">
							<div id="libraryinfo" class="posts">
								<div style="float: left;">
									<div
										style="width: 140px; height: 110px; overflow: hidden; margin-left: -20px;"
										class="col-sm-4 col-md-3 bookimg">
										<div class="thumbnail" id="thumbnail${Book.bookNo}"
											style="height: auto;"></div>
									</div>

									<div id="detailsbook${Book.bookNo}"></div>
								</div>
							</div>

							<c:if test="${not empty sessionScope.usr}">
								<div style="margin-left: 50px; float: right;">
									<input type="button" value="수정"
										onclick="updateshow('${Book.bookNo}')"> <input
										type="button" value="삭제"
										onclick="bookdelete('${Book.bookNo}')">
								</div>
							</c:if>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>