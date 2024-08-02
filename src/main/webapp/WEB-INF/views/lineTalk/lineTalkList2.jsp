<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>lineTalkList.jsp</title>
  <style>
 	body{ background: none; }
  .talkLineBox {width:100%; position:relative;}
  .talkLine { margin-bottom:10px;}
  .talkLine img.profile { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
  .talkLine2 img.profile { margin-left:10px; }
  .talkLine span:first-child { display:block; font-size: 16px; line-height:30px; color:#fff; text-shadow: 0 0 2px #333;}
  .talkLine p { background: rgba(255, 255, 255, 0.6); margin-bottom:0; border-radius: 20px; border:1px solid var(--bs-primary); color:#111; font-size:16px; padding:7px 15px; display:inline-block; }
  .talkLine span:last-child { display:block; margin-left: 10px; font-size: 14px; color:#fff; text-shadow: 0 0 2px #333;}
  .talkLine span:last-child a { background: orange; padding:0 5px; color:#fff; border-radius: 5px;}
  .talkLine span:last-child a:hover { background: var(--bs-danger); }
  </style>
  <script>
	  'use strict';
	  
	  setTimeout('location.reload()',1000*10);
	  
	  function lineTalkDelete(idx){
		  let ans = confirm("해당글을 삭제하시겠습니까?");
		  if(!ans) return false;
		  
		  $.ajax({
			  url : "${ctp}/lineTalk/lineTalkDelete",
			  type : "post",
			  data : {idx : idx},
			  success : function(res){
				  if(res == "1") {
					  alert("삭제되었습니다.");
					  location.reload();
				  }
				  else alert("삭제실패..관리자에게 문의해주세요.");
			  },
			  error : function(){
				  alert("전송오류!");
			  }
		  });
	  }
	  
	  $(function(){
		  document.body.scrollIntoView(false); // 스크롤바를 강제로 Body태그의 마지막위치로 이동시킨다.
	  })
	  
	  // 처음 스크롤 위치 조정
	  $(function(){
		  window.scrollTo(0, 0); // 수직 스크롤을 0(상단)으로 이동
	  })
	  
	  // 무한스크롤 가져오기
	  let lastScroll = 0;
    let curPage = 1;
    
    $(document).scroll(function(){
    	let currentScroll = $(this).scrollTop();			// 스크롤바 위쪽시작 위치, 처음은 0이다.
    	let documentHeight = $(document).height();		// 화면에 표시되는 전체 문서의 높이
    	let nowHeight = $(this).scrollTop() + $(window).height();	// 현재 화면상단 + 현재 화면높이
    	
    	// 스크롤이 아래로 내려갔을때 이벤트 처리..
    	if(currentScroll > lastScroll) {
    		if(documentHeight < (nowHeight + (documentHeight*0.1))) {
    			// 다음페이지 가져오기...
    			console.log("다음페이지 가져오기");
    			curPage++;
    			getList(curPage);
    		}
    	}
    	lastScroll = currentScroll;
    });
    
    // 리스트 불러오기 함수(ajax처리)
    function getList(curPage) {
    	$.ajax({
    		url  : "ScrollPage.st",
    		type : "post",
    		data : {pag : curPage},
    		success:function(res) {
    			$("#list-wrap").append(res);
    		}
    	});
    }
  </script>
</head>
<body>
	<div class="talkLineBox">
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.mid == sMid }">
				<div class="talkLine talkLine2 d-flex flex-row-reverse">
					<div><img src="${ctp}/resources/data/member/${vo.photo}" alt="${vo.nickName} 회원이미지" class="profile" /></div>
				 	<div class="text-right">
			   		<span>${vo.nickName}</span>
			    	<p class="bg-success text-white">${vo.chat}</p>
			    	<span>${fn:substring(vo.WDate,0,16)} <a href="#" onclick="lineTalkDelete(${vo.idx})" title="글삭제">X</a></span>
			   	</div>
				</div>
			</c:if>
			<c:if test="${vo.mid != sMid }">
				<div class="talkLine d-flex">
					<div><img src="${ctp}/resources/data/member/${vo.photo}" alt="회원이미지" class="profile" /></div>
			   	<div>
			   		<span>${vo.nickName}</span>
			    	<p>${vo.chat}</p>
			    	<span>${fn:substring(vo.WDate,0,16)}</span>
			   	</div>
				</div>
		  </c:if>
		</c:forEach>
	</div>
</body>
</html>