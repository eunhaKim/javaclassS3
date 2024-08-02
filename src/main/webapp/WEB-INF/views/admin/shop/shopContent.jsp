<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shopContent.jsp</title>
<style>
	.productList div{ text-align: left; line-height: 1.4 }
	.productBox { padding-bottom:5px ; margin-bottom: 10px; border-bottom: 1px dotted #ddd;}
	.productImg img { width:100% ; border-radius: 10px; }
	.productName { color:#666; padding-top:5px;}
	.productPrice { padding-top:5px; }
	.productDetail { color:#666; padding-top:5px; }
</style>
</head>
<body>
	<!-- Begin Page Content -->
  <div class="container-fluid">

	  <!-- Page Heading -->
	  <h1 class="h3 mb-2 text-gray-800">상품상세페이지</h1>
	
	  <!-- DataTales Example -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">${pVo.productName}</h6>
      </div>
      <div class="card-body">
        <div class="productList">
        </div>
      </div>
	  </div>

  </div>
  <!-- /.container-fluid -->

</body>
</html>