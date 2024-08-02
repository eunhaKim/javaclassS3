<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
	.writeMember {margin-bottom:5px; }
	.writeMember img { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
	.img-zoomin {max-height:400px; object-fit: cover; border-radius: 10px !important; border:1px solid #ddd;}
	.w-wVo {width:100px; }
</style>
<script>
	'use strict';
	
	// 삭제 버튼 클릭시
	function boardDelete(){
		let ans = confirm("현재 게시글을 삭제하시겠습니까?");
		if(ans) location.href = "boardDelete?boardName=${boardName}&idx=${vo.idx}";
	}
	
	// 처음에는 대댓글 '닫기'버튼은 보여주지 않는다.
  $(function(){
  	$(".replyCloseBtn").hide();
  });
	
	//대댓글 입력버튼 클릭시 입력박스 보여주기
  function replyShow(idx) {
  	$("#replyShowBtn"+idx).hide();
  	$("#replyCloseBtn"+idx).show();
  	$("#replyDemo"+idx).slideDown(100);
  }
  
  // 대댓글 박스 감추기
  function replyClose(idx) {
  	$("#replyShowBtn"+idx).show();
  	$("#replyCloseBtn"+idx).hide();
  	$("#replyDemo"+idx).slideUp(300);
  }
  
	//대댓글(부모댓글의 답변글)의 입력처리
  function replyCheckRe(idx, re_step, re_order) {
  	let content = $("#contentRe"+idx).val();
  	if(content.trim() == "") {
  		alert("답변글을 입력하세요");
  		$("#contentRe"+idx).focus();
  		return false;
  	}
  	
  	let query = {
  			boardName : '${boardName}',
  			boardIdx : ${vo.idx},
  			re_step : re_step,
  			re_order : re_order,
  			mid      : '${sMid}',
  			nickName : '${sNickName}',
  			hostIp   : '${pageContext.request.remoteAddr}',
  			content  : content
  	}
  	
  	$.ajax({
  		url  : "${ctp}/board/boardReplyInputRe",
  		type : "post",
  		data : query,
  		success:function(res) {
  			if(res != "0") {
  				alert("답변글이 입력되었습니다.");
  				location.reload();
  			}
  			else alert("답변글 입력 실패~~");
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
	
	
	
	
	// 원본글에 댓글달기
  function replyCheck() {
  	let content = $("#content").val();
  	if(content.trim() == "") {
  		alert("댓글을 입력하세요");
  		$("#content").focus();
  		return false;
  	}
  	let query = {
  			boardName : '${boardName}',
  			boardIdx 	: ${vo.idx},
  			mid				: '${sMid}',
  			nickName	: '${sNickName}',
  			hostIp    : '${pageContext.request.remoteAddr}',
  			content		: content
  	}
  	console.log(query);
  	
  	$.ajax({
  		url  : "${ctp}/board/boardReplyInput",
  		type : "post",
  		data : query,
  		success:function(res) {
  			if(res != "0") {
  				alert("댓글이 입력되었습니다.");
  				location.reload();
  			}
  			else alert("댓글 입력 실패~~");
  		},
  		error : function() {
  			alert("전송 오류!");
  		}
  	});
  }
	
	// 댓글 삭제
	function replyDelete(idx){
		let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			url : "${ctp}/board/boardReplyDelete",
			type: "post",
			data : {idx: idx},
			success : function(res){
				if(res != "0") {
					alert("댓글이 삭제되었습니다.");
					location.reload();
				}
				else alert("삭제 실패~");
			},
			error: function(){
				alert("전송오류!");
			}
			
		});
	}
	// 댓글 수정박스 보이게(중복불허!)
	function replyUpdateBoxOpen(replyVoIdx){
		let boxdisplay = window.getComputedStyle(document.getElementById('replyUpdateBox'+replyVoIdx)).display;
		// console.log(boxdisplay);
		if(boxdisplay=='none'){ // 중복을 피하기 위해 다 닫고 누른것만 보이게 해준다.
			$(".replyUpdateBox").hide();
			$("#replyUpdateBox"+replyVoIdx).show();
		}
		else{ // 같은 수정 버튼을 두번 눌렀을때
			$("#replyUpdateBox"+replyVoIdx).toggle();
		}
	}
	
	// 댓글수정
	function replyCheck2(replyVoidx) {
		let content = $("#content"+replyVoidx).val();
		if(content.trim() == "") {
			alert("댓글을 입력하세요");
			return false;
		}
		let query = {
			idx				: replyVoidx,
			hostIp    : '${pageContext.request.remoteAddr}',
			content		: content
		}
		
		$.ajax({
			url  : "${ctp}/board/boardReplyUpdate",
			type : "post",
			data : query,
			success:function(res) {
				if(res != "0") {
					alert("댓글이 수정되었습니다.");
					location.reload();
				}
				else alert("댓글 수정 실패~~");
			},
			error : function() {
				alert("전송 오류!");
			}
		});
	}
	
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
					alert("당신의 하트가 큰힘이 됩니다. 감사합니다.")
				}
				else alert("이미 좋아요 버튼을 클릭하셨습니다.");
			},
			error : function() {
				alert("전송오류");
			}
		});
	}
	
	// 트위터에 공유하기
	function shareTwitter() {
    var sendText = "개발새발"; // 전달할 텍스트
    var sendUrl = "devpad.tistory.com/"; // 전달할 URL
    window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
	}
	
	// 페이스북에 공유하기
	function shareFacebook() {
	    var sendUrl = "devpad.tistory.com/"; // 전달할 URL
	    window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
	}
	
