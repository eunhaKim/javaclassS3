<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
  <script>
		var IMP = window.IMP; 
    IMP.init("imp30131365");
		
		IMP.request_pay({
		    pg : 'html5_inicis.INIpayTest',
		    pay_method : 'card',
		    merchant_uid : 'javaclassS3_' + new Date().getTime(),
		    name : '${payMentVO.name}',
		    amount : ${payMentVO.amount},
		    buyer_email : '${payMentVO.buyer_email}',
		    buyer_name : '${payMentVO.buyer_name}',
		    buyer_tel : '${payMentVO.buyer_tel}',
		    buyer_addr : '${payMentVO.buyer_addr}',
		    buyer_postcode : '${payMentVO.buyer_postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '\n고유ID : ' + rsp.imp_uid;
		        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		        msg += '\n결제 금액 : ' + rsp.paid_amount;
		        msg += '\n카드 승인번호 : ' + rsp.apply_num;
		        paySw = 'ok';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		    if(paySw == 'no') {
			    alert("다시 주문구매창으로 이동합니다.");
		    	location.href='${ctp}/shop/productList';
		    }
		    else {
					var temp = "";
					temp += '?name=${payMentVO.name}';
					temp += '&amount=${payMentVO.amount}';
					temp += '&buyer_email=${payMentVO.buyer_email}';
					temp += '&buyer_name=${payMentVO.buyer_name}';
					temp += '&buyer_tel=${payMentVO.buyer_tel}';
					temp += '&buyer_addr=${payMentVO.buyer_addr}';
					temp += '&buyer_postcode=${payMentVO.buyer_postcode}';
					temp += '&imp_uid=' + rsp.imp_uid;
					temp += '&merchant_uid=' + rsp.merchant_uid;
					temp += '&paid_amount=' + rsp.paid_amount;
					temp += '&apply_num=' + rsp.apply_num;
					
					location.href='${ctp}/shop/paymentResult'+temp;
		    }
		});
		
	</script>
  <style>
  	.breadcrumb a { color:#666;}
  	.sk-circle {
		  margin: 20px auto;
		  width: 40px;
		  height: 40px;
		  position: relative;
		}
		.sk-circle .sk-child {
		  width: 100%;
		  height: 100%;
		  position: absolute;
		  left: 0;
		  top: 0;
		}
		.sk-circle .sk-child:before {
		  content: '';
		  display: block;
		  margin: 0 auto;
		  width: 15%;
		  height: 15%;
		  background-color: red;
		  border-radius: 100%;
		  -webkit-animation: sk-circleBounceDelay 0.5s infinite ease-in-out both;
		          animation: sk-circleBounceDelay 1.2s infinite ease-in-out both;
		}
		.sk-circle .sk-circle2 {
		  -webkit-transform: rotate(30deg);
		      -ms-transform: rotate(30deg);
		          transform: rotate(30deg); }
		.sk-circle .sk-circle3 {
		  -webkit-transform: rotate(60deg);
		      -ms-transform: rotate(60deg);
		          transform: rotate(60deg); }
		.sk-circle .sk-circle4 {
		  -webkit-transform: rotate(90deg);
		      -ms-transform: rotate(90deg);
		          transform: rotate(90deg); }
		.sk-circle .sk-circle5 {
		  -webkit-transform: rotate(120deg);
		      -ms-transform: rotate(120deg);
		          transform: rotate(120deg); }
		.sk-circle .sk-circle6 {
		  -webkit-transform: rotate(150deg);
		      -ms-transform: rotate(150deg);
		          transform: rotate(150deg); }
		.sk-circle .sk-circle7 {
		  -webkit-transform: rotate(180deg);
		      -ms-transform: rotate(180deg);
		          transform: rotate(180deg); }
		.sk-circle .sk-circle8 {
		  -webkit-transform: rotate(210deg);
		      -ms-transform: rotate(210deg);
		          transform: rotate(210deg); }
		.sk-circle .sk-circle9 {
		  -webkit-transform: rotate(240deg);
		      -ms-transform: rotate(240deg);
		          transform: rotate(240deg); }
		.sk-circle .sk-circle10 {
		  -webkit-transform: rotate(270deg);
		      -ms-transform: rotate(270deg);
		          transform: rotate(270deg); }
		.sk-circle .sk-circle11 {
		  -webkit-transform: rotate(300deg);
		      -ms-transform: rotate(300deg);
		          transform: rotate(300deg); }
		.sk-circle .sk-circle12 {
		  -webkit-transform: rotate(330deg);
		      -ms-transform: rotate(330deg);
		          transform: rotate(330deg); }
		.sk-circle .sk-circle2:before {
		  -webkit-animation-delay: -1.1s;
		          animation-delay: -1.1s; }
		.sk-circle .sk-circle3:before {
		  -webkit-animation-delay: -1s;
		          animation-delay: -1s; }
		.sk-circle .sk-circle4:before {
		  -webkit-animation-delay: -0.9s;
		          animation-delay: -0.9s; }
		.sk-circle .sk-circle5:before {
		  -webkit-animation-delay: -0.8s;
		          animation-delay: -0.8s; }
		.sk-circle .sk-circle6:before {
		  -webkit-animation-delay: -0.7s;
		          animation-delay: -0.7s; }
		.sk-circle .sk-circle7:before {
		  -webkit-animation-delay: -0.6s;
		          animation-delay: -0.6s; }
		.sk-circle .sk-circle8:before {
		  -webkit-animation-delay: -0.5s;
		          animation-delay: -0.5s; }
		.sk-circle .sk-circle9:before {
		  -webkit-animation-delay: -0.4s;
		          animation-delay: -0.4s; }
		.sk-circle .sk-circle10:before {
		  -webkit-animation-delay: -0.3s;
		          animation-delay: -0.3s; }
		.sk-circle .sk-circle11:before {
		  -webkit-animation-delay: -0.2s;
		          animation-delay: -0.2s; }
		.sk-circle .sk-circle12:before {
		  -webkit-animation-delay: -0.1s;
		          animation-delay: -0.1s; }
		
		@-webkit-keyframes sk-circleBounceDelay {
		  0%, 80%, 100% {
		    -webkit-transform: scale(0);
		            transform: scale(0);
		  } 40% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
		
		@keyframes sk-circleBounceDelay {
		  0%, 80%, 100% {
		    -webkit-transform: scale(0);
		            transform: scale(0);
		  } 40% {
		    -webkit-transform: scale(1);
		            transform: scale(1);
		  }
		}
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
    		<h2>결제처리중</h2>
    		<p class="text-center p-5">현재 결제가 진행중입니다. <br/>잠시만 기다려 주십시오.</p>
    		<div class="sk-circle">
				  <div class="sk-circle1 sk-child"></div>
				  <div class="sk-circle2 sk-child"></div>
				  <div class="sk-circle3 sk-child"></div>
				  <div class="sk-circle4 sk-child"></div>
				  <div class="sk-circle5 sk-child"></div>
				  <div class="sk-circle6 sk-child"></div>
				  <div class="sk-circle7 sk-child"></div>
				  <div class="sk-circle8 sk-child"></div>
				  <div class="sk-circle9 sk-child"></div>
				  <div class="sk-circle10 sk-child"></div>
				  <div class="sk-circle11 sk-child"></div>
				  <div class="sk-circle12 sk-child"></div>
				</div>
				<!-- 게시물목록 END -->
	    </div>
	  </div>
	</div>
	<!-- Single Product End -->
</body>
</html>