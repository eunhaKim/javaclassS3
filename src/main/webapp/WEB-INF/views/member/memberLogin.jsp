<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberJoin.jsp</title>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <style>
  .was-validated .form-control {margin:5px 0 10px;}
  </style>
  <script>
	  'use strict';
	  $(function(){
		  if('${cMid}' != "") $("#idSave").prop("checked", true);
	  });
	  
		// 카카오 로그인(자바스크립트 앱키 등록)
    window.Kakao.init("fde9bae21527997d554b2574bc6ebf80");
    
    function kakaoLogin() {
    	window.Kakao.Auth.login({
    		scope: 'profile_nickname, account_email',
    		success:function(autoObj) {
    			console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...");
    			window.Kakao.API.request({
    				url : '/v2/user/me',
    				success:function(res) {
    					const kakao_account = res.kakao_account;
    					console.log(kakao_account);
    					location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
    				}
    			});
    		}
    	});
    }
  </script>
</head>
<body>
<!-- container Start -->
<div class="container-fluid pt-3 pb-5">
  <div class="container py-5">
    <ol class="breadcrumb justify-content-start mb-4 ml-3">
      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> Home</a></li>
      <li class="breadcrumb-item"><a href="#">member</a></li>
      <li class="breadcrumb-item active text-dark">memberLogin</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
    	<form name="myform" method="post">
	    	<h2>로그인</h2>
	    	<hr/>
	    	<p>로그인을 하시면 많은 서비스를 이용하실 수 있습니다.<br/> 
	    	( 테스트 아이디 비번 - 레벨1: test, 레벨2: test2, 레벨3: test3 / 비번:1234 )</p>
	    	<div class="input-group d-flex mt-5">
            <input type="text" name="mid" id="mid" value="${cMid}" class="form-control py-3" placeholder="아이디" autofocus required>
            <input type="password" name="pwd" id="pwd" value="1234" class="form-control py-3" placeholder="비밀번호"  required>
            <input type="submit" value="로그인" class="btn btn-primary text-white"/>
        </div>
        <div class="mt-3 row">
        	<div class="col-lg-4 col-sm-12">
	        	<input type="checkbox" name="idSave" id="idSave" class="mb-1" /> <label for="idSave" class="me-2 mb-1">아이디 저장</label>
	        </div>
        	<div class="col-lg-4 col-sm-12 text-center">
	        	<input type="button" onclick="location.href='${ctp}/member/memberMidSearch'" value="아이디찾기" class="btn btn-secondary btn-sm me-1 mb-1"/>
	        	<input type="button" onclick="location.href='${ctp}/member/memberPwdSearch'" value="비밀번호 찾기" class="btn btn-secondary btn-sm me-1 mb-1"/>
	        </div>
        	<div class="col-lg-4 col-sm-12 text-right">
	        	<input type="button" onclick="kakaoLogin()" value="카카오 로그인" class="btn btn-warning btn-sm mb-1 me-1 "/>
	        	<input type="button" onclick="location.href='${ctp}/member/memberJoin'" value="회원가입" class="btn btn-success btn-sm mb-1"/>
	        </div>
        </div>
		  </form>
		</div>
	</div>
</div>
</body>
</html>