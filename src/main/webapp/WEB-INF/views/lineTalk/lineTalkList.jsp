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
	  background-color: white;
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
  <script>
	  'use strict';
	  
	  // setTimeout('location.reload()',1000*10);
	  
	  // 한줄수다 삭제
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
	  
	
	  // 무한스크롤 가져오기
    let curPage = 1;
	  let totPage = ${totPage};
	  let isLoading = false; //  로딩이 중첩되지 않도록 boolean 값을 추가한다
	  let start = true;
    
    // 리스트 불러오기 함수(ajax처리)
    function getList() { 
    	let temp = $(document).height();
    	if(curPage >= totPage){
    		return false;
    	}
    	else {
	    	curPage++;
	    	// alert(curPage+" / "+ totPage +"페이지 다운로드");
	    	$.ajax({
	    		url  : "${ctp}/lineTalk/lineTalkList",
	    		type : "post",
	    		data : {pag : curPage},
	    		success:function(vos) {
	    			let str = '';
	    			if(vos != "") {
		    			for(let i=0 ; i<vos.length ; i++){
		    				if(vos[i].mid == '${sMid}'){
			    				str += '<div class="talkLine talkLine2 d-flex flex-row-reverse">';
			    				str += '<div><img src="${ctp}/resources/data/member/'+ vos[i].photo +'" alt="'+ vos[i].nickName +' 회원이미지" class="profile" /></div>';
			    				str += '<div class="text-right">';
			    				str += '<span>'+ vos[i].nickName +'</span>';
			    				str += '<p class="bg-success text-white">'+ vos[i].chat +'</p>';
			    				str += '<span>'+ vos[i].wdate.substring(0,16) +' <a href="#" onclick="lineTalkDelete('+ vos[i].idx +')" title="글삭제">X</a></span>';
			    				str += '</div>';
			    				str += '</div>';
		    				}
		    				else{
		    					str += '<div class="talkLine d-flex">';
		    					str += '<div><img src="${ctp}/resources/data/member/'+ vos[i].photo +'" alt="회원이미지" class="profile" /></div>';
		    					str += '<div>';
		    					str += '<span>'+ vos[i].nickName +'</span>';
		    					str += '<p>'+ vos[i].chat +'</p>';
		    					str += '<span>'+ vos[i].wdate.substring(0,16) +'</span>';
		    					str += '</div>';
		    					str += '</div>';
		    				}
		    			}
	    			}
	    			$("#list-wrap").prepend(str);
		    		if(curPage == totPage) $("#list-wrap").prepend('<div><p class="bg-primary p-2 text-center text-white mb-5"><i class="fa-solid fa-comments"></i> 한줄수다 마지막입니다.</p></div>');
	    			$(document).scrollTop($(document).height()-temp); // 페이지의 높이를 담아뒀다가, 로딩이 된 다음의 페이지 높이에서 이전 값을 절감하여 그 값을 현재 스크롤바 위치로 설정한다, 따라서 새 데이터가 로딩되도 보고있는 화면은 같게 유지 할 수 있다.
	    			setTimeout(function(){isLoading = false;}, 2000); // 다음 로딩을 지연시키기 위해 4초 지연을 주었다.
	    		}
	    	});
	    	if(curPage == totPage){
	    		$(".sk-circle").hide();
	    	}
    	}
    }
	  
    $(document).scroll(function(){
    	if($(document).scrollTop() > 80) start = false; // 시작할때 한번은 그냥 넘어가기 위해서...
    	// 스크롤이 위로 올라갔을때 이벤트 처리..
    	if($(document).scrollTop() < 80 && !isLoading && !start) { // 스크롤바의 위치가 80 미만이면 로딩을 시작한다. 여기서 60은 로딩개체의 크기이다.
  			// 다음페이지 가져오기...
  			isLoading = true;
  		  setTimeout(getList(), 1000); // 로딩을 1초 후 하기위하여 로딩 작업을 함수에 담았다.
    	}
    });
 		
	 	// 처음 스크롤 위치 조정
	  $(function(){
		  $(document).scrollTop($(document).height());
	  });
  </script>
</head>
<body>
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
	<div class="talkLineBox" id="list-wrap">
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