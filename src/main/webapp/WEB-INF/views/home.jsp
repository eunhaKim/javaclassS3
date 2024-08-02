<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
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
		$(()=>{
			wordCheck();
		});
		
		function wordCheck() {
	   	let url = "http://localhost:9090/javaclassS3/";
	   	let selector = "a.h4";
	   	// let url = "https://news.naver.com";
    	// let selector = "div.cjs_t";
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
	   			$("#demo").html(res);
	   		},
	   		error : function() {
	   			alert("전송오류~");
	   		}
	   	});
	   }
	</script>
</head>
<body>
<!-- lineTalk 최근 4개 Start -->
	<div class="container-fluid features mb-5">
		<div class="container py-5">
	    <div class="row g-4">
    		<!-- 반복문 S -->
    		<c:forEach var="vo" items="${LineTalkVOS}" varStatus="st">
        	<div class="col-md-6 col-lg-6 col-xl-3">
             <div class="row g-4 align-items-center features-item">
               <div class="col-4">
                 <div class="rounded-circle position-relative">
                   <div class="overflow-hidden rounded-circle">
                     <img src="${ctp}/resources/data/member/${vo.photo}" alt="${vo.nickName} 회원이미지" class="img-lineTalk img-zoomin img-fluid rounded-circle w-100" />
                   </div>
                   <span class="rounded-circle border border-2 border-white bg-primary btn-sm-square text-white position-absolute" style="top: 10%; right: -10px;">${vo.level}</span>
                 </div>
               </div>
               <div class="col-8">
                 <div class="features-content d-flex flex-column">
                   <p class="text-uppercase mb-2 text-warning">${vo.nickName}</p>
                   <a href="${ctp}/lineTalk/lineTalk" class="h6">
                      ${fn:substring(vo.chat,0,10)}
                      ${vo.chat.length() > 10 ? " .." : "" }
                   </a>
                   <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> ${fn:substring(vo.WDate,0,16)}</small>
                 </div>
               </div>
             </div>
	         </div>
	      </c:forEach>
	    	<!-- 반복문 E -->
	    </div>
		</div>
	</div>
	<!-- lineTalk 최근 4개 End -->
 
 <!-- 자연인 Mart Start -->
 <div class="container-fluid populer-news">
     <div class="container py-5">
         <div class="tab-class mb-4">
             <div class="row g-4">
                 <div class="col-lg-8 col-xl-9">
                     <div class="d-flex flex-column flex-md-row justify-content-md-between border-bottom mb-4">
                         <h1 class="mb-4">자연인 Mart</h1>
                         <ul class="nav nav-pills d-inline-flex text-center">
                             <li class="nav-item mb-3">
                                 <a class="d-flex py-2 bg-light rounded-pill active me-2" data-bs-toggle="pill" href="#tab-1">
                                     <span class="text-dark" style="width: 100px;">생존필수템</span>
                                 </a>
                             </li>
                             <li class="nav-item mb-3">
                                 <a class="d-flex py-2 bg-light rounded-pill me-2" data-bs-toggle="pill" href="#tab-2">
                                     <span class="text-dark" style="width: 100px;">낭만템</span>
                                 </a>
                             </li>
                             <li class="nav-item mb-3">
                                 <a class="d-flex py-2 bg-light rounded-pill me-2" data-bs-toggle="pill" href="#tab-3">
                                     <span class="text-dark" style="width: 100px;">비상식량</span>
                                 </a>
                             </li>
                         </ul>
                     </div>
                     <div class="tab-content mb-4">
                         <div id="tab-1" class="tab-pane fade show p-0 active">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                       <a href="${ctp}/shop/productContent?idx=${productCatAVOS[0].idx}">
                                         <img src="${ctp}/product/${productCatAVOS[0].FSName}" class="img-zoomin img-fluid rounded w-100 h-300" alt="">
                                         <!-- <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Sports
                                         </div> -->
                                       </a>
                                     </div>
                                     <div class="mt-4">
                                         <a href="${ctp}/shop/productContent?idx=${productCatAVOS[0].idx}" class="h4">${productCatAVOS[0].productName}</a>
                                     </div>
                                     <div class="text-danger mt-3">
                                         <i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${productCatAVOS[0].mainPrice}" />원
                                     </div>
                                     <p class="mt-3 mb-5">${productCatAVOS[0].detail}</p>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                     		<!-- 반복 -->
                                     		<c:forEach var="vo" items="${productCatAVOS}" begin="1" end="6">
	                                        <div class="col-12">
	                                             <div class="row g-4 align-items-center">
	                                                 <div class="col-5">
	                                                     <div class="overflow-hidden rounded">
	                                                       <a href="${ctp}/shop/productContent?idx=${vo.idx}">
	                                                         <img src="${ctp}/product/${vo.FSName}" class="img-zoomin img-fluid rounded w-100 h-80" alt="${vo.productName}">
	                                                       </a>
	                                                     </div>
	                                                 </div>
	                                                 <div class="col-7">
	                                                     <div class="features-content d-flex flex-column">
	                                                         <p class="text-uppercase mb-2"><a href="${ctp}/shop/productContent?idx=${vo.idx}">${fn:substring(vo.productName,0,8)}${vo.productName.length() > 8 ? ".." : "" }</a></p>
	                                                         <a href="${ctp}/shop/productContent?idx=${vo.idx}" class="h6">${fn:substring(vo.detail,0,10)}${vo.detail.length() > 10 ? " .." : "" }</a>
	                                                         <small class="text-body d-block"><i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${vo.mainPrice}" />원</small>
	                                                     </div>
	                                                 </div>
	                                             </div>
	                                         </div>
                                         </c:forEach>
                                         <!-- 반복 -->
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-2" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                       <a href="${ctp}/shop/productContent?idx=${productCatBVOS[0].idx}">
                                         <img src="${ctp}/product/${productCatBVOS[0].FSName}" class="img-zoomin img-fluid rounded w-100 h-300" alt="">
                                         <!-- <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Sports
                                         </div> -->
                                       </a>
                                     </div>
                                     <div class="mt-4">
                                         <a href="${ctp}/shop/productContent?idx=${productCatBVOS[0].idx}" class="h4">${productCatBVOS[0].productName}</a>
                                     </div>
                                     <div class="text-danger mt-3">
                                         <i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${productCatBVOS[0].mainPrice}" />원
                                     </div>
                                     <p class="mt-3 mb-5">${productCatBVOS[0].detail}</p>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                     		<!-- 반복 -->
                                     		<c:forEach var="vo" items="${productCatBVOS}" begin="1" end="6">
	                                        <div class="col-12">
	                                             <div class="row g-4 align-items-center">
	                                                 <div class="col-5">
	                                                     <div class="overflow-hidden rounded">
	                                                       <a href="${ctp}/shop/productContent?idx=${vo.idx}">
	                                                         <img src="${ctp}/product/${vo.FSName}" class="img-zoomin img-fluid rounded w-100 h-80" alt="${vo.productName}">
	                                                       </a>
	                                                     </div>
	                                                 </div>
	                                                 <div class="col-7">
	                                                     <div class="features-content d-flex flex-column">
	                                                         <p class="text-uppercase mb-2"><a href="${ctp}/shop/productContent?idx=${vo.idx}">${fn:substring(vo.productName,0,8)}${vo.productName.length() > 8 ? ".." : "" }</a></p>
	                                                         <a href="${ctp}/shop/productContent?idx=${vo.idx}" class="h6">${fn:substring(vo.detail,0,10)}${vo.detail.length() > 10 ? " .." : "" }</a>
	                                                         <small class="text-body d-block"><i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${vo.mainPrice}" />원</small>
	                                                     </div>
	                                                 </div>
	                                             </div>
	                                         </div>
                                         </c:forEach>
                                         <!-- 반복 -->
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-3" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                       <a href="${ctp}/shop/productContent?idx=${productCatCVOS[0].idx}">
                                         <img src="${ctp}/product/${productCatCVOS[0].FSName}" class="img-zoomin img-fluid rounded w-100 h-300" alt="">
                                         <!-- <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Sports
                                         </div> -->
                                       </a>
                                     </div>
                                     <div class="mt-4">
                                         <a href="${ctp}/shop/productContent?idx=${productCatCVOS[0].idx}" class="h4">${productCatCVOS[0].productName}</a>
                                     </div>
                                     <div class="text-danger mt-3">
                                         <i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${productCatCVOS[0].mainPrice}" />원
                                     </div>
                                     <p class="mt-3 mb-5">${productCatCVOS[0].detail}</p>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                     		<!-- 반복 -->
                                     		<c:forEach var="vo" items="${productCatCVOS}" begin="1" end="6">
	                                        <div class="col-12">
	                                             <div class="row g-4 align-items-center">
	                                                 <div class="col-5">
	                                                     <div class="overflow-hidden rounded">
	                                                       <a href="${ctp}/shop/productContent?idx=${vo.idx}">
	                                                         <img src="${ctp}/product/${vo.FSName}" class="img-zoomin img-fluid rounded w-100 h-80" alt="${vo.productName}">
	                                                       </a>
	                                                     </div>
	                                                 </div>
	                                                 <div class="col-7">
	                                                     <div class="features-content d-flex flex-column">
	                                                         <p class="text-uppercase mb-2"><a href="${ctp}/shop/productContent?idx=${vo.idx}">${fn:substring(vo.productName,0,8)}${vo.productName.length() > 8 ? ".." : "" }</a></p>
	                                                         <a href="${ctp}/shop/productContent?idx=${vo.idx}" class="h6">${fn:substring(vo.detail,0,10)}${vo.detail.length() > 10 ? " .." : "" }</a>
	                                                         <small class="text-body d-block"><i class="fa-solid fa-won-sign ms-1"></i> <fmt:formatNumber value="${vo.mainPrice}" />원</small>
	                                                     </div>
	                                                 </div>
	                                             </div>
	                                         </div>
                                         </c:forEach>
                                         <!-- 반복 -->
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="border-bottom mb-4">
                         <h2 class="my-4">노하우공유</h2>
                     </div>
                     <div class="whats-carousel owl-carousel">
                     		 <!-- 반복 -->
                     		 <c:forEach var="vo" items="${knowhowVOS}" varStatus="st">
                         <div class="whats-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <!-- 리스트이미지 START -->
													            <a href="${ctp}/board/boardContent?boardName=knowhow&idx=${vo.idx}">
												              	<div class="rounded-top overflow-hidden knowhowMainImg">
														              <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
														              <c:if test="${empty fSNames[0]}">
														              	<img src="${ctp}/boardImg/Listlogo.jpg" alt="리스트이미지">
														              </c:if>
														              <c:if test="${!empty fSNames[0]}">
														              	<img src="${ctp}/boardImg/${fSNames[0]}" class="img-zoomin img-fluid w-100" alt="리스트이미지">
														              </c:if>
												              	</div>
													            </a>
													            <!-- 리스트이미지 END -->
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="${ctp}/board/boardContent?boardName=knowhow&idx=${vo.idx}" class="h4">${fn:substring(vo.title,0,20)}${vo.title.length() > 20 ? " .." : "" }</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">${vo.nickName}</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> ${fn:substring(vo.WDate,0,16)}</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         </c:forEach>
		                     <!-- 반복 -->
                     </div>
                 </div>
                 <div class="col-lg-4 col-xl-3">
                     <div class="row g-4">
                         <div class="col-12">
                             <div class="p-3 rounded border">
                                 
                                 <div class="row g-4">
                                     <div class="col-lg-12 mb-3">
                                         <div class="position-relative banner-2">
                                             <img src="img/banner-2.jpg" class="img-fluid w-100 rounded" alt="">
                                             <div class="text-center banner-content-2">
                                                 <h4 class="mb-2 text-white">AI 약초 검색</h4>
                                                 <p class="text-dark mb-2">teachablemachine으로 학습된 약초를 검색해보자</p>
                                                 <a href="${ctp}/ai" class="btn btn-primary text-white px-4">약초 이미지 검색</a>
                                             </div>
                                         </div>
                                     </div>
                                     <div class="col-lg-12 mb-5">
                                         <div class="border-bottom mb-3 pb-3">
                                             <h4 class="mb-0">Trending Tags</h4>
                                         </div>
                                         <ul class="trandingTags" id="demo"></ul>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>
 <!-- Most Populer News End -->


 


 <!-- Banner Start -->
 <div class="container-fluid py-5 my-5" style="background: linear-gradient(rgba(202, 203, 185, 1), rgba(202, 203, 185, 1));">
     <div class="container">
         <div class="row g-4 align-items-center">
             <div class="col-lg-7">
                 <h6 class="mb-4 text-danger">https://www.youtube.com/@Jayeonin_MBN</h6>
                 <h1 class="mb-4">나는 자연인이다</h1>
                 <p class="text-dark mb-4 pb-2">가진 것 없어도 행복하다!  자연에서 찾는 나...<br/>대자연 속 힐링 여정을 담는 자연 다큐멘터리 나는 자연인이다 에서는 그들의 삶의 방식을 들여다봄으로써 자연으로 돌아가고 싶어하는 현대인들에게 힐링과 참된 행복의 의미를 전하고자 합니다.</p>
                 <div class="position-relative mx-auto">
                     <a href="${ctp}/pages/movie" class="btn btn-danger">나는 자연인 유튜브 크롤링</a>
                 </div>
             </div>
             <div class="col-lg-5">
               <iframe width="100%" height="320px" src="https://www.youtube.com/embed/VSBGzPl19ko" title="유튜브 비디오" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
             </div>
         </div>
     </div>
 </div>
 <!-- Banner End -->


 <!-- Latest News Start -->
 <div class="container-fluid latest-news mb-5">
     <div class="container py-5">
         <h2 class="mb-4">자연인 토지&집 매매</h2>
         <div class="latest-news-carousel owl-carousel">
             <!-- 반복 -->
         		 <c:forEach var="vo" items="${realtyVOS}" varStatus="st">
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <!-- 리스트이미지 START -->
							            <a href="${ctp}/board/boardContent?boardName=realty&idx=${vo.idx}">
						              	<div class="rounded-top overflow-hidden knowhowMainImg">
								              <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
								              <c:if test="${empty fSNames[0]}">
								              	<img src="${ctp}/boardImg/Listlogo.jpg" alt="리스트이미지">
								              </c:if>
								              <c:if test="${!empty fSNames[0]}">
								              	<img src="${ctp}/boardImg/${fSNames[0]}" class="img-zoomin img-fluid w-100" alt="리스트이미지">
								              </c:if>
						              	</div>
							            </a>
							            <!-- 리스트이미지 END -->
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="${ctp}/board/boardContent?boardName=realty&idx=${vo.idx}" class="h4">
                         		${fn:substring(vo.title,0,10)}
                         		${vo.title.length() > 10 ? ".." : "" }
                         </a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">${vo.nickName}</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> ${fn:substring(vo.WDate,0,16)}</small>
                         </div>
                     </div>
                 </div>
             </div>
             </c:forEach>
             <!-- 반복 -->
         </div>
     </div>
 </div>
 <!-- Latest News End -->

 
 
</body>
</html>