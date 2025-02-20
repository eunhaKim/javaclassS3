<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberUpdate.jsp</title>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
  .was-validated .form-control {margin:5px 0 10px;}
  </style>
  <script>
    'use strict';
    
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
    	// 정규식을 이용한 유효성 검사처리
		  let regNickName = /^[\w가-힣]+$/; 	// 닉네임은 한글, 영어, 숫자, 밑줄만 가능
		  let regName = /^[가-힣a-zA-Z]+$/;		// 이름은 한글/영문 가능
		  let regEmail =/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		  let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		  let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	
    	let homePage = myform.homePage.value;
    	
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    	
    	let submitFlag = 0;		// 체크 완료를 체크하기위한 변수.. 체크완료되면 submitFlag=1 이 된다.
    	
    	if(!regNickName.test(nickName)) {
        alert("닉네임은 한글, 영어, 숫자, 밑줄만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("이름은 한글/영문만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }
      else if((homePage != "http://" && homePage != "")) {
        if(!regURL.test(homePage)) {
	        alert("작성하신 홈페이지 주소가 URL 형식에 맞지않습니다.");
	        myform.homePage.focus();
	        return false;
        }
        else {
	    	  submitFlag = 1;
	      }
      }
			
			// 전화번호 형식 체크
    	if(tel2 != "" && tel3 != "") {
    	  if(!regTel.test(tel)) {
	    		alert("전화번호형식을 확인하세요.(000-0000-0000)");
	    		myform.tel2.focus();
	    		return false;
    	  }
    	  else {
    		  submitFlag = 1;
    	  }
    	}
    	else {		// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
    		tel2 = " ";
    		tel3 = " ";
    		tel = tel1 + "-" + tel2 + "-" + tel3;
    		submitFlag = 1;
    	}
			
			// 전송전에 파일에 관련된 사항들을 체크해준다.
			let fName = document.getElementById("file").value;
			if(fName.trim() != "") {
				let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
				let maxSize = 1024 * 1024 * 2;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 2MByte입니다.");
					return false;
				}
				submitFlag == 1;
			}
    	
			// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
			if(submitFlag == 1) {
	    	if(nickCheckSw == 0) {
	    		alert("닉네임 중복체크버튼을 눌러주세요");
	    		document.getElementById("nickNameBtn").focus();
	    	}
	    	else {
	    		myform.email.value = email;
	    		myform.tel.value = tel;
	    		myform.address.value = address;
	    		
	    		myform.submit();
	    	}
			}
			else {
    		alert("회원정보수정 실패~~ 폼의 내용을 확인하세요.");
    	}
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else if(nickName == '${sNickName}') {
    		alert("현재 닉네임을 그대로 사용합니다.");
    		nickCheckSw = 1;
    		return false;
    	}
    	else {
    		nickCheckSw = 1;
    		
    		$.ajax({
    			url  : "${ctp}/member/memberNickCheck",
    			type : "get",
    			data : {nickName : nickName},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 닉네임 입니다. 다시 입력하세요.");
    					myform.nickName.focus();
    				}
    				else alert("사용 가능한 닉네임 입니다.");
    			},
    			error : function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    }
    
    $(function(){
    	$("#nickName").on("blur", () => {
    		nickCheckSw = 0;
    	});
    });
    
    // 선택된 사진 미리보기
    function imgCheck(e) {
    	if(e.files && e.files[0]) {
    		let reader = new FileReader();
    		reader.onload = function(e) {
    			document.getElementById("photoDemo").src = e.target.result;
    		}
    		reader.readAsDataURL(e.files[0]);
    	}
    }
  </script>
