<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>nav.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
	  'use strict';
	  
	  function userDelCheck(){
		  let ans = confirm("회원 탈퇴하시겠습니까?");
		  if(ans){
			  $.ajax({
				  url 	: "${ctp}/member/userDel",
				  type 	: "post",
				  success : function(res){
					  if(res != "0") {
						  alert("회원탈퇴가 처리되었습니다.");
						  location.href="${ctp}/main";
					  }
					  else {
						  alert("회원탈퇴신청 실패~");
					  }
				  },
				  error : function(){
					  alert("전송오류!");
				  }
			  });
		  }
	  }
	  
		//오늘 날짜출력
    $(document).ready(function () {
      function convertTime() {
	      var now = new Date();
	      var month = now.getMonth() + 1;
	      var date = now.getDate();
	      return month + '월' + date + '일';
      }

      var currentTime = convertTime();
      $('.nowtime').append(currentTime);
    });
		
  	// 날씨 가져오기
    $.getJSON('https://api.openweathermap.org/data/2.5/weather?q=Seoul,kr&appid=69d40ef4e9f601efe99d5dd0bcf874cb&units=metric',
	    function (WeatherResult) {
	      // 기온출력
	      $('.SeoulNowtemp').append(WeatherResult.main.temp);
	      // $('.SeoulLowtemp').append(WeatherResult.main.temp_min);
	      // $('.SeoulHightemp').append(WeatherResult.main.temp_max);
	
	      //날씨아이콘출력
	      //WeatherResult.weater[0].icon
	      var weathericonUrl =
	        '<img src= "http://openweathermap.org/img/wn/'
	        + WeatherResult.weather[0].icon +
	        '.png"  class="img-fluid w-100 me-2" alt="' + WeatherResult.weather[0].description + '"/>'
	
	      $('.SeoulIcon').html(weathericonUrl);
	    });
  	
  	// 노하우 검색
  	function knowhowSearch(){
  		let searchStr = $("#searchStr").val();
  		if(searchStr.trim()=="") {
  			alert("검색어를 입력하세요");
  			return false;
  		}
  		
  		$("#knowhowSearch").submit();
  	}
  </script>
