<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrderBaesong.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
	<!-- 게시물목록 START -->
	<h2>배송조회</h2>
	<hr/>
  <p>주문자 : ${vo.name}</p>
  <p>연락처 : ${vo.tel}</p>
  <p>주소 : ${vo.address}</p>
  <p>배송메세지 : ${vo.message}</p>
  <p>결재수단 : ${payMethod} / ${fn:substring(vo.payment,1,fn:length(vo.payment))}</p>
  <p>주문번호 : ${vo.orderIdx}</p>
  <hr/>
  <p class="text-center"><input type="button" value="창닫기" onclick="window.close()" class="btn btn-success btn-sm"/></p>
	<!-- 게시물목록 END -->
</body>
</html>