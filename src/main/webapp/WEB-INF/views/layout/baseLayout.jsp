<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>나도자연인 - 꿈은★이루어진다</title>
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <meta content="" name="keywords">
  <meta content="" name="description">
        
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  
</head>
<body>
<tiles:insertAttribute name="header" />
<tiles:insertAttribute name="nav" />

<div class="bodyCenter">
  <tiles:insertAttribute name="body" />
</div>

<div class="footer">
  <tiles:insertAttribute name="footer" />
</div>
</body>
</html>