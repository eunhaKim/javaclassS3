<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>lineTalkList.jsp</title>
  <style>
  #ContentBox { background:linear-gradient(rgba(0, 0, 0, 0.1), rgba(0, 0, 0, 0.1)), url("${ctp}/img/contentBoxBg.jpg") top center/cover;  }
  #ContentBox h2 { color: var(--bs-primary); }
  </style>
  <script>
	  'use strict';
		
		// 채팅내용을 DB에 저장하기
    function chatInput() {
    	let chat = $("#chat").val();
    	if(chat.trim() == "") {
    		alert("내용을 입력해주세요.");
    		return false;
    	}
    	
   		$.ajax({
   			url  : "${ctp}/lineTalk/lineTalkInput",
   			type : "post",
   			data : {chat : chat},
   			success : function(res){
   				if(res != "0"){
   					alert("등록되었습니다.");
   					location.reload();
   				}
   			},
   			error: function() {
   				alert("전송오류!!");
   			}
   		});
    }
  

		//채팅 대화입력후 엔터키를 누르면 자동으로 메세지 DB에 저장시키기....chatInput()함수 호출하기
		$(function(){
			$("#chat").on("keydown",function(e){
				if(e.keyCode == 13) chatInput();
			});
		});
  </script>
</head>
<body>
<!-- container Start -->
<div class="spinner-border text-primary" id="spinner2" style="display:none;"></div>
<div class="container-fluid pt-3 pb-5">
  <div class="container py-5">
    <ol class="breadcrumb justify-content-start mb-4 ml-3">
      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> Home</a></li>
      <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
      <li class="breadcrumb-item active text-dark">한줄수다</li>
    </ol>
    <div id="ContentBox" class="bg-light rounded p-5 mobileBox">
			<h2><i class="fa-solid fa-comments"></i> 한줄수다</h2>
			<hr class="text-primary"/>
			<p class="text-primary">마우스 휠을 천천히 올려주세요 ^^</p>
			<!-- 한줄수다박스 START -->
			<iframe src="${ctp}/lineTalk/lineTalkList" width="100%" height="400px"></iframe>
			<!-- 한줄수다박스 END -->
			<div class="input-group mt-3">
        <input type="text" name="chat" id="chat" class="form-control" placeholder="대화내용을 입력하세요" autofocus />
        <div class="input-group-append">
          <input type="button" value="글등록" onclick="chatInput()" class="btn btn-primary"/>
        </div>
      </div>
		</div>
	</div>
</div>
</body>
</html>