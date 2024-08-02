<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>movie.jsp</title>
</head>
<body>
<!-- 404 Start -->
<div class="container-fluid py-5">
    <div class="container py-5 text-center">
        <ol class="breadcrumb justify-content-center mb-5">
            <li class="breadcrumb-item"><a href="${ctp}/main">Home</a></li>
            <li class="breadcrumb-item"><a href="${ctp}/pages/about">동영상</a></li>
            <li class="breadcrumb-item active text-dark">유튜브 크롤링</li>
        </ol>
        <div class="row justify-content-center">
        		<!-- 반복 -->
        		<c:forEach var="title" items="${videoTitles}" varStatus="st" begin="0" end="7">
            <div class="col-lg-3 col-sm-6">
            	<iframe width="100%" height="215" title="${title}" src="https://www.youtube.com/embed/${videoUrls[st.index].split('&index')[0]}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
            </c:forEach>
        		<!-- 반복 -->
        </div>
        <a class="btn link-hover border border-primary rounded-pill py-3 px-5 mt-5" href="https://www.youtube.com/@Jayeonin_MBN" target="_blank">자연인유튜브 바로가기</a>
    </div>
</div>
<!-- 404 End -->

</body>
</html>