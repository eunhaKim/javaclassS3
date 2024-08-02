<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product.jsp</title>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script>
	'use strict';
	let cnt = 1;
	
	// 상품 입력창에서 대분류 선택(onChange)시 중분류를 가져와서 중분류 선택박스에 뿌리기
  function category1Change() {
  	var category1Code = myform.category1Code.value;
		$.ajax({
			type : "post",
			url  : "${ctp}/admin/shop/category2Name",
			data : {category1Code : category1Code},
			success:function(data) {
				var str = "";
				str += "<option value=''>중분류</option>";
				for(var i=0; i<data.length; i++) {
					str += "<option value='"+data[i].category2Code+"'>"+data[i].category2Name+"</option>";
				}
				$("#category2Code").html(str);
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
	
	//중분류 선택시 소분류항목 가져오기
  function category2Change() {
  	var category1Code = myform.category1Code.value;
  	var category2Code = myform.category2Code.value;
  	
		$.ajax({
			type : "post",
			url  : "${ctp}/admin/shop/category3Name",
			data : {
				category1Code : category1Code,
				category2Code : category2Code
			},
			success:function(data) {
				var str = "";
				str += "<option value=''>소분류</option>";
				for(var i=0; i<data.length; i++) {
					str += "<option value='"+data[i].category3Code+"'>"+data[i].category3Name+"</option>";
				}
				$("#category3Code").html(str);
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
	
	//상품 등록하기전에 체크후 전송...
  function fCheck() {
  	let category1Code = myform.category1Code.value;
  	let category2Code = myform.category2Code.value;
  	let category3Code = myform.category3Code.value;
  	let productName = myform.productName.value;
		let mainPrice = myform.mainPrice.value;
		let detail = myform.detail.value;
		let file = myform.file.value;	
		let ext = file.substring(file.lastIndexOf(".")+1);
		let uExt = ext.toUpperCase();
		let regExpPrice = /^[0-9|_]*$/;
		
		if(category3Code == "") {
			alert("상품 소분류(세분류)를 입력하세요!");
			return false;
		}
		else if(productName == "") {
			alert("상품명(모델명)을 입력하세요!");
			return false;
		}
		else if(file == "") {
			alert("상품 메인 이미지를 등록하세요");
			return false;
		}
		else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
			alert("업로드 가능한 파일이 아닙니다.");
			return false;
		}
		else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
			alert("상품금액은 숫자로 입력하세요.");
			return false;
		}
		else if(detail == "") {
			alert("상품의 초기 설명을 입력하세요");
			return false;
		}
		else if(document.getElementById("file").value != "") {
			var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
			var fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("첨부파일의 크기는 10MB 이내로 등록하세요");
				return false;
			}
			else {
				myform.submit();
			}
		}
  }
	
	//옵션항목 추가
  function addOption() {
  	let strOption = "";
  	let test = "t" + cnt; 
  	
  	strOption += '<div id="'+test+'" class="col-lg-12"><div class="form-group col-lg-6">';
  	strOption += ' 	<label for="mainPrice">상품옵션이름</label>';
  	strOption += ' 	<input type="text" name="optionName" id="optionName${cnt}" class="form-control" />';
  	strOption += '</div>';
  	strOption += '<div class="form-group col-lg-6">';
  	strOption += ' 	<label for="mainPrice">상품옵션가격</label>';
  	strOption += ' 	<input type="text" name="optionPrice" id="optionPrice'+cnt+'" class="form-control" />';
  	strOption += ' 	<input type="button" value="옵션삭제" class="mt-1 btn btn-outline-danger btn-sm form-control" onclick="removeOption('+test+')"/><br/>';
  	strOption += '</div></div>';
		console.log(strOption);
  	$("#optionBox").append(strOption);
  	cnt++;
  }
	
	//옵션항목 삭제
  function removeOption(test) {
  	$("#"+test.id).remove();
  }
</script>
<style>
	.input-group { margin-bottom:5px; }
	.input-group .input-group-prepend span{ min-width:150px; }
	.optionBox { margin:10px 0; padding:15px 0 0px;}
	.optionBox .col-lg-12 { padding:0 ; border-top: 1px dotted #ddd; padding-top:10px;}
</style>
</head>
<body>
	<!-- Begin Page Content -->
  <div class="container-fluid">

	  <!-- Page Heading -->
	  <h1 class="h3 mb-2 text-gray-800">상품 등록</h1>
	
	  <!-- DataTales S -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">상품 등록하기</h6>
      </div>
      <div class="card-body">
      	<form name="myform" method="post" enctype="multipart/form-data">
      		<div class="row">
			      <div class="form-group col-lg-4">
			        <label for="category1Code">대분류*</label>
			        <select id="category1Code" name="category1Code" class="form-control" onchange="category1Change()">
			          <option value="">대분류를 선택하세요</option>
			          <c:forEach var="cat1Vo" items="${cat1Vos}">
			          	<option value="${cat1Vo.category1Code}">${cat1Vo.category1Name}</option>
			          </c:forEach>
			        </select>
			      </div>
			      <div class="form-group col-lg-4">
			        <label for="category2Code">중분류*</label>
			        <select id="category2Code" name="category2Code" class="form-control" onchange="category2Change()">
			          <option value="">중분류명</option>
			        </select>
			      </div>
			      <div class="form-group col-lg-4">
			        <label for="category3Code">소분류*</label>
			        <select id="category3Code" name="category3Code" class="form-control">
			          <option value="">소분류명</option>
			        </select>
			      </div>
			    </div>
		      <div class="form-group">
		        <label for="productName">상품(모델)명*</label>
		        <input type="text" name="productName" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요" required />
		      </div>
		      <div class="form-group">
		        <label for="file">메인이미지*</label>	<!-- 파일의 name값은 db테이블의 필드명과 꼭 다르게 줘야함. 즉 vo필드명과 달라야 한다. -->
		        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required />
		        (업로드 가능파일:jpg, jpeg, gif, png)
		      </div>
		      <div class="form-group">
		      	<label for="mainPrice">상품기본가격*</label>
		      	<input type="number" name="mainPrice" id="mainPrice" class="form-control" required />
		      </div>
		      <div class="row bg-light optionBox" id="optionBox">
			      <div class="form-group col-lg-6">
			      	<label for="mainPrice">상품옵션이름</label>
			      	<input type="text" name="optionName" id="optionName" class="form-control"/>
			      </div>
			      <div class="form-group col-lg-6">
			      	<label for="mainPrice">상품옵션가격</label>
			      	<input type="text" name="optionPrice" id="optionPrice" class="form-control"/>
			      </div>
			    </div>
			    <div class="form-group"><input type="button" value="옵션박스추가하기" onclick="addOption()" class="btn btn-secondary btn-sm form-control"/></div>
		      <div class="form-group">
		      	<label for="detail">상품요약설명*</label>
		      	<input type="text" name="detail" id="detail" class="form-control" required />
		      </div>
		      <div class="form-group" style="position:relative;">
		      	<label for="content">상품상세설명*</label>
		      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
		      </div>
		      <script>
				    CKEDITOR.replace("content",{
				    	uploadUrl:"${ctp}/imageUpload",
				    	filebrowserUploadUrl: "${ctp}/imageUpload",
				    	height:460
				    });
				  </script>
				  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-primary form-control"/> &nbsp;
		    </form>
      </div>
	  </div>
	  <!-- DataTales E -->

  </div>
  <!-- /.container-fluid -->

</body>
</html>