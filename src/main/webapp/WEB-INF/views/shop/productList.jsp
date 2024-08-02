<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productList.jsp</title>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
  	.breadcrumb a {color:#666;}
  	.productBox img { height:300px;  }
  	.productBox a {color: #666;}
  	.pName { margin: 20px 0 0; font-size:18px; font-weight: 600; color:#333; }
  	.pPrice { color: var(--bs-danger); font-weight: 600; }
  	.pDetail {word-break : keep-all;}
  	.nav-tabs .nav-link { border:1px solid #ddd !important; color:#333;}
  	.nav-tabs .nav-link:hover { background:var(--bs-warning) !important; color:#fff !important; }
  	.nav-tabs .nav-link.active { background:var(--bs-primary) !important; color:#fff !important; }
  	.tab-content {padding:20px 0; margin:0 0 40px;}
  </style>
</head>
<body>
	<!-- Single Product Start -->
	<div class="container-fluid pt-3 pb-5">
	  <div class="container py-5">
			<!-- breadcrumb S -->
			<ol class="breadcrumb justify-content-start mb-4">
		    <li class="breadcrumb-item"><i class="fa-solid fa-house mr-1"></i> <a href="${ctp}/main">Home</a></li>
		    <li class="breadcrumb-item"><a href="${ctp}/shop/productList?cat1=A">자연인Mart</a></li>
		    <li class="breadcrumb-item active text-dark"><a href="${ctp}/shop/productList?cat1=${cat1}">${category1Name}</a></li>
		  </ol>
			<!-- breadcrumb E -->
			
			
			<!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		  	<c:forEach var="cat2vo" items="${cat2Vos}">
		  		<c:if test="${cat2vo.category1Code == cat1}">
				    <li class="nav-item">
				      <a class="nav-link ${cat2vo.category2Code == cat2 ? 'active' : ''}" href="${ctp}/shop/productList?cat1=${cat1}&cat2=${cat2vo.category2Code}">${cat2vo.category2Name}</a>
				    </li>
			    </c:if>
			  </c:forEach>
		  </ul>
			<!-- Nav tabs E -->
		
		  <!-- Tab panes S -->
		  <div class="tab-content">
		  	<c:forEach var="cat2vo" items="${cat2Vos}">
			    <div id="${cat2vo.category2Name}" class="container tab-pane ${cat2vo.category2Code == cat2 ? 'active' : ''}">
			      <c:forEach var="cat3vo" items="${cat3Vos}">
				  		<c:if test="${cat3vo.category2Code == cat2vo.category2Code}">
				  			<a href="${ctp}/shop/productList?cat1=${cat1}&cat2=${cat2vo.category2Code}&cat3=${cat3vo.category3Code}" class="mr-1 btn btn-sm ${cat3vo.category3Code == cat3 ? 'btn-warning' : '' }">${cat3vo.category3Name}</a>
				  		</c:if>
				  	</c:forEach>
			    </div>
		    </c:forEach>
		    <c:if test="${cat2 != '전체'}"><hr/></c:if>
		  </div>
		  
		  <c:set var="cnt" value="0"/>
		  <!-- Tab panes E -->
	    <div class="row g-4">
    		<!-- 게시물목록 START -->
    		<c:if test="${fn:length(productVOS) == 0}"><div class="col-md-12 productBox text-center p-5"><p class=""><i class="fa-regular fa-comment"></i> 제품 준비 중입니다.</p></div></c:if>
				<c:if test="${fn:length(productVOS) != 0}">
					<c:forEach var="vo" items="${productVOS}">
			      <div class="col-md-4 productBox">
			        <div style="text-align:center" class="mt-1">
			          <a href="${ctp}/shop/productContent?idx=${vo.idx}">
			            <div class="position-relative rounded overflow-hidden border"><img src="${ctp}/product/${vo.FSName}"  class="img-zoomin img-fluid rounded w-100"/></div>
			            <p class="pName">${vo.productName}</p>
			            <p class="pPrice"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</p>
			            <p class="pDetail">${vo.detail}</p>
			          </a>
			        </div>
			      </div>
			      <c:set var="cnt" value="${cnt+1}"/>
			      <c:if test="${cnt % 3 == 0}">
			        </div>
			        <div class="row mt-5">
			      </c:if>
			    </c:forEach>
			  </c:if>
				<!-- 게시물목록 END -->
	    </div>
	  </div>
	</div>
	<!-- Single Product End -->
</body>
</html>