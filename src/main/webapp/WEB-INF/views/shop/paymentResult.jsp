<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentResutl.jsp</title>
	
  <script>
	</script>
  <style>
  	.breadcrumb a { color:#666;}
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
		    <li class="breadcrumb-item active text-dark"><a href="${ctp}/shop/cartList">주문</a></li>
		  </ol>
			<!-- breadcrumb E -->
			
			
			
	    <div class="g-4 orderBox">
    		<!-- 게시물목록 START -->
    		<h2>결제내역</h2>
    		<hr/>
			  <p>주문 물품명 : ${sPayMentVO.name}</p>
			  <p>주문금액 : ${sPayMentVO.amount}(실제구매금액:${orderTotalPrice})</p>
			  <p>주문자 메일주소 : ${sPayMentVO.buyer_email}</p>
			  <p>주문자 성명 : ${sPayMentVO.buyer_name}</p>
			  <p>주문자 전화번호 : ${sPayMentVO.buyer_tel}</p>
			  <p>주문자 주소 : ${sPayMentVO.buyer_addr}</p>
			  <p>주문자 우편번호 : ${sPayMentVO.buyer_postcode}</p>
			  <p>결제 고유ID : ${sPayMentVO.imp_uid}</p>
			  <p>결제 상점 거래 ID : ${sPayMentVO.merchant_uid}</p>
			  <p>결제 금액 : ${sPayMentVO.paid_amount}</p>
			  <p>카드 승인번호 : ${sPayMentVO.apply_num}</p>
			  <hr/>
			  <h2 class="text-center">주문완료</h2>
			  <hr/>
			  <table class="table table-bordered">
			    <tr style="text-align:center;background-color:#ccc;">
			      <th>상품이미지</th>
			      <th>주문일시</th>
			      <th>주문내역</th>
			      <th>비고</th>
			    </tr>
			    <c:forEach var="vo" items="${orderVOS}">
			      <tr>
			        <td style="text-align:center;">
			          <img src="${ctp}/product/${vo.thumbImg}" width="100px"/>
			        </td>
			        <td style="text-align:center;"><br/>
			          <p>주문번호 : ${vo.orderIdx}</p>
			          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
			          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
			        </td>
			        <td align="left">
				        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
				        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
				        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
				        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
				        <p>
				          - 주문 내역
				          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
				          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
				            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
				          </c:forEach> 
				        </p>
				      </td>
			        <td style="text-align:center;"><br/><font color="blue">결제완료</font><br/>(배송준비중)</td>
			      </tr>
			    </c:forEach>
			  </table>
			  <hr/>
			  <div class="text-center">
			    구매한 상품 총 금액(배송비포함) : <fmt:formatNumber value="${totalBaesongOrder}"/>원
			  </div>
			  <hr/>
			  <p class="text-center">
			    <a href="${ctp}/shop/productList" class="btn btn-success">계속쇼핑하기</a> &nbsp;
			    <a href="${ctp}/shop/dbMyOrder" class="btn btn-primary">구매내역보기</a>
			  </p>
				<!-- 게시물목록 END -->
	    </div>
	  </div>
	</div>
	<!-- Single Product End -->
</body>
</html>