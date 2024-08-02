<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나도자연인 - 관리자페이지</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
  <!-- Custom styles for this template-->
  <link href="${ctp}/css/sb-admin-2.css" rel="stylesheet">
  <link href="${ctp}/css/sb-admin-2.min.css" rel="stylesheet">
  <!-- Custom fonts for this template-->
  <link href="${ctp}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link
      href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">
  <!-- Icon Font Stylesheet -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
	<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script><!-- https://www.angularjswiki.com/fontawesome/cdn/ -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	  
</head>
<body>
<tiles:insertAttribute name="header2" />
<tiles:insertAttribute name="nav2" />

<div class="bodyCenter">
  <tiles:insertAttribute name="body2" />
</div>

<div class="footer">
  <tiles:insertAttribute name="footer2" />
</div>
</body>
</html>