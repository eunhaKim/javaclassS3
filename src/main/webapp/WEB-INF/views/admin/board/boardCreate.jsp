<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardCreate.jsp</title>
<script>
	'use strict';
	 let nameCheckSw = 0;
	 let tableCheckSw = 0;
	
	// 게시판 이름 중복체크
  function nameCheck() {
  	let boardName = myform.boardName.value;
  	
  	if(boardName.trim() == "") {
  		alert("게시판이름을 입력하세요!");
  		myform.boardName.focus();
  	}
  	else {
  		$.ajax({
  			url  : "${ctp}/admin/board/boardNameCheck",
  			type : "post",
  			data : {boardName : boardName},
  			success:function(res) {
  				if(res != "0") {
  					alert("이미 사용중인 게시판이름입니다. 다시 입력하세요.");
  					myform.boardName.focus();
  				}
  				else {
  					alert("사용 가능한 게시판이름 입니다.");
  					nameCheckSw = 1;
  				}
  			},
  			error : function() {
  				alert("전송 오류!");
  			}
  		});
  	}
  }
	
	// 테이블명 중복체크
  function tableCheck() {
  	let tableName = myform.tableName.value;
  	
  	if(tableName.trim() == "") {
  		alert("테이블명을 입력하세요!");
  		myform.tableName.focus();
  	}
  	else {
  		tableCheckSw = 1;
  		
  		$.ajax({
  			url  : "${ctp}/admin/board/tableNameCheck",
  			type : "post",
  			data : {tableName : tableName},
  			success:function(res) {
  				if(res != "0") {
  					alert("이미 사용중인 테이블명입니다. 다시 입력하세요.");
  					myform.tableName.focus();
  				}
  				else alert("사용 가능한 테이블명 입니다.");
  			},
  			error : function() {
  				alert("전송 오류!");
  			}
  		});
  	}
  }
	
	// 생성전 체크
	function fCheck(){
		// 정규식을 이용한 유효성검사처리.....
  	let regTableName = /^[a-z]{2,20}$/;	// 테이블명은 4~20의 영문소문자만 가능
    let regBoardName = /^[\w\s가-힣&-]+$/;					// 게시판 이름은 한글, 알파벳, 숫자, 밑줄, &, -만 가능
  	let tableName = myform.tableName.value;
    let boardName = myform.boardName.value;
    if(!regTableName.test(tableName)) {
			alert("테이블명은 4~20의 영문소문자만 가능합니다.");
			myform.tableName.focus();
			return false;
		}
    else if(!regBoardName.test(boardName)) {
			alert("게시판 이름은 한글, 알파벳, 숫자, 밑줄, &, -만 가능합니다.");
			myform.boardName.focus();
			return false;
		}
    if(nameCheckSw == 0) {
			alert("게시판이름 중복확인버튼을 눌러주세요");
			document.getElementById("boardName").focus();
		}
		else if(tableCheckSw == 0) {
			alert("테이블명 중복확인버튼을 눌러주세요");
			document.getElementById("tableName").focus();
		}
    else{
    	myform.submit();
    }
    
    
	}
	
</script>
<style>
	.input-group { margin-bottom:5px; }
	.input-group .input-group-prepend span{ min-width:150px; }
</style>
</head>
<body>
	<!-- Begin Page Content -->
  <div class="container-fluid">

	  <!-- Page Heading -->
	  <h1 class="h3 mb-2 text-gray-800">새게시판 만들기</h1>
	  <p>Validator를 사용한 BackEnd Check & 트랜젝션을 이용해 sql2개 동시실행</p>
	
	  <!-- DataTales Example -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">게시판 생성</h6>
      </div>
      <div class="card-body">
      	<form name="myform" method="post">
      	<div class="input-group">
	      	<div class="input-group-prepend">
      			<span class="input-group-text">게시판이름*</span>
      		</div>
	      	<input type="text" name="boardName" id="boardName" class="form-control" required="required"/>
	      	<div class="input-group-append"><input type="button" onclick="nameCheck()" value="중복확인" class="btn btn-primary"/></div>
      	</div>
      	<div class="input-group">
	      	<div class="input-group-prepend">
      			<span class="input-group-text">테이블명*</span>
      		</div>
	      	<input type="text" name="tableName" id="tableName" class="form-control" required="required"/>
	      	<div class="input-group-append"><input type="button" onclick="tableCheck()" value="중복확인" class="btn btn-warning"/></div>
      	</div>
      	<div class="input-group">
	      	<div class="input-group-prepend">
      			<span class="input-group-text">타입*</span>
      		</div>
      		<select class="form-control" name="boardType" id="boardType">
      			<option value="board">일반게시판</option>
      			<option value="gallery">포토갤러리</option>
      		</select>
      	</div>
      	<div class="input-group">
	      	<div class="input-group-prepend">
      			<span class="input-group-text">카테고리등록</span>
      		</div>
	      	<input type="text" name="category" id="category" class="form-control" disabled/>
      	</div>
      	<p class="mt-2">😋 카테고리는 준비중입니다.</p>
      	<input type="button" value="게시판생성" onclick="fCheck()" class="form-control btn btn-primary"/>
      	</form>
      </div>
	  </div>

  </div>
  <!-- /.container-fluid -->

</body>
</html>