<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberJoin.jsp</title>
  <script>
  'use strict';
  
  function midSearch(){
	  let name = $("#name").val().trim();
	  let email = $("#email").val().trim();
	  
	  if(name == "" || email == ""){
		  alert("가입시 입력한 이름과 이메일을 입력해주세요.");
		  $("#name").focus();
		  return false;
	  }
	  $("#spinner2").css("display","block");
	  $.ajax({
		  url : "${ctp}/member/memberMidSearch",
		  type : "post",
		  data : {
			  name : name,
			  email : email
		  },
		  success : function(res){
			  $("#spinner2").css("display","none");
			  if(res != "0") alert("이메일로 아이디를 전송하였습니다.");
			  else alert("등록하신 정보가 일치하지 않습니다. \n확인후 다시 시도해주세요.");
		  },
		  error : function(){
			  alert("전송실패");
		  }		  
	  });
  }
  </script>
</head>
<body>
<!-- container Start -->
<div class="spinner-border text-primary" id="spinner2" style="display:none;"></div>
<div class="container-fluid pt-3 pb-5">
  <div class="container py-5">
    <ol class="breadcrumb justify-content-start mb-4 ml-3">
      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> Home</a></li>
      <li class="breadcrumb-item"><a href="#">member</a></li>
      <li class="breadcrumb-item active text-dark">아이디찾기</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
    	<form name="myform" method="post">
	    	<ul class="nav nav-tabs mb-3">
				  <li class="nav-item">
				    <a class="nav-link active" href="${ctp}/member/memberMidSearch">아이디찾기</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" href="${ctp}/member/memberPwdSearch">비밀번호 찾기</a>
				  </li>
				</ul>
				<h2 class="mt-5">아이디찾기</h2>
	    	<p>가입시 입력한 이름과 이메일주소를 입력하세요. 이메일로 아이디를 전송해드립니다.</p>
	    	<div class="input-group d-flex mt-5">
          <input type="text" name="name" id="name" class="form-control py-3" placeholder="이름" autofocus required>
          <input type="text" name="email" id="email" class="form-control py-3" placeholder="이메일"  required>
          <input type="button" value="전송받기" onclick="midSearch()" class="btn btn-primary text-white" />
        </div>
		  </form>
		</div>
	</div>
</div>
</body>
</html>