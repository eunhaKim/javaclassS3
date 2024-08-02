<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>about.jsp</title>
</head>
<body>
<!-- 404 Start -->
<div class="container-fluid py-5">
    <div class="container py-5 text-center">
        <ol class="breadcrumb justify-content-center mb-5">
            <li class="breadcrumb-item"><a href="${ctp}/main">Home</a></li>
            <li class="breadcrumb-item"><a href="${ctp}/pages/about">사이트소개</a></li>
            <li class="breadcrumb-item active text-dark">사이트소개</li>
        </ol>
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <img src="${ctp}/img/logo.png" alt="나도 자연인 로고">
                <p class="mt-5 mb-4">가진 것 없어도 행복하다<i class="mr-1">!</i> 자연에서 찾는 나...</p>
                <p>대자연 속 힐링 여정을 담는 자연 다큐멘터리 나는 자연인이다 에서는 그들의 삶의 방식을 들여다봄으로써 자연으로 돌아가고 싶어하는 현대인들에게 힐링과 참된 행복의 의미를 전하고자 합니다.</p>
                <p class="mb-5">나는 자연인이다는 이런 프로그램이고, 저는 이런 취지의 프로그램인 나는 자연인 애청자입니다. 제가 제일 좋아하는 프로그램 관련해서 만들어 보고 싶어서 만들어 보았습니다. 모두 행복하세요<span class="text-danger">❤</span> </p>
                <a class="btn link-hover border border-primary rounded-pill py-3 px-5" href="${ctp}/main">Go Back To Home</a>
            </div>
        </div>
    </div>
</div>
<!-- 404 End -->

</body>
</html>