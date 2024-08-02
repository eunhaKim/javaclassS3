<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
	.boardList { border-bottom: 1px solid #dee2e6; padding-bottom:40px; margin-bottom:30px;}
	.boardList:last-child { border-bottom: 0;}
	.writeMember { margin-bottom:5px; }
	.writeMember img { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
	.img-zoomin { max-height:400px; object-fit: cover; border-radius: 10px !important; border:1px solid #ddd;}
</style>
<script>
	'use strict';
	
	// 좋아요 처리(중복불허)
	function goodCheck(idx) {
		$.ajax({
			url  : "${ctp}/board/boardGoodCheck",
			type : "post",
			data : {boardName : '${boardName}', 
							idx : idx},
			success:function(res) {
				if(res != "0") {
					location.reload();
					alert("당신의 ♥가 큰힘이 됩니다. 감사합니다.")
				}
				else alert("이미 좋아요 버튼을 클릭하셨습니다.");
			},
			error : function() {
				alert("전송오류");
			}
		});
	}
</script>
</head>
<body>
	<!-- Single Product Start -->
	<div class="container-fluid pt-3 pb-5">
	  <div class="container py-5">
	    <ol class="breadcrumb justify-content-start mb-4">
	      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> <a href="${ctp}/main">Home</a></li>
	      <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
	      <li class="breadcrumb-item active text-dark"><a href="${ctp}/board/boardList?boardName=${boardName}">${boardName}</a></li>
	    </ol>
	    <div class="row g-4">
	      <div class="col-lg-9">
	       	<div class="mb-5"><a href="${ctp}/board/boardInput?boardName=${boardName}" class="btn btn-success"><i class="fa-solid fa-pen"></i> 글쓰기</a></div>
	    		<!-- 게시물목록 START -->
	    		<c:if test="${!empty vos && searchStr != null}"><h2 class="mb-5 text-primary"><i class="fa-solid fa-magnifying-glass"></i> "${searchStr}" 검색 결과입니다..</h2></c:if>
	    		<c:if test="${empty vos}"><h2 class="mb-5 text-primary"><i class="fa-solid fa-magnifying-glass"></i> "${searchStr}" 검색 결과가 없습니다..</h2></c:if>
	    		<c:forEach var="vo" items="${vos}" varStatus="st">
	      		<div class="boardList">
	            <div class="mb-4">
	              <div class="writeMember">
	              	<a><img src="${ctp}/memberImg/${vo.photo}" alt="${vo.nickName}">${vo.nickName}</a>
	              </div>
	              <a href="boardContent?boardName=${boardName}&idx=${vo.idx}" class="h2">${vo.title}</a>
	            </div>
	            <!-- 리스트이미지 START -->
	            <a href="boardContent?boardName=${boardName}&idx=${vo.idx}">
	              <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
	              <c:if test="${empty fSNames[0]}">
	              	<div class="position-relative rounded overflow-hidden mb-3 ">
	              		<img src="${ctp}/boardImg/Listlogo.jpg" alt="리스트이미지"  class="img-zoomin img-fluid rounded w-100">
	              	</div>
	              </c:if>
	              <c:if test="${!empty fSNames[0]}">
	                <div id="demo" class="position-relative rounded overflow-hidden mb-3 carousel slide" data-ride="carousel">
	                											  
									  <!-- The slideshow -->
									  <div class="carousel-inner">
	                  	
	                  	<c:forEach var="fSName" items="${fSNames}" varStatus="st">
										    <div class="carousel-item ${st.index == 0 ? 'active' : ''}">
										      <img src="${ctp}/boardImg/${fSName}" class="img-zoomin img-fluid rounded w-100" alt="리스트이미지">
										    </div>
	                  	</c:forEach>
	                  </div>
	                  
	                  <!-- Left and right controls -->
	                  <c:if test="${!empty fSNames[1]}">
										  <a class="carousel-control-prev" href="#demo" data-slide="prev">
										    <span class="carousel-control-prev-icon"></span>
										  </a>
										  <a class="carousel-control-next" href="#demo" data-slide="next">
										    <span class="carousel-control-next-icon"></span>
										  </a>
										</c:if>
	                  
	                </div>
	              </c:if>
	            </a>
	            <!-- 리스트이미지 END -->
	            <div class="d-flex justify-content-between">
	              <a href="#" class="text-dark link-hover me-3" title="작성일"><i class="fa fa-clock"></i> ${fn:substring(vo.WDate,0,16)}</a>
	              <a href="#" class="text-dark link-hover me-3" title="조회수"><i class="fa fa-eye"></i> ${vo.readNum}</a>
	              <a href="#" class="text-dark link-hover me-3" title="댓글"><i class="fa-regular fa-comment-dots"></i> ${vo.replyCnt} Comment</a>
	              <a href="javascript:goodCheck(${vo.idx})" class="text-dark link-hover" title="좋아요"><i class="fa-solid fa-heart text-danger"></i> ${vo.good}</a>
	            </div>
	          </div>
	        </c:forEach>
	    		<!-- 게시물목록 END -->
	    		
	    		<!-- 블록페이지 시작 -->
					<div class="text-center">
					  <ul class="pagination justify-content-center">
						  <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="boardList?boardName=${boardName}&pag=1&pageSize=${pageVO.pageSize}">첫페이지</a></li></c:if>
						  <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="boardList?boardName=${boardName}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}">이전블록</a></li></c:if>
						  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
						    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="boardList?boardName=${boardName}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="boardList?boardName=${boardName}&pag=${i}&pageSize=${pageVO.pageSize}">${i}</a></li></c:if>
						  </c:forEach>
						  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="boardList?boardName=${boardName}&pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}">다음블록</a></li></c:if>
						  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="boardList?boardName=${boardName}&pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
					  </ul>
					</div>
					<!-- 블록페이지 끝 -->
	      </div>
	      <div class="col-lg-3">
          <div class="row g-4">
            <div class="col-12">
              <!-- Board 우측 STRART -->
              <jsp:include page="boardRight.jsp"></jsp:include>
              <!-- Board 우측 END -->
            </div>
          </div>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Single Product End -->
</body>
</html>