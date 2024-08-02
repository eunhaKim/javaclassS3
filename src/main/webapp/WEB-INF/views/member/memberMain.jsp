<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMain.jsp</title>
  <script>
  'use strict';
  
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
      <li class="breadcrumb-item active text-dark">회원전용방</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
			<h2>회원전용방</h2>
    	<p>환영합니다.</p>
		</div>
	</div>
</div>
</body>
</html>