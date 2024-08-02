<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<style>
		.img-lineTalk { aspect-ratio : 1 ; object-fit: cover;}
	</style>
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
                   <p class="text-uppercase mb-2">${vo.nickName}</p>
                   <a href="#" class="h6">
                      ${fn:substring(vo.chat,0,10)}..
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
                                         <img src="img/news-1.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                         <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Sports
                                         </div>
                                     </div>
                                     <div class="my-4">
                                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</a>
                                     </div>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-clock"></i> 06 minute read</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-eye"></i> 3.5k Views</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-comment-dots"></i> 05 Comment</a>
                                         <a href="#" class="text-dark link-hover"><i class="fa fa-arrow-up"></i> 1.5k Share</a>
                                     </div>
                                     <p class="my-4">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy..
                                     </p>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Sports</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Sports</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Sports</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Sports</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-2" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                         <img src="img/news-1.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                         <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Magazine
                                         </div>
                                     </div>
                                     <div class="my-3">
                                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</a>
                                     </div>
                                     <p class="mt-4">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy..
                                     </p>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-clock"></i> 06 minute read</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-eye"></i> 3.5k Views</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-comment-dots"></i> 05 Comment</a>
                                         <a href="#" class="text-dark link-hover"><i class="fa fa-arrow-up"></i> 1.5k Share</a>
                                     </div>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Magazine</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-3" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                         <img src="img/news-1.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                         <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Politics
                                         </div>
                                     </div>
                                     <div class="my-3">
                                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</a>
                                     </div>
                                     <p class="mt-4">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy..
                                     </p>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-clock"></i> 06 minute read</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-eye"></i> 3.5k Views</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-comment-dots"></i> 05 Comment</a>
                                         <a href="#" class="text-dark link-hover"><i class="fa fa-arrow-up"></i> 1.5k Share</a>
                                     </div>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Politics</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Politics</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Politics</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Politics</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Politics</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-4" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                         <img src="img/news-1.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                         <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Technology
                                         </div>
                                     </div>
                                     <div class="my-3">
                                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of the printing and typesetting industry.</a>
                                     </div>
                                     <p class="mt-4">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy
                                     </p>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-clock"></i> 06 minute read</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-eye"></i> 3.5k Views</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-comment-dots"></i> 05 Comment</a>
                                         <a href="#" class="text-dark link-hover"><i class="fa fa-arrow-up"></i> 1.5k Share</a>
                                     </div>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Technology</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Technology</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Technology</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Technology</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Technology</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div id="tab-5" class="tab-pane fade show p-0">
                             <div class="row g-4">
                                 <div class="col-lg-8">
                                     <div class="position-relative rounded overflow-hidden">
                                         <img src="img/news-1.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                         <div class="position-absolute text-white px-4 py-2 bg-primary rounded" style="top: 20px; right: 20px;">                                              
                                             Fashion
                                         </div>
                                     </div>
                                     <div class="my-3">
                                         <a href="#" class="h4">World Happiness Report 2023: What's the highway to happiness?</a>
                                     </div>
                                     <p class="mt-4">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy Lorem Ipsum has been the industry's standard dummy
                                     </p>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-clock"></i> 06 minute read</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-eye"></i> 3.5k Views</a>
                                         <a href="#" class="text-dark link-hover me-3"><i class="fa fa-comment-dots"></i> 05 Comment</a>
                                         <a href="#" class="text-dark link-hover"><i class="fa fa-arrow-up"></i> 1.5k Share</a>
                                     </div>
                                 </div>
                                 <div class="col-lg-4">
                                     <div class="row g-4">
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Fashion</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Fashion</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Fashion</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Fashion</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                         <div class="col-12">
                                             <div class="row g-4 align-items-center">
                                                 <div class="col-5">
                                                     <div class="overflow-hidden rounded">
                                                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded w-100" alt="">
                                                     </div>
                                                 </div>
                                                 <div class="col-7">
                                                     <div class="features-content d-flex flex-column">
                                                         <p class="text-uppercase mb-2">Fashion</p>
                                                         <a href="#" class="h6">Get the best speak market, news.</a>
                                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="border-bottom mb-4">
                         <h2 class="my-4">노하우공유</h2>
                     </div>
                     <div class="whats-carousel owl-carousel">
                         <div class="latest-news-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="#" class="h4">There are many variations of passages of Lorem Ipsum available,</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">by Willium Smith</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="whats-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="#" class="h4">There are many variations of passages of Lorem Ipsum available,</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">by Willium Smith</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="whats-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="#" class="h4">There are many variations of passages of Lorem Ipsum available,</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">by Willium Smith</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="whats-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="#" class="h4">There are many variations of passages of Lorem Ipsum available,</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">by Willium Smith</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="whats-item">
                             <div class="bg-light rounded">
                                 <div class="rounded-top overflow-hidden">
                                     <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                                 </div>
                                 <div class="d-flex flex-column p-4">
                                     <a href="#" class="h4">There are many variations of passages of Lorem Ipsum available,</a>
                                     <div class="d-flex justify-content-between">
                                         <a href="#" class="small text-body link-hover">by Willium Smith</a>
                                         <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <div class="col-lg-4 col-xl-3">
                     <div class="row g-4">
                         <div class="col-12">
                             <div class="p-3 rounded border">
                                 
                                 <div class="row g-4">
                                     <div class="col-lg-12">
                                         <div class="border-bottom mb-3 pb-3">
                                             <h4 class="mb-0">Trending Tags</h4>
                                         </div>
                                         <ul class="nav nav-pills d-inline-flex text-center mb-4">
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Lifestyle</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Sports</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Politics</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Magazine</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Game</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Movie</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">Travel</span>
                                                 </a>
                                             </li>
                                             <li class="nav-item mb-3">
                                                 <a class="d-flex py-2 bg-light rounded-pill me-2" href="#">
                                                     <span class="text-dark link-hover" style="width: 90px;">World</span>
                                                 </a>
                                             </li>
                                         </ul>
                                     </div>
                                     <div class="col-lg-12 mb-5">
                                         <div class="position-relative banner-2">
                                             <img src="img/banner-2.jpg" class="img-fluid w-100 rounded" alt="">
                                             <div class="text-center banner-content-2">
                                                 <h6 class="mb-2">AI 약초 검색</h6>
                                                 <p class="text-white mb-2">teachablemachine으로 학습된 약초를 검색해보자</p>
                                                 <a href="${ctp}/ai" class="btn btn-primary text-white px-4">약초 이미지 검색</a>
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
     </div>
 </div>
 <!-- Most Populer News End -->


 


 <!-- Banner Start -->
 <div class="container-fluid py-5 my-5" style="background: linear-gradient(rgba(202, 203, 185, 1), rgba(202, 203, 185, 1));">
     <div class="container">
         <div class="row g-4 align-items-center">
             <div class="col-lg-7">
                 <h1 class="mb-4 text-primary">Newsers</h1>
                 <h1 class="mb-4">Get Every Weekly Updates</h1>
                 <p class="text-dark mb-4 pb-2">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley
                 </p>
                 <div class="position-relative mx-auto">
                     <input class="form-control w-100 py-3 rounded-pill" type="email" placeholder="Your Busines Email">
                     <button type="submit" class="btn btn-primary py-3 px-5 position-absolute rounded-pill text-white h-100" style="top: 0; right: 0;">Subscribe Now</button>
                 </div>
             </div>
             <div class="col-lg-5">
                 <div class="rounded">
                     <img src="img/banner-img.jpg" class="img-fluid rounded w-100 rounded" alt="">
                 </div>
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
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <img src="img/news-7.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of...</a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">by Willum Skeem</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <img src="img/news-6.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of...</a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">by Willum Skeem</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <img src="img/news-3.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of...</a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">by Willum Skeem</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <img src="img/news-4.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="#" class="h4">Lorem Ipsum is simply dummy text of...</a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">by Willum Skeem</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                         </div>
                     </div>
                 </div>
             </div>
             <div class="latest-news-item">
                 <div class="bg-light rounded">
                     <div class="rounded-top overflow-hidden">
                         <img src="img/news-5.jpg" class="img-zoomin img-fluid rounded-top w-100" alt="">
                     </div>
                     <div class="d-flex flex-column p-4">
                         <a href="#" class="h4 ">Lorem Ipsum is simply dummy text of...</a>
                         <div class="d-flex justify-content-between">
                             <a href="#" class="small text-body link-hover">by Willum Skeem</a>
                             <small class="text-body d-block"><i class="fas fa-calendar-alt me-1"></i> Dec 9, 2024</small>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>
 <!-- Latest News End -->

 
 
</body>
</html>