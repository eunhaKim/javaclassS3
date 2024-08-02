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
	  
	  function newPassword() {
    	let mid = $("#mid").val().trim();
    	let email = $("#email").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입시 등록한 아이디와 메일주소를 입력하세요");
    		$("#mid").focus();
    		return false;
    	}
    	$("#spinner2").css("display","block");
    	$.ajax({
    		url  : "${ctp}/member/memberNewPassword",
    		type : "post",
    		data : {
    			mid   : mid,
    			email : email
    		},
    		success:function(res) {
    			$("#spinner2").css("display","none");
    			if(res != "0") alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
    			else alert("등록하신 정보가 일치하지 않습니다.\n확인후 다시 처리하세요.");
    		},
    		error:function(request,status,error){        
    			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);       
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
      <li class="breadcrumb-item active text-dark">비밀번호찾기</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
    	<ul class="nav nav-tabs mb-3">
			  <li class="nav-item">
			    <a class="nav-link" href="${ctp}/member/memberMidSearch">아이디찾기</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link active" href="${ctp}/member/memberPwdSearch">비밀번호 찾기</a>
			  </li>
			</ul>
			<h2 class="mt-5">비밀번호 찾기</h2>
    	<p>가입 아이디와 이메일주소를 입력하세요. 이메일로 임시 비밀번호를 전송해드립니다. <br/>발급받으신 비밀번호로 로그인하시고 비밀번호를 꼭 변경해주세요.</p>
	    <form name="myform" method="post">
	    	<div class="input-group d-flex mt-5">
	        <input type="text" name="mid" id="mid" class="form-control py-3" placeholder="아이디" autofocus required />
	        <input type="text" name="email" id="email" class="form-control py-3" placeholder="이메일"  required />
	        <input type="button" onclick="newPassword()" value="전송받기" class="btn btn-primary text-white"/>
	      </div>
      </form>
		</div>
	</div>
</div>
</body>
</html>