</script>
</head>
<body>
<!-- Single Product Start -->
  <div class="container-fluid py-5">
    <div class="container py-5">
      <ol class="breadcrumb justify-content-start mb-4">
        <li class="breadcrumb-item"><a href="${ctp}/main">Home</a></li>
        <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
        <li class="breadcrumb-item active text-dark"><a href="${ctp}/board/boardList?boardName=${boardName}">${boardName}</a></li>
      </ol>
        <div class="row g-4">
          <div class="col-lg-9">
          	<div class="mb-5">
          		<a href="javascript:location.href='boardUpdate?boardName=${boardName}&idx=${vo.idx}';" class="btn btn-success"><i class="fa-solid fa-pen me-1"></i>수정</a>
          		<a href="javascript:boardDelete()" class="btn btn-danger"><i class="fa-solid fa-trash me-1"></i>삭제</a>
          	</div>
            <div class="mb-4">
            	<div class="writeMember">
              	<a><img src="${ctp}/memberImg/${vo.photo}" alt="${vo.nickName}">${vo.nickName}</a>
              </div>
              <h2 class="h1 display-5">${vo.title}</h2>
            </div>
            <!-- 리스트이미지 START -->
            <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
            <c:if test="${empty fSNames[0]}">
            	<div class="position-relative rounded overflow-hidden mb-3">
            		<img src="${ctp}/boardImg/logo.png" alt="리스트이미지" class="img-zoomin img-fluid rounded w-100">
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
            <!-- 리스트이미지 END -->
            <div class="d-flex justify-content-between">
              <a href="#" class="text-dark link-hover me-3" title="작성일"><i class="fa fa-clock"></i> ${fn:substring(vo.WDate,0,16)}</a>
              <a href="#" class="text-dark link-hover me-3" title="조회수"><i class="fa fa-eye"></i> ${vo.readNum}</a>
              <a href="#" class="text-dark link-hover me-3" title="댓글"><i class="fa-regular fa-comment-dots"></i> ${vo.replyCnt} Comment</a>
              <a href="javascript:goodCheck(${vo.idx})" class="text-dark link-hover" title="좋아요"><i class="fa-solid fa-heart text-danger"></i> ${vo.good}</a>
            </div>
            
            <div class="my-5 py-5">${vo.content}</div>
            
            <div class="tab-class">
              <div class="d-flex justify-content-between border-bottom mb-4">
                <ul class="nav nav-pills d-inline-flex text-center">
                  <li class="nav-item mb-3">
                    <h5 class="mt-2 me-3 mb-0">${vo.nickName}:</h5>
                  </li>
                  <li class="nav-item mb-3">
                    <a class="d-flex py-2 bg-light rounded-pill active me-2" data-bs-toggle="pill" href="#tab-1">
                      <span class="text-dark" style="width: 100px;">자기소개</span>
                    </a>
                  </li>
                  <li class="nav-item mb-3">
                    <a class="d-flex py-2 bg-light rounded-pill me-2" data-bs-toggle="pill" href="#tab-2">
                      <span class="text-dark" style="width: 100px;">홈페이지</span>
                    </a>
                  </li>
                </ul>
                <div class="d-flex align-items-center">
                  <h5 class="mb-0 me-3">Share:</h5>
                  <i class="fab fa-facebook-f link-hover btn btn-square rounded-circle border-primary text-dark me-2" onclick="javascript:shareFacebook()"></i>
                  <i class="btn fab bi-twitter link-hover btn btn-square rounded-circle border-primary text-dark me-2"  onclick="javascript:shareTwitter();"></i>
                  <i class="btn fab fa-instagram link-hover btn btn-square rounded-circle border-primary text-dark me-2"></i>
                  <i class="btn fab fa-linkedin-in link-hover btn btn-square rounded-circle border-primary text-dark"></i>
                </div>
              </div>
              <div class="tab-content">
                <div id="tab-1" class="tab-pane fade show active">
                  <div class="row g-4 align-items-center">
                    <div class="col-2">
                      <img src="${ctp}/memberImg/${vo.photo}" class="img-fluid w-100 rounded" alt="${vo.nickName}">
                    </div>
                    <div class="col-10">
                      <h4>소개글 :</h4>
                      <p class="mb-0">${vo.memberContent}</p>
                    </div>
                  </div>
                </div>
                <div id="tab-2" class="tab-pane fade show">
                  <div class="row g-4 align-items-center">
                    <div class="col-2">
                      <img src="${ctp}/memberImg/${vo.photo}" class="img-fluid w-100 rounded" alt="${vo.nickName}">
                    </div>
                    <div class="col-10">
                      <h3>홈페이지 :</h3>
                      <p class="mb-0"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="bg-light rounded my-4 p-4" style="position:relative;">
              <h4 class="mb-4">${vo.nickName}님의 다른글 </h4>
              <div class="row g-4">
	              <!-- 반복 -->
	              <c:forEach var="wVo" items="${wVos}" begin="0" end="1">
                <div class="col-lg-6">
                  <div class="d-flex align-items-center p-3 bg-white rounded">
                    <c:set var="fSNames" value="${fn:split(wVo.FSName,'/')}"/>
                    <c:if test="${empty fSNames[0]}">
			              	<img src="${ctp}/boardImg/Listlogo.jpg" alt="리스트이미지"  class="img-fluid rounded w-wVo"/>
			              </c:if>
                    <c:if test="${!empty fSNames[0]}">
                    	<img src="${ctp}/boardImg/${fSNames[0]}" alt="리스트이미지" class="img-fluid rounded w-wVo"/>
			              </c:if>
                    <div class="ms-3">
                      <a href="boardContent?boardName=${boardName}&idx=${wVo.idx}" class="h5 mb-2">${fn:substring(wVo.title,0,10)}</a>
                      <p class="text-dark mt-1 mb-0 me-3"><i class="fa fa-clock"></i> ${fn:substring(wVo.WDate,0,16)}</p>
                    </div>
                  </div>
                </div>
                </c:forEach>
	              <!-- 반복 -->
              </div>
            </div>
            <c:if test="${!empty replyVos}">
	            <div class="bg-light rounded p-4 pb-1">
	              <h4 class="mb-4">Comments</h4>
              	<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
	              	<c:if test="${replyVo.re_step < 1}">
	              		<div class="p-4 bg-white rounded mb-4">
			                <div class="row g-4">
			                  <div class="col-2">
			                    <img src="${ctp}/memberImg/${replyVo.photo}" class="img-fluid rounded w-100" alt="">
			                  </div>
			                  <div class="col-10">
			                    <div class="d-flex justify-content-between">
			                      <h5>${replyVo.nickName}</h5>
			                      <div class="text-right">
				                      <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge bg-success text-white">답글</a>
		        									<a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge bg-warning replyCloseBtn">답글취소</a>
			                      </div>
			                    </div>
			                    <small class="text-body d-block mb-3"><i class="fas fa-calendar-alt me-1"></i> ${fn:substring(replyVo.WDate,0,16)}</small>
			                    <div class="mb-3 replyContent">${fn:replace(replyVo.content, newLine,"<br/>")}</div>
			                    <c:if test="${replyVo.mid == sMid}">
				                    <a href="javascript:replyUpdateBoxOpen(${replyVo.idx})" class="badge bg-warning">수정</a>
				                    <a href="javascript:replyDelete(${replyVo.idx})" class="badge bg-secondary"/>삭제</a>
			                    </c:if>
			                    <div id="replyDemo${replyVo.idx}" style="display:none; margin-top:20px">
			                    	<hr class="bg-success">
			                    	<p class="text-success"><i class="fa-regular fa-user"></i> 작성자 : ${sNickName}</p>
									          <textarea rows="2" name="contentRe" id="contentRe${replyVo.idx}" class="form-control" placeholder="권리침해, 욕설, 비하, 명예훼손, 혐오, 불법촬영물 등의 내용을 게시하면 운영정책 및 관련 법률에 의해 제재될 수 있습니다."></textarea>
									          <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-success btn-sm mt-2"/>
									        </div>
									        <div class="row noline replyUpdateBox" id="replyUpdateBox${replyVo.idx}" style="display:none;">
								        		<div class="col-md-12 mt-3 mb-1"><textarea rows="2" name="content${replyVo.idx}" id="content${replyVo.idx}" class="form-control">${replyVo.content}</textarea></div>
								        		<div class="col-md-12"><input type="button" value="댓글수정" onclick="replyCheck2(${replyVo.idx})" class="btn btn-sm btn-success"/></div>
							        		</div>
			                  </div>
			                </div>
		              	</div>
		              </c:if>
		              <c:if test="${replyVo.re_step >= 1}">
		              	<div class="pe-0 mb-4">
		              		<div class="row g-4" style="padding-left:${replyVo.re_step*30}px; ">
			                  <div class="col-12" style="border-left:1px dotted #ddd;">
			                    <div class="d-flex justify-content-between">
			                      <div class="writeMember">
							              	<a><img src="${ctp}/memberImg/${replyVo.photo}" alt="${replyVo.nickName}">${replyVo.nickName}</a>
							              </div>
			                      <div class="text-right">
				                      <a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge bg-success text-white">답글</a>
		        									<a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge bg-warning replyCloseBtn">답글취소</a>
			                      </div>
			                    </div>
			                    <small class="text-body d-block mb-3"><i class="fas fa-calendar-alt me-1"></i> ${fn:substring(replyVo.WDate,0,16)}</small>
			                    <div class="replyContent bg-white p-2 rounded">${fn:replace(replyVo.content, newLine,"<br/>")}</div>
			                    <c:if test="${replyVo.mid == sMid}">
				                    <a href="javascript:replyUpdateBoxOpen(${replyVo.idx})" class="badge bg-warning">수정</a>
				                    <a href="javascript:replyDelete(${replyVo.idx})" class="badge bg-secondary">삭제</a>
			                    </c:if>
			                    <div id="replyDemo${replyVo.idx}" style="display:none; margin-top:20px">
			                    	<hr class="bg-success">
			                    	<p class="text-success"><i class="fa-regular fa-user"></i> 작성자 : ${sNickName}</p>
									          <textarea rows="2" name="contentRe" id="contentRe${replyVo.idx}" class="form-control" placeholder="권리침해, 욕설, 비하, 명예훼손, 혐오, 불법촬영물 등의 내용을 게시하면 운영정책 및 관련 법률에 의해 제재될 수 있습니다."></textarea>
									          <input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-success btn-sm mt-2"/>
									        </div>
									        <div class="row noline replyUpdateBox" id="replyUpdateBox${replyVo.idx}" style="display:none;">
								        		<div class="col-md-12 mt-3 mb-1"><textarea rows="2" name="content${replyVo.idx}" id="content${replyVo.idx}" class="form-control">${replyVo.content}</textarea></div>
								        		<div class="col-md-12"><input type="button" value="댓글수정" onclick="replyCheck2(${replyVo.idx})" class="btn btn-sm btn-success"/></div>
							        		</div>
			                  </div>
			                </div>
		              	</div>
					        </c:if>
					        
                </c:forEach>
	            </div>
            </c:if>
            <div class="bg-light rounded p-4 my-4">
              <h4 class="mb-4">Leave A Comment</h4>
              <form name="replyForm">
                <div class="row g-2">
                  <div class="writeMember ml-1">
		              	<a><img src="${ctp}/memberImg/${mVo.photo}" alt="${mVo.nickName}">${mVo.nickName}</a>
		              </div>
                  <div>
                    <textarea class="form-control" name="content" id="content" rows="3" placeholder="댓글을 입력해주세요"></textarea>
                  </div>
                  <div>
                    <input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-primary py-2 w-100"/>
                  </div>
                </div>
              </form>
            </div>
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