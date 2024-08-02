<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberPwdCheck.jsp</title>
  <script>
  'use strict';
  
  $(function(){
	  $("#pwdDemo").hide();
  });
  
  // 비밀번호 확인
  function pwdCheck(){
	  let pwd = $("#pwd").val().trim();
	  if(pwd == ""){
		  alert("현재 비밀번호를 입력해 주세요.");
		  return false;
	  }
	  
	  $.ajax({
		  url	 : "${ctp}/member/memberPwdCheck",
		  type : "post",
		  data : {
			  pwd : pwd,
			  mid : '${sMid}'
		  },
		  success : function(res){
			  if(res != "0") {
  				if('${pwdFlag}' == 'p') {
  					$("#pwdDemo").show();
  					$("#pwdCheck").focus();
  					$("#pwdForm").hide();
  				}
  				else location.href = '${ctp}/member/memberUpdate';
  			}
  			else {
  				alert("비밀번호가 틀립니다. 확인해주세요");
  				$("#pwd").focus();
  			}
		  },
		  error : function(){
			  alert("전송오류!");
		  }
	  });
  }
  
  // 비밀번호 변경
  function pwdChangeCheck() {
  	let pwdCheck = $("#pwdCheck").val();
  	let pwdCheckRe = $("#pwdCheckRe").val();
  	
  	if(pwdCheck.trim() == "" || pwdCheckRe.trim() == "") {
  		alert("변경하실 비밀번호를 입력하세요");
  		$("#pwdCheck").focus();
  		return false;
  	}
  	else if(pwdCheck.trim() != pwdCheckRe.trim()) {
  		alert("새로 입력한 비밀번호가 틀립니다. 확인해주세요.");
  		$("#pwdCheck").focus();
  		return false;
  	}
  	
  	$.ajax({
  		url  : "${ctp}/member/memberPwdChangeOk",
  		type : "post",
  		data : {
  			mid : '${sMid}',
  			pwd : pwdCheck
  		},
  		success:function(res) {
  			if(res != "0") {
  				alert('비밀번호가 변경되었습니다.\n다시 로그인 하세요');
  				location.href = '${ctp}/member/memberLogout';
  			}
  		},
  		error : function() {
  			alert("전송오류!");
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
      <li class="breadcrumb-item active text-dark">비밀번호확인</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
			<h2>비밀번호확인</h2>
			<hr/>
    	<p>회원 정보 수정을 하기위해 현재 비밀번호를 확인합니다.</p>
    	<div class="input-group d-flex mt-5">
        <input type="password" name="pwd" id="pwd" value="1234" class="form-control" autofocus required />
        <input type="button" value="비밀번호확인" onclick="pwdCheck()" class="btn btn-primary text-white" />
      </div>
			<div id="pwdDemo" class="mt-5">
				<p><i class="fa-solid fa-face-smile-wink text-primary"></i> 변경하실 비밀번호를 입력해주세요.</p>
				<div class="form-group mt-3">
					<input type="password" name="pwdCheck" id="pwdCheck" class="form-control mb-3"/>
					<p>변경하실 비밀번호를 한번더 입력해주세요 : </p>
					<input type="password" name="pwdCheckRe" id="pwdCheckRe" class="form-control mb-3"/>
					<input type="button" value="비밀번호변경" onclick="pwdChangeCheck()" class="btn btn-success text-white" />
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>