</head>
<body>
<!-- container Start -->
<div class="container-fluid pt-3 pb-5">
  <div class="container py-5">
    <ol class="breadcrumb justify-content-start mb-4 ml-3">
      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> Home</a></li>
      <li class="breadcrumb-item"><a href="#">member</a></li>
      <li class="breadcrumb-item active text-dark">회원정보수정</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
    	<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
	    	<h2>회원정보수정</h2>
	    	<hr/>
	    	<p>회원가입시 빨간박스(*)는 필수 항목입니다. </p>
	    	<div class="form-group mt-4">
		      <label for="mid">아이디* : </label>
		      <input type="text" class="form-control" name="mid" id="mid" value="${sMid}" disabled/>
		    </div>
		    <div class="form-group">
		      <label for="nickName">닉네임* : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-primary btn-sm" onclick="nickCheck()"/></label>
		      <input type="text" class="form-control" id="nickName" value="${vo.nickName}" name="nickName" required />
		    </div>
		    <div class="form-group">
		      <label for="name">성명* :</label>
		      <input type="text" class="form-control" id="name" value="${vo.name}" name="name" required />
		    </div>
		    <div class="form-group">
		      <label for="email1">Email address* :</label>
		      <div class="input-group">
		      	<c:set var="email" value="${fn:split(vo.email,'@')}"/>
		        <input type="text" class="form-control" value="${email[0]}" id="email1" name="email1" required />
		        <div class="input-group-append">
		          <select name="email2" class="form-control bg-primary text-white">
		            <option value="naver.com" ${email[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
		            <option value="hanmail.net" ${email[1] == 'hanmail.net' ? 'selected' : ''}>hanmail.net</option>
		            <option value="hotmail.com" ${email[1] == 'hotmail.com' ? 'selected' : ''}>hotmail.com</option>
		            <option value="gmail.com" ${email[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
		            <option value="nate.com" ${email[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
		            <option value="yahoo.com" ${email[1] == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
		          </select>
		        </div>
		      </div>
		    </div>
		    <div class="form-group mb-2">
		      <div class="form-check-inline">
		        <span class="me-3">성별 :</span>
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="여자" ${vo.gender == '여자' ? 'checked' : ''}>여자
		        </label>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="birthday">생일 : </label>
		      <input type="date" name="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control"/>
		    </div>
		    <div class="form-group">
		    	<span class="">전화번호 :</span>
		    	<c:set var="tel" value="${fn:split(vo.tel,'-')}" />
		      <div class="input-group">
	          <select name="tel1" class="form-control">
	            <option value="010" ${tel[0] == '010' ? 'selected' : ''}>010</option>
              <option value="02"  ${tel[0] == '02'  ? 'selected' : ''}>서울</option>
              <option value="031" ${tel[0] == '031' ? 'selected' : ''}>경기</option>
              <option value="032" ${tel[0] == '032' ? 'selected' : ''}>인천</option>
              <option value="041" ${tel[0] == '041' ? 'selected' : ''}>충남</option>
              <option value="042" ${tel[0] == '042' ? 'selected' : ''}>대전</option>
              <option value="043" ${tel[0] == '043' ? 'selected' : ''}>충북</option>
              <option value="051" ${tel[0] == '051' ? 'selected' : ''}>부산</option>
              <option value="052" ${tel[0] == '052' ? 'selected' : ''}>울산</option>
              <option value="061" ${tel[0] == '061' ? 'selected' : ''}>전북</option>
              <option value="062" ${tel[0] == '062' ? 'selected' : ''}>광주</option>
	          </select>
	          <span class="p-2">-</span>
		        <input type="text" value="${tel[1]}" name="tel2" size=4 maxlength=4 class="form-control"/>
		        <span class="p-2">-</span>
		        <input type="text" value="${tel[2]}" name="tel3" size=4 maxlength=4 class="form-control"/>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="address">주소 : </label>
		      <c:set var="address" value="${fn:split(vo.address,'/')}"/>
		      <c:set var="postcode" value="${address[0]}"/>
		      <c:set var="roadAddress" value="${address[1]}"/>
		      <c:set var="detailAddress" value="${address[2]}"/>
		      <c:set var="extraAddress" value="${address[3]}"/>
		      <div class="input-group mb-1">
		        <input type="text" value="${postcode}" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
		        <div class="input-group-append">
		          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary mt-1">
		        </div>
		      </div>
		      <input type="text" value="${roadAddress}" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
		      <div class="input-group mb-1">
		        <input type="text" value="${detailAddress}" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
		        <div class="input-group-append">
		          <input type="text" value="${extraAddress}" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
		        </div>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="homepage">Homepage address :</label>
		      <input type="text" class="form-control" name="homePage" value="${vo.homePage}" id="homePage"/>
		    </div>
		    <div class="form-group">
		      <label for="name">직업 : </label>
		      <select class="form-control" id="job" name="job">
		        <option ${vo.job == '학생'  ? 'selected' : ''}>학생</option>
		        <option ${vo.job == '회사원' ? 'selected' : ''}>회사원</option>
		        <option ${vo.job == '공무원' ? 'selected' : ''}>공무원</option>
		        <option ${vo.job == '군인'  ? 'selected' : ''}>군인</option>
		        <option ${vo.job == '의사'  ? 'selected' : ''}>의사</option>
		        <option ${vo.job == '법조인' ? 'selected' : ''}>법조인</option>
		        <option ${vo.job == '세무인' ? 'selected' : ''}>세무인</option>
		        <option ${vo.job == '자영업' ? 'selected' : ''}>자영업</option>
		        <option ${vo.job == '기타' ? 'selected' : ''}>기타</option>
		      </select>
		    </div>
		    <div class="form-group mb-2">
	        <span class="me-3">취미 : </span>
	        <c:set var="varHobbys" value="${fn:split('등산/낚시/수영/독서/영화감상/바둑/축구/기타','/')}"/>
		      <c:forEach var="tempHobby" items="${varHobbys}" varStatus="st">
		        <div class="form-check-inline">
			        <label class="form-check-label">
			          <input type="checkbox" name="hobby" value="${tempHobby}" <c:if test="${fn:contains(vo.hobby,tempHobby)}">checked</c:if> /> ${tempHobby}
			        </label>
			      </div>
		      </c:forEach>
		    </div>
		    <div class="form-group">
		      <label for="content">자기소개 : </label>
		      <textarea rows="5" class="form-control" id="content" name="content">${vo.content}</textarea>
		    </div>
		    <div class="form-group mb-3">
		      <div class="form-check-inline">
		        <span class="me-2">정보공개 : </span>
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="userInfor" value="공개" ${vo.userInfor == '공개' ? 'checked' : ''} />공개
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="userInfor" value="비공개" ${vo.userInfor == '비공개' ? 'checked' : ''} />비공개
		        </label>
		      </div>
		    </div>
		    <div  class="form-group">
		      회원 사진(파일용량:2MByte이내) : 
		      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
		      <div><img src="${ctp}/memberImg/${vo.photo}" id="photoDemo" width="100px"/></div>
		    </div>
		    <hr/>
		    <div class="text-center mt-5 btnBox">
		    	<button type="button" class="btn btn-primary" onclick="fCheck()">회원정보수정</button>
			    <button type="reset" class="btn btn-warning">다시작성</button>
			    <button type="button" class="btn btn-secondary text-white" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
		    </div>
		    <input type="hidden" name="email" />
		    <input type="hidden" name="tel" />
		    <input type="hidden" name="address" />
		    <input type="hidden" name="mid" value="${sMid}" />
		    <input type="hidden" name="photo" id="photo" value="${vo.photo}" />
		  </form>
		</div>
	</div>
</div>
</body>
</html>