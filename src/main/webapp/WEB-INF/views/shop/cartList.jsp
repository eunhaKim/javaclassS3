<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>cartList.jsp</title>
  <script>
    'use strict';
    
    // 주문할 총 가격 계산하기
    function onTotal(){
      let total = 0;
      let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){  	// 장바구니에 들어있는 체크된 항목만을 총계를 구한다.
          total = total + parseInt(document.getElementById("totalPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      
      // 배송비결정(5000원 이상이면 배송비는 0원으로 처리)
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=3000;	// 배송비 3000원처리
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);
    }

		// 상품 체크박스에 상품을 구매하기위해 체크했을때 처리하는 함수
    function onCheck(){
      let minIdx = parseInt(document.getElementById("minIdx").value);				// 출력되어있는 상품중에서 가장 작은 idx값이 minIdx변수에 저장된다.
      let maxIdx = parseInt(document.getElementById("maxIdx").value);				// 출력되어있는 상품중에서 가장 큰  idx값이 maxIdx변수에 저장된다.
      
      // 상품 주문을 위한 체크박스에 체크가 되어있는것에 대한 처리루틴이다.
      // 상품주문 체크박스가 체크되어 있지 않은것에 대한 개수를 emptyCnt에 누적처리하고 있다. 즉, emptyCnt가 0이면 모든 상품이 체크되어 있다는 것으로 '전체체크버튼'을 true로 처리해준다.
      let emptyCnt=0;
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
          emptyCnt++;
          break;
        }
      }
      if(emptyCnt!=0){
        document.getElementById("allcheck").checked=false;
      } 
      else {
        document.getElementById("allcheck").checked=true;
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// allCheck 체크박스를 체크/해제할때 수행하는 함수
    function allCheck(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      if(document.getElementById("allcheck").checked){
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=true;
          }
        }
      }
      else {
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0){
            document.getElementById("idx"+i).checked=false;
          }
        }
      }
      onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
    }
    
		// 장바구니에서 선택한 상품에 대한 '삭제'처리...
    function cartDelete(idx){
      let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/shop/dbCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }
    
		// 장바구니에서 선택한 상품만 '주문'처리하기
    function order(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){	// 해당 상품이 존재하면서, 구배한다고 체크가 되어있다면...
          document.getElementById("checkItem"+i).value="1";		// 주문을 선택한상품은 'checkItem고유번호'의 값을 1로 셋팅한다.
        }
      }

      document.myform.baesong.value = document.getElementById("baesong").value;		// 배송비
      
      // 장바구니에서 주문품목을 선택하지 않았을때는 메세지 띄우고 다시 장바구니창으로, 주문품목 선택시는 '배송지 입력'창으로 보내준다.
      if(document.getElementById("lastPrice").value==0){
        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
    
		// 천단위마다 쉼표처리
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
  </script>
  <style>
  	.breadcrumb a { color:#666;}
  	.cartList { text-align:left; }
  	.cartList .row{margin:0; padding:0;}
  	.cartList p { margin-bottom:0 ; line-height: 1}
  	.cartList ul { margin:5px 0 0; padding:0; list-style: none;}
  	.cartList a { color: #666;}
  	.cartList img { max-width: 100%; margin-bottom:10px;}
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
		    <li class="breadcrumb-item active text-dark"><a href="${ctp}/shop/cartList">장바구니</a></li>
		  </ol>
			<!-- breadcrumb E -->
			
			
			
	    <div class="row g-4 cartList">
    		<!-- 게시물목록 START -->
    		<h2>장바구니</h2>
				<form name="myform" method="post" class="border-bottom">
					<div class="mb-2"><input type="checkbox" id="allcheck" onClick="allCheck()" /> 전체선택</div>
					<!-- 장바구니 목록출력 -->
				  <c:forEach var="listVO" items="${cartListVOS}">
						<div>
							<div class="d-flex border-top pt-3">
								<div>
									<input type="checkbox" name="idxChecked" id="idx${listVO.idx}" value="${listVO.idx}" onClick="onCheck()" />
									<a href="${ctp}/shop/productContent?idx=${listVO.productIdx}">${listVO.productName}</a>
								</div>
								<div class="ml-auto">
									<button type="button" onClick="cartDelete(${listVO.idx})" class="btn text-danger btn-sm ml-auto" title="장바구니에서 삭제">X</button>
								</div>
							</div>
							<div class="row mt-3">
								<div class="col-lg-1 col-sm-2 col-xs-12 position-relative rounded overflow-hidden"><a href="${ctp}/shop/productContent?idx=${listVO.productIdx}"><img src="${ctp}/product/${listVO.thumbImg}"  class="img-zoomin img-fluid rounded w-100"/></a></div>
								<div class="col-lg-11 col-sm-10 col-xs-12">
									<%-- <p><span class=""><fmt:formatNumber value="${listVO.mainPrice}"/></span>원</p> --%>
									<c:set var="optionNames" value="${fn:split(listVO.optionName,',')}"/>
					        <c:set var="optionPrices" value="${fn:split(listVO.optionPrice,',')}"/>
					        <c:set var="optionNums" value="${fn:split(listVO.optionNum,',')}"/>
					        <div>
					          <p class="text-dark"><b>주문 선택 내역 :</b></p> 
					          <c:if test="${fn:length(optionNames) > 1}"><p class="mt-3">(기타품목 ${fn:length(optionNames)-1}개 포함)</p></c:if>
					          <ul>
						          <c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
						            <li> - ${optionNames[i]} / <fmt:formatNumber value="${optionPrices[i]}"/>원 / ${optionNums[i]}개</li>
						          </c:forEach> 
						        </ul>
					        </div>
					        <p class="text-danger mt-2"></b>총 : <b><fmt:formatNumber value="${listVO.totalPrice}" pattern='#,###,###'/></b>원</p>
								</div>
								<input type="hidden" id="totalPrice${listVO.idx}" value="${listVO.totalPrice}"/>
								<input type="hidden" name="checkItem" value="0" id="checkItem${listVO.idx}"/>	<!-- 구매체크가 되지 않은 품목은 '0'으로, 체크된것은 '1'로 처리하고자 한다. -->
				        <input type="hidden" name="idx" value="${listVO.idx }"/>
				        <input type="hidden" name="thumbImg" value="${listVO.thumbImg}"/>
				        <input type="hidden" name="productName" value="${listVO.productName}"/>
				        <input type="hidden" name="mainPrice" value="${listVO.mainPrice}"/>
				        <input type="hidden" name="optionName" value="${optionNames}"/>
				        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
				        <input type="hidden" name="optionNum" value="${optionNums}"/>
				        <input type="hidden" name="totalPrice" value="${listVO.totalPrice}"/>
				        <input type="hidden" name="mid" value="${sMid}"/>
							</div>
							<p class="text-secondary mt-3 small mb-3"><i class="fa-regular fa-calendar-minus"></i> 장바구니 추가일자 : ${fn:substring(listVO.cartDate,0,10)}</p>
						</div>
					</c:forEach>
				  <c:set var="minIdx" value="${cartListVOS[0].idx}"/>						<!-- 구매한 첫번째 상품의 idx -->
				  <c:set var="maxSize" value="${fn:length(cartListVOS)-1}"/>		
				  <c:set var="maxIdx" value="${cartListVOS[maxSize].idx}"/>			<!-- 구매한 마지막 상품의 idx -->
				  <input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
				  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
				  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
			    <input type="hidden" name="baesong"/>
				</form>
			  <div class="text-center my-5">
			  	<h3>실제 주문총금액</h3>
			    (구매하실 상품에 체크해 주세요. 총주문금액이 산출됩니다.)<br/>
			    5만원 이상 구매하시면 배송비가 면제됩니다.
			  </div>
				<table class="table-borderless text-center" style="margin:auto">
				  <tr>
				    <th>구매상품금액</th>
				    <th></th>
				    <th>배송비</th>
				    <th></th>
				    <th>총주문금액</th>
				  </tr>
				  <tr>
				    <td><input type="text" id="total" value="0" class="totSubBox" readonly/></td>
				    <td>+</td>
				    <td><input type="text" id="baesong" value="0" class="totSubBox" readonly/></td>
				    <td>=</td>
				    <td><input type="text" id="lastPrice" value="0" class="totSubBox" readonly/></td>
				  </tr>
				</table>
				<br/>
				<div class="text-center">
				  <button class="btn btn-primary" onClick="order()">주문하기</button> &nbsp;
				  <button class="btn btn-secondary" onClick="location.href='${ctp}/shop/productList';">계속 쇼핑하기</button>
				</div>
				<!-- 게시물목록 END -->
	    </div>
	  </div>
	</div>
	<!-- Single Product End -->
</body>
</html>