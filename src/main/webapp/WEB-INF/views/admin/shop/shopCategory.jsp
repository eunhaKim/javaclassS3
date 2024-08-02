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
	
	// 대분류 등록하기
  function category1Check() {
  	let category1Code = category1Form.category1Code.value.toUpperCase();
  	let category1Name = category1Form.category1Name.value;
  	if(category1Code.trim() == "" || category1Name.trim() == "") {
  		alert("대분류명(코드)를 입력하세요");
  		category1Form.category1Name.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category1Input",
  		data : {
  			category1Code : category1Code,
  			category1Name : category1Name
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 코드가 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else if(res == "2") alert("같은 이름이 등록되어 있습니다. \n확인하시고 다시 입력하세요");
  			else {
  				alert("대분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
  }
	
	//대분류 삭제
  function category1Delete(category1Code) {
  	let ans = confirm("대분류 항목을 삭제하시겠습니까?");
  	if(!ans) return false;
  	
  	$.ajax({
  		url  : "${ctp}/admin/shop/category1Delete",
  		type : "post",
  		data : {category1Code : category1Code},
  		success:function(res) {
  			if(res == "0") alert("하위항목이 존재하기에 삭제하실수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
  			else {
  				alert("대분류 항목이 삭제 되었습니다.");
  				location.reload();
  			}
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
	
	//중분류 등록하기
  function category2Check() {
  	let category1Code = category2Form.category1Code.value;
  	let category2Code = category2Form.category2Code.value;
  	let category2Name = category2Form.category2Name.value;
  	if(category1Code.trim() == "" || category2Code.trim() == "" || category2Name.trim() == "") {
  		alert("대분류명을 선택하시고 입력을 다시 확인해주세요.");
  		category2Form.category2Name.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category2Input",
  		data : {
  			category1Code : category1Code,
  			category2Code : category2Code,
  			category2Name : category2Name
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 코드가 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else if(res == "2") alert("대분류와 이름이 같은것이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else {
  				alert("중분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
  }
	
  // 중분류 삭제
  function category2Delete(category2Code) {
  	let ans = confirm("중분류항목을 삭제하시겠습니까?");
  	if(!ans) return false;
  	
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category2Delete",
  		data : {category2Code : category2Code},
  		success:function(res) {
  			if(res == "0") {
  				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
  			}
  			else {
  				alert("중분류 항목이 삭제 되었습니다.");
  				location.reload();
  			}
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
  
	//소분류 입력창에서 대분류 선택시에 중분류 자동 조회하기
  function category1Change() {
  	let category1Code = category3Form.category1Code.value;
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category2Name",
  		data : {category1Code : category1Code},
  		success:function(vos) {
  			let str = '';
  			str += '<option value="">중분류선택</option>'
  			for(let i=0; i<vos.length; i++) {
  				str += '<option value="'+vos[i].category2Code+'">'+vos[i].category2Name+'</option>';
  			}
  			$("#category2CodeSelect").html(str);
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
	
	//소분류 등록하기
  function category3Check() {
  	let category1Code = category3Form.category1Code.value;
  	let category2Code = category3Form.category2Code.value;
  	let category3Code = category3Form.category3Code.value;
  	let category3Name = category3Form.category3Name.value;
  	if(category1Code.trim() == "" || category2Code.trim() == "" || category3Code.trim() == "" || category3Name.trim() == "") {
  		alert("소분류명(코드)를 입력하세요");
  		category3Form.category3Name.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category3Input",
  		data : {
  			category1Code : category1Code,
  			category2Code : category2Code,
  			category3Code : category3Code,
  			category3Name : category3Name
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 항목이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else {
  				alert("소분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
  }
	
	//소분류 삭제하기
  function category3Delete(category3Code) {
  	let ans = confirm("소분류항목을 삭제하시겠습니까?");
  	if(!ans) return false;
  	
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/admin/shop/category3Delete",
  		data : {
  			category3Code : category3Code,
  		},
  		success:function(res) {
  			if(res == "0") {
  				alert("삭제실패~");
  			}
  			else {
  				alert("소분류 항목이 삭제 되었습니다.");
  				location.reload();
  			}
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
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
	  <h1 class="h3 mb-2 text-gray-800">상품 카테고리 관리</h1>
	  <p>상품 카테고리(대/중/소) 등록하기</p>
	
	  <!-- DataTales S -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">대분류 관리(코드는 영문대문자1자리)</h6>
      </div>
      <div class="card-body">
      	<table class="table table-bordered table-hover text-center mb-4">
      		<thead>
			      <tr>
			        <th>대분류코드</th>
			        <th>대분류명</th>
			        <th>삭제</th>
			      </tr>
		      </thead>
		      <c:forEach var="category1VO" items="${category1Vos}">
		        <tr class="text-center">
		          <td>${category1VO.category1Code}</td>
		          <td>${category1VO.category1Name}</td>
		          <td><a href="javascript:category1Delete('${category1VO.category1Code}')" class="btn btn-danger btn-circle btn-sm" title="카테고리 삭제"><i class="fas fa-trash" aria-hidden="true"></i></a></td>
		        </tr>
		      </c:forEach>
		      <tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </table>
		    
		    <h6 class="m-0 font-weight-bold text-primary mb-3">대분류 등록</h6>
      	<form name="category1Form">
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">대분류코드*</span>
	      		</div>
		      	<input type="text" name="category1Code" id="category1Code" class="form-control" required="required"/>
	      	</div>
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">대분류명*</span>
	      		</div>
		      	<input type="text" name="category1Name" id="category1Name" class="form-control" required="required"/>
	      	</div>
	      	<p class="mt-2">😋 대분류코드는 영문대문자1자리(ex:A,B,C,...)로 입력해주세요.</p>
	      	<input type="button" value="대분류등록" onclick="category1Check()" class="form-control btn btn-primary"/>
      	</form>
      </div>
	  </div>
	  <!-- DataTales E -->
	
	  <!-- DataTales S -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">중분류 관리(코드는 숫자2자리)</h6>
      </div>
      <div class="card-body">
      	<table class="table table-bordered table-hover text-center mb-4">
      		<thead>
			      <tr>
			        <th>중분류코드</th>
			        <th>중분류명</th>
			        <th>대분류명</th>
			        <th>삭제</th>
			      </tr>
		      </thead>
		      <c:forEach var="category2VO" items="${category2Vos}">
		        <tr class="text-center">
		          <td>${category2VO.category2Code}</td>
		          <td>${category2VO.category2Name}</td>
		          <td>${category2VO.category1Code}</td>
		          <td><a href="javascript:category2Delete('${category2VO.category2Code}')" class="btn btn-danger btn-circle btn-sm" title="카테고리 삭제"><i class="fas fa-trash" aria-hidden="true"></i></a></td>
		        </tr>
		      </c:forEach>
		      <tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </table>
		    
		    <h6 class="m-0 font-weight-bold text-primary mb-3">중분류 등록</h6>
      	<form name="category2Form">
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">대분류코드*</span>
	      		</div>
		      	<select name="category1Code" class="form-control">
		      		<option value="">대분류명</option>
		      		<c:forEach var="category1" items="${category1Vos}">
		      			<option>${category1.category1Code}</option>
		      		</c:forEach>
		      	</select>
	      	</div>
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">중분류코드*</span>
	      		</div>
		      	<input type="text" name="category2Code" id="category2Code" class="form-control" required="required"/>
	      	</div>
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">중분류명*</span>
	      		</div>
		      	<input type="text" name="category2Name" id="category2Name" class="form-control" required="required"/>
	      	</div>
	      	<p class="mt-2">😋 중분류코드는 숫자2자리(ex:01,02,03,...)로 입력해주세요.</p>
	      	<input type="button" value="중분류등록" onclick="category2Check()" class="form-control btn btn-primary"/>
      	</form>
      </div>
	  </div>
	  <!-- DataTales E -->
	
	  <!-- DataTales S -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">소분류 관리(코드는 숫자3자리)</h6>
      </div>
      <div class="card-body">
      	<table class="table table-bordered table-hover text-center mb-4">
      		<thead>
			      <tr>
			        <th>소분류코드</th>
			        <th>소분류명</th>
			        <th>중분류명</th>
			        <th>대분류명</th>
			        <th>삭제</th>
			      </tr>
		      </thead>
		      <c:forEach var="category3VO" items="${category3Vos}">
		        <tr class="text-center">
		          <td>${category3VO.category3Code}</td>
		          <td>${category3VO.category3Name}</td>
		          <td>${category3VO.category2Code}</td>
		          <td>${category3VO.category1Code}</td>
		          <td><a href="javascript:category3Delete('${category3VO.category3Code}')" class="btn btn-danger btn-circle btn-sm" title="카테고리 삭제"><i class="fas fa-trash" aria-hidden="true"></i></a></td>
		        </tr>
		      </c:forEach>
		      <tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </table>
		    
		    <h6 class="m-0 font-weight-bold text-primary mb-3">소분류 등록</h6>
      	<form name="category3Form">
      		<select name="category1Code" class="form-control mb-1" onchange="category1Change()">
	      		<option value="">대분류명</option>
	      		<c:forEach var="category1" items="${category1Vos}">
	      			<option>${category1.category1Code}</option>
	      		</c:forEach>
	      	</select>
      		<select name="category2Code" id="category2CodeSelect" class="form-control mb-1">
	      		<option value="">중분류명</option>
	      	</select>
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">소분류코드*</span>
	      		</div>
		      	<input type="text" name="category3Code" id="category3Code" class="form-control" required="required"/>
	      	</div>
	      	<div class="input-group">
		      	<div class="input-group-prepend">
	      			<span class="input-group-text">소분류명*</span>
	      		</div>
		      	<input type="text" name="category3Name" id="category3Name" class="form-control" required="required"/>
	      	</div>
	      	<p class="mt-2">😋 소분류코드는 숫자3자리(ex:001,002,003,...)로 입력해주세요.</p>
	      	<input type="button" value="소분류등록" onclick="category3Check()" class="form-control btn btn-primary"/>
      	</form>
      </div>
	  </div>
	  <!-- DataTales E -->

  </div>
  <!-- /.container-fluid -->

</body>
</html>