</head>
<body>
<!-- Navbar start -->
<div class="container-fluid sticky-top px-0">
  <div class="container-fluid topbar bg-dark d-lg-block">
    <div class="container px-0">
      <div class="topbar-top d-flex justify-content-between flex-lg-wrap">
        <div class="top-link flex-lg-wrap d-none d-lg-block">
          <div class="d-flex icon">
            <p class="mb-0 text-white me-2 ml-5"><i class="fas fa-link text-white"></i> Follow Us:</p>
            <a href="" class="me-2"><i class="fab fa-instagram text-body link-hover"></i></a>
            <a href="" class="me-2"><i class="fab fa-youtube text-body link-hover"></i></a>
          </div>
        </div>
        <div class="top-member ml-auto">
	        <nav class="navbar navbar-light navbar-expand-xl">
	          <c:if test="${empty sLevel}">
	          	<a href="${ctp}/member/memberLogin" class="nav-link text-white"><i class="fa-regular fa-user me-1"></i>로그인</a>
	          	<a href="${ctp}/member/memberJoin" class="nav-link text-white">회원가입</a>
	          </c:if>
	          <c:if test="${!empty sLevel}">
	          	<a href="${ctp}/member/memberLogout" class="nav-link text-white"><i class="fa-regular fa-user me-1"></i>Logout</a>
	        		<div class="nav-item dropdown">
		        		<a href="#" class="nav-link dropdown-toggle text-white mt-1" data-bs-toggle="dropdown">${sNickName}님</a>
		            <div class="dropdown-menu m-0 bg-secondary rounded-3">
		              <a href="${ctp}/member/memberMain" class="dropdown-item">멤버전용방</a>
		              <a href="${ctp}/shop/dbMyOrder" class="dropdown-item">주문배송현황</a>
		              <a href="${ctp}/member/memberPwdCheck/i" class="dropdown-item">회원정보수정</a>
		              <a href="${ctp}/member/memberPwdCheck/p" class="dropdown-item">비밀번호변경</a>
		              <a href="javascript:userDelCheck()" class="dropdown-item">회원탈퇴</a>
		              <c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminMain" class="dropdown-item">관리자메뉴</a></c:if>
		            </div>
		          </div>
	          </c:if>
	          <a href="${ctp}/shop/cartList" class="nav-link text-white"><i class="fa-solid fa-basket-shopping"></i></a>
	        </nav>
        </div>
      </div>
    </div>
  </div>						
  <div class="container-fluid  bg-light">
    <div class="container px-0">
      <nav class="navbar navbar-light navbar-expand-xl">
        <a href="${ctp}/main" class="navbar-brand">
          <img src="${ctp}/img/logo.png" alt="나도 자연인 로고">
        </a>
        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
          <span class="fa fa-bars text-primary"></span>
        </button>
        <div class="collapse navbar-collapse py-3" id="navbarCollapse">
          <div class="navbar-nav mx-auto border-top">
            <a href="${ctp}/pages/about" class="nav-item nav-link">사이트소개</a>
            <div class="nav-item dropdown">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">커뮤니티</a>
              <div class="dropdown-menu m-0 bg-secondary rounded-0">
                <a href="${ctp}/lineTalk/lineTalk" class="dropdown-item">한줄수다방</a>
                <a href="${ctp}/board/boardList?boardName=knowhow" class="dropdown-item">노하우공유</a>
                <a href="${ctp}/board/boardList?boardName=realty" class="dropdown-item">자연인 토지&집 매매</a>
                <a href="${ctp}/board/boardList?boardName=freeboard" class="dropdown-item">자유게시판</a>
                <a href="${ctp}/ai" class="dropdown-item">AI 약초이미지 검색</a>
              </div>
            </div>
            <div class="nav-item dropdown">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">자연인Mart <i class="fa-solid fa-store text-success"></i></a>
              <div class="dropdown-menu m-0 bg-secondary rounded-0">
                <a href="${ctp}/shop/productList?cat1=A" class="dropdown-item">생존필수템</a>
                <a href="${ctp}/shop/productList?cat1=B" class="dropdown-item">낭만템</a>
                <a href="${ctp}/shop/productList?cat1=C" class="dropdown-item">비상식량</a>
              </div>
            </div>
            <div class="nav-item dropdown">
              <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">샘플페이지</a>
              <div class="dropdown-menu m-0 bg-secondary rounded-0">
                <a href="${ctp}/pages/movie" class="dropdown-item">유튜브</a>
                <a href="${ctp}/board/mapSample" class="dropdown-item">지도페이지샘플</a>
                <a href="${ctp}/error" class="dropdown-item">404 Page</a>
              </div>
            </div>
            <%-- <a href="${ctp}/error" class="nav-item nav-link">404 Page</a> --%>
          </div>
          <div class="d-flex flex-nowrap border-top pt-3 pt-xl-0">
            <div class="d-flex rounded-pill bg-white">
              <div class="SeoulIcon ms-2 pt-1"></div>
              <div class="text-left my-2 ms-2">
                <strong class="fs-5 text-secondary"><span class="SeoulNowtemp"></span>°C</strong>
                <div class="d-flex flex-column" style="width: 130px;">
                  <span class="text-body">서울, <span class="nowtime"></span></span>
                </div>
              </div>
            </div>
            <button class="btn-search btn border border-primary btn-md-square rounded-circle bg-white my-auto" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
          </div>
        </div>
      </nav>
    </div>
  </div>
</div>
<!-- Navbar End -->


<!-- Modal Search Start -->
<div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <form action="${ctp}/board/knowhowSearch" method="post" name="knowhowSearch" id="knowhowSearch">
	  <div class="modal-dialog modal-fullscreen">
	    <div class="modal-content rounded-0">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-magnifying-glass me-1"></i>자연인 노하우 검색</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
		     	<div class="modal-body d-flex align-items-center">
		        <div class="input-group w-75 mx-auto d-flex">
			          <input type="search" name="searchStr" id="searchStr" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
			          <a href="javascript:knowhowSearch()"  class="input-group-text p-3"><i class="fa fa-search"></i></a>
		        </div>
		      </div>
	    </div>
	  </div>
  </form>
</div>
<!-- Modal Search End -->

</body>
</html>