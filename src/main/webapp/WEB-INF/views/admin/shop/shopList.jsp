<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>shopList.jsp</title>
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
	  <h1 class="h3 mb-2 text-gray-800">상품리스트</h1>
	
	  <!-- DataTales Example -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<a href="${ctp}/admin/shop/shopList" class="btn btn-sm btn-primary mb-1">전체보기</a>
			  <c:forEach var="cat3Title" items="${cat3TitleVOS}" varStatus="st">
			  	<a href="${ctp}/admin/shop/shopList?part=${cat3Title.category3Name}" class="btn btn-sm btn-secondary mb-1">${cat3Title.category3Name}</a>
				  <%-- <c:if test="${!st.last}"> / </c:if> --%>
			  </c:forEach>
      	<hr/>
				<div class="row">
			    <div class="col pt-3">
				    <h6 class="m-0 font-weight-bold text-primary">${part} 상품 리스트</h6>
			    </div>
			    <div class="col text-right">
					  <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/admin/shop/product';">상품등록</button>
			    </div>
			  </div>
      </div>
      <div class="card-body">
        <div class="productList">
        	<c:forEach var="vo" items="${productVOS}">
			      <div class="productBox">
		          <a href="${ctp}/admin/shop/shopContent?idx=${vo.idx}">
				        <div style="text-align:center" class="mt-1 row">
			            <div class="col-lg-1 productImg"><img src="${ctp}/product/${vo.FSName}"/></div>
			            <div class="col-lg-4 productName">${fn:substring(vo.productName,0,10)}${fn:length(vo.productName)>10 ? ".." : ""}</div>
			            <div class="col-lg-2 productPrice"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</div>
			            <div class="col-lg-5 productDetail">${fn:substring(vo.detail,0,16)}${fn:length(vo.detail)>16 ? ".." : ""}</div>
				        </div>
		          </a>
			      </div>
			      <c:set var="cnt" value="${cnt+1}"/>
			    </c:forEach>
        </div>
      </div>
	  </div>

  </div>
  <!-- /.container-fluid -->

</body>
</html>