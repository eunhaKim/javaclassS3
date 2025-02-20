<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberJoin.jsp</title>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
  .was-validated .form-control {margin:5px 0 10px;}
  </style>
  <script>
	  'use strict';
	  
	  let idCheckSw = 0;		// 아이디 중복체크
	  let nickCheckSw = 0;	//닉네임 중복체크
	  
	  $(function(){
    	$("#mid").on("blur", () => {	// blur 이벤트는 포커스를 잃을 때 발생
    		idCheckSw = 0;
    	});
    	
    	$("#nickName").on("blur", () => {
    		nickCheckSw = 0;
    	});
    	
    });
	  
	  
	  function fCheck(){
		  // 정규식을 이용한 유효성 검사처리
		  let regMid = /^[a-zA-Z0-9_]{4,20}$/; // 아이디는 4~20개의 영문 대/소문자와 밑줄 가능
		  let regNickName = /^[\w가-힣]+$/; 	// 닉네임은 한글, 영어, 숫자, 밑줄만 가능
		  let regName = /^[가-힣a-zA-Z]+$/;		// 이름은 한글/영문 가능
		  let regEmail =/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		  let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
		  let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
		  
			// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
	  	let mid = myform.mid.value.trim();
	  	let pwd = myform.pwd.value.trim();
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
			
			if(!regMid.test(mid)) {
				alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
				myform.mid.focus();
				return false;
			}
			else if(pwd.length < 4 && pwd.length > 20) {
		    alert("비밀번호는 4~20 자리로 작성해주세요.");
		    myform.pwd.focus();
		    return false;
		  }
		  else if(!regNickName.test(nickName)) {
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
				let maxSize = 1024 * 1024 * 5;
				let fileSize = document.getElementById("file").files[0].size;
				
				if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
					alert("그림파일만 업로드 가능합니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드할 파일의 최대용량은 5MByte입니다.");
					return false;
				}
				submitFlag == 1;
			}
			
			// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
			if(submitFlag == 1) {
	    	if(idCheckSw == 0) {
	    		alert("아이디 중복체크버튼을 눌러주세요");
	    		document.getElementById("midBtn").focus();
	    	}
	    	else if(nickCheckSw == 0) {
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
				alert("회원가입 실패~~ 폼의 내용을 확인하세요.");
			}
  	}
	  
		// 아이디 중복체크
    function idCheck() {
    	let mid = myform.mid.value;
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요!");
    		myform.mid.focus();
    	}
    	else {
    		idCheckSw = 1;
    		
    		$.ajax({
    			url  : "${ctp}/member/memberIdCheck",
    			type : "get",
    			data : {mid : mid},
    			success:function(res) {
    				if(res != '0') {
    					alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
    					myform.mid.focus();
    				}
    				else alert("사용 가능한 아이디 입니다.");
    			},
    			error : function() {
    				alert("전송 오류!");
    			}
    		});
    	}
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
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
      <li class="breadcrumb-item active text-dark">memberJoin</li>
    </ol>
    <div id="loginFormBox" class="bg-light rounded p-5 mobileBox">
    	<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
	    	<h2>회원가입</h2>
	    	<hr/>
	    	<p>회원가입시 빨간박스(*)는 필수 항목입니다. </p>
	    	<div class="form-group mt-4">
		      <label for="mid">아이디* : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-primary btn-sm" onclick="idCheck()"/></label>
		      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
		    </div>
		    <div class="form-group">
		      <label for="pwd">비밀번호* :</label>
		      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
		    </div>
		    <div class="form-group">
		      <label for="nickName">닉네임* : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-primary btn-sm" onclick="nickCheck()"/></label>
		      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
		    </div>
		    <div class="form-group">
		      <label for="name">성명* :</label>
		      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
		    </div>
		    <div class="form-group">
		      <label for="email1">Email address* :</label>
		      <div class="input-group">
		        <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
		        <div class="input-group-append">
		          <select name="email2" class="form-control bg-primary text-white">
		            <option value="naver.com" selected>naver.com</option>
		            <option value="hanmail.net">hanmail.net</option>
		            <option value="hotmail.com">hotmail.com</option>
		            <option value="gmail.com">gmail.com</option>
		            <option value="nate.com">nate.com</option>
		            <option value="yahoo.com">yahoo.com</option>
		          </select>
		        </div>
		      </div>
		    </div>
		    <div class="form-group mb-2">
		      <div class="form-check-inline">
		        <span class="me-3">성별 :</span>
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="gender" value="여자">여자
		        </label>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="birthday">생일 : </label>
		      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
		    </div>
		    <div class="form-group">
		    	<span class="">전화번호 :</span>
		      <div class="input-group">
	          <select name="tel1" class="form-control">
	            <option value="010" selected>010</option>
	            <option value="02">서울</option>
	            <option value="031">경기</option>
	            <option value="032">인천</option>
	            <option value="041">충남</option>
	            <option value="042">대전</option>
	            <option value="043">충북</option>
	            <option value="051">부산</option>
	            <option value="052">울산</option>
	            <option value="061">전북</option>
	            <option value="062">광주</option>
	          </select>
	          <span class="p-2">-</span>
		        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/>
		        <span class="p-2">-</span>
		        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="address">주소 : </label>
		      <div class="input-group mb-1">
		        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
		        <div class="input-group-append">
		          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-primary mt-1">
		        </div>
		      </div>
		      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
		      <div class="input-group mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
		        <div class="input-group-append">
		          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
		        </div>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="homepage">Homepage address :</label>
		      <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
		    </div>
		    <div class="form-group">
		      <label for="name">직업 : </label>
		      <select class="form-control" id="job" name="job">
		        <!-- <option value="">직업선택</option> -->
		        <option>학생</option>
		        <option>회사원</option>
		        <option>공무원</option>
		        <option>군인</option>
		        <option>의사</option>
		        <option>법조인</option>
		        <option>세무인</option>
		        <option>자영업</option>
		        <option selected>기타</option>
		      </select>
		    </div>
		    <div class="form-group mb-2">
	        <span class="me-3">취미 : </span>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
		        </label>
		      </div>
		    </div>
		    <div class="form-group">
		      <label for="content">자기소개 : </label>
		      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
		    </div>
		    <div class="form-group mb-3">
		      <div class="form-check-inline">
		        <span class="me-2">정보공개 : </span>
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
		        </label>
		      </div>
		      <div class="form-check-inline">
		        <label class="form-check-label">
		          <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
		        </label>
		      </div>
		    </div>
		    <div  class="form-group">
		      회원 사진(파일용량:2MByte이내) :
		      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
		      <div><img id="photoDemo" width="100px"/></div>
		    </div>
		    <hr/>
		    <div class="text-center mt-5 btnBox">
		    	<button type="button" class="btn btn-primary" onclick="fCheck()">회원가입</button>
			    <button type="reset" class="btn btn-warning">다시작성</button>
			    <button type="button" class="btn btn-secondary text-white" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
		    </div>
		    <input type="hidden" name="email" />
		    <input type="hidden" name="tel" />
		    <input type="hidden" name="address" />
		  </form>
		</div>
	</div>
</div>
</body>
</html>