<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>boardRight.jsp</title>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		.img-lineTalk { aspect-ratio : 1 ; object-fit: cover;}
		.knowhowMainImg img {aspect-ratio : 1 ; object-fit: cover; height:250px;}
		.h-80 {height:90px !important; object-fit: cover;}
		.h-300 {height:400px !important; object-fit: cover;}
		.trandingTags {margin:0; padding:0;}
		.trandingTags li { list-style: none; text-align: center; display:inline-block; word-break: keep-all; margin:12px 5px;}
		.trandingTags li a { color:#333; padding:10px 15px;}
	</style>
  <script>
  	'use strict';
  	
  	// 게시판 검색
  	function knowhowSearch2(){
  		let searchStr2 = $("#searchStr2").val();
  		if(searchStr2.trim()=="") {
  			alert("검색어를 입력하세요");
  			return false;
  		}
  		
  		$("#knowhowSearch2").submit();
  	}
  	$(function(){
			wordCheck();
		});
		
		function wordCheck() {
			let url = "http://localhost:9090/javaclassS3/";
		  let selector = "a.h4";
	   	let excludeWord = " ../test"; // 제외할문자열('/'로 구분해서 입력)
	   	
	   	$.ajax({
	   		url  : "${ctp}/board/wordcloud/analyzer3",
	   		type : "post",
	   		data : {
	   			url  : url,
	   			selector : selector,
	   			excludeWord : excludeWord
	   		},
	   		success:function(data) {
	   			let no = 0;
	   			let res = '';
	   			Object.entries(data).forEach(([key, value]) => {
	   			    console.log(key, value);
	   			    no++;
	   			    res += '<li>';
	   			    res += '<a class="bg-light rounded-pill" href="#">';
	   			    res += key;
	   			 		res += '</a>';
	   			 		res += '</li>';
	   			});
	   			$("#demo2").html(res);
	   		},
	   		error : function() {
	   			alert("전송오류~");
	   		}
	   	});
	   }
  </script>
</head>
<body>
<div class="p-3 rounded border">
	<form action="${ctp}/board/knowhowSearch" method="post" name="knowhowSearch2" id="knowhowSearch2">
	  <div class="input-group w-100 mx-auto d-flex mb-4">
      <input type="text" name="searchStr" id="searchStr2" class="form-control p-3" placeholder="현재 게시판 검색" aria-describedby="search-icon-1">
      <a href="javascript:knowhowSearch2()" class="btn btn-primary input-group-text p-3"><i class="fa fa-search text-white"></i></a>
	  </div>
	  <input type="hidden" name="boardName" value="${boardName}" />
  </form>
  
  <div class="col-lg-12">
    <div class="position-relative banner-2">
        <img src="${ctp}/img/banner-2.jpg" class="img-fluid w-100 rounded" alt="">
          <div class="text-center banner-content-2">
              <h4 class="mt-2 text-white">AI 약초 검색</h4>
              <p class="text-dark mb-2 p-2">teachablemachine으로 학습된 약초를 검색해보자</p>
              <a href="${ctp}/ai" class="btn btn-primary text-white px-4">약초 이미지 검색</a>
          </div>
      </div>
  </div>
        
  <div class="row g-4 mt-3 mb-5">
	  <div class="col-lg-12">
	  		<div class="border-bottom mb-3 pb-3">
            <h4 class="mb-0">Trending Tags</h4>
        </div>
        <ul class="trandingTags" id="demo2"></ul>
	  </div>
	</div>
</div>
</body>
</html>