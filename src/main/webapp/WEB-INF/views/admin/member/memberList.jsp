<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList.jsp</title>
<script>
	'use strict';
	
	function userCheck(){ // 비공개회원만보기/전체보기
		if($("#userInfor").is(':checked')) {
			$("#userDispaly1").hide();
			$("#userDispaly2").show();
		}
		else {
			$("#userDispaly1").show();
			$("#userDispaly2").hide();
		}
	}
	
	function checkAll(){ // 체크박스 전체 선택
		$("input[name=idxFlag]").prop("checked",$("input[name=idxFlag]")).prop("checked");
		$("input[name=checkReverse]").prop("checked",false);
	}
	
	function checkReverse(){ // 체크박스 반전
		$("input[name=idxFlag]").each(function(){
			$(this).prop("checked",!$(this).prop("checked"));
		});
		$("input[name=checkAll]").prop("checked",false);
	}
	
	// 각 레벨(등급)별 회원 보기...
  function levelItemCheck() {
  	let level = $("#levelItem").val();
  	location.href = "${ctp}/admin/member/memberList?level="+level;
  }
	
	//회원별 각각의 등급 변경처리(ajax처리)
  function levelChange(e) {
  	let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
  	if(!ans) {
  		location.reload();
  		return false;
  	}
  	
  	let items = e.value.split("/");
  	let query = {
  			level : items[0],
  			idx   : items[1]
  	}
  	
  	$.ajax({
  		url  : "${ctp}/admin/member/memberLevelChange",
  		type : "post",
  		data : query,
  		success:function(res) {
  			if(res != "0") {
  				alert("등급 수정 완료!");
  				location.reload();
  			}
  			else alert("등급 수정 실패~~");
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
	
	//30일 경과회원 삭제처리
  function memberDeleteOk(idx, photo) {
  	let ans = confirm("선택하신 회원을 영구 삭제 하시겠습니까?");
  	if(ans) {
  		$.ajax({
  			url  : "${ctp}/admin/member/memberDeleteOk",
  			type : "post",
  			data : {
  				idx : idx,
  				photo : photo
  			},
  			success:function(res) {
  				if(res != "0") {
  					alert("영구 삭제 되었습니다.");
  					location.reload();
  				}
  				else alert("삭제 실패~~");
  			}
  		});
  	}
  }
	
	//선택항목 등급변경처리
  function levelSelectCheck() {
  	let select = document.getElementById("levelSelect");
  	let levelSelectText = select.options[select.selectedIndex].text;
  	let levelSelect = select.options[select.selectedIndex].value;
  	// let levelSelect = document.getElementById("levelSelect").value;
  	let idxSelectArray = '';
  	
    for(let i=0; i<myform.idxFlag.length; i++) {
      if(myform.idxFlag[i].checked) idxSelectArray += myform.idxFlag[i].value + "/";
    }
  	if(idxSelectArray == '') {
  		alert("등급을 변경할 항목을 1개 이상 선택하세요");
  		return false;
  	}
  	
    idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
    let query = {
  		  idxSelectArray : idxSelectArray,
  		  levelSelect : levelSelect
    }
    
    $.ajax({
  	  url  : "${ctp}/admin/member/memberLevelSelectCheck",
  	  type : "post",
  	  data : query,
  	  success:function(res) {
  		  if(res != "0") {
  			  alert("선택한 항목들이 "+levelSelectText+"(으)로 변경되었습니다.");
				  location.reload();
  		  }
  		  else alert("등급변경 실패~");
			  location.reload();
  	  },
  	  error : function() {
  		  alert("전송 실패~~");
  	  }
    });
  }
</script>
</head>
<body>
	<!-- Begin Page Content -->
  <div class="container-fluid">

	  <!-- Page Heading -->
	  <h1 class="h3 mb-2 text-gray-800">전체회원리스트</h1>
	  <p class="mb-4">체크 박스로 회원 등급을 쉽게 변경 하실 수 있습니다.</p>
	
	  <!-- DataTales Example -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">회원관리테이블</h6>
        <div class="mt-3 d-flex">
			    <div class="mr-auto"><input type="checkbox" name="userInfor" id="userInfor" onclick="userCheck()" /> 비공개회원만보기/전체보기</div>
			    <div class="text-right">
			      <select name="levelItem" id="levelItem" onchange="levelItemCheck()">
			        <option value="99"   ${level >= 4  ? "selected" : ""}>등급별보기</option>
			        <option value="99"   ${level >= 4  ? "selected" : ""}>전체보기</option>
			        <option value="1"    ${level == 1 ? "selected"  : ""}>우수회원</option>
			        <option value="2"    ${level == 2 ? "selected"  : ""}>정회원</option>
			        <option value="3"    ${level == 3 ? "selected"  : ""}>준회원</option>
			        <option value="999"  ${level == 999 ? "selected": ""}>탈퇴신청회원</option>
			        <option value="0"    ${level == 0 ? "selected"  : ""}>관리자</option>
			      </select>
			    </div>
			  </div>
			  <hr/>
			  <div>
		    	<label for="checkAll">
		    		<input type="checkbox"  name="checkAll" id="checkAll" onclick="checkAll()"/> 전체회원 선택
		    	</label>
		    	<label for="checkReverse">
		    		<input type="checkbox" name="checkReverse" id="checkReverse" onclick="checkReverse()"/> 선택반전
		    	</label>
		      <select name="levelSelect" id="levelSelect">
		        <option value="2">정회원</option>
		        <option value="3">준회원</option>
		        <option value="1">우수회원</option>
		      </select>
		      <input type="button" value="선택등급변경" onclick="levelSelectCheck()" class="btn btn-warning btn-sm" />
		    </div>
      </div>
      <div class="card-body">
        <div class="table-responsive">
        	<p class="text-right">(총회원수 : ${totRecCnt}명)</p>
        	<form name="myform">
	          <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	            <thead>
	              <tr>
	                <th>번호</th>
	                <th>아이디</th>
	                <th>닉네임</th>
	                <th>이름</th>
	                <th>생일</th>
	                <th>성별</th>
	                <th>최종방문일</th>
	                <th>총방문횟수</th>
	                <th>활동여부</th>
	                <th>등급</th>
	              </tr>
	            </thead>
	            <tbody id="userDispaly1">
		            <c:forEach var="vo" items="${vos}" varStatus="st">
		            	<c:if test="${vo.userInfor == '공개' || (vo.userInfor != '공개' && sLevel == 0)}">
						        <c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"/></c:if>
						        <c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"/></c:if>
			              <tr>
			                <td>
			                	<c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
							          <c:if test="${vo.level == 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
							          ${vo.idx}
			                </td>
			                <td>${vo.mid}</td>
							        <td>${vo.nickName}</td>
							        <td>${vo.name}</td>
							        <td>${fn:substring(vo.birthday,0,10)}</td>
							        <td>${vo.gender}</td>
							        <td>${fn:substring(vo.lastDate,0,16)}</td>
							        <td>${vo.todayCnt}</td>
							        <td>
							          <c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if>
							          <c:if test="${vo.userDel != 'OK'}">${active}</c:if>
							          <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
							            (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')">30일경과</a>)
							          </c:if>
							        </td>
							        <td>
						            <c:if test="${vo.level != 0}">
								          <!-- <form name="levelForm"> -->
								          	<select name="level" id="level" onchange="levelChange(this)">
								          	  <option value="3/${vo.idx}"  ${vo.level == 3  ? "selected" : ""}>준회원</option>
								          	  <option value="2/${vo.idx}"  ${vo.level == 2  ? "selected" : ""}>정회원</option>
								          	  <option value="1/${vo.idx}"  ${vo.level == 1  ? "selected" : ""}>우수회원</option>
								          	  <option value="0/${vo.idx}"  ${vo.level == 0  ? "selected" : ""}>관리자</option>
								          	  <option value="99/${vo.idx}" ${vo.level == 99 ? "selected" : ""}>탈퇴신청회원</option>
								          	</select>
								          <!-- </form> -->
						          	</c:if>
						          	<c:if test="${vo.level == 0}">관리자</c:if>
							        </td>
			              </tr>
			            </c:if>
			          </c:forEach>
		          </tbody>
	            <!-- 비공개회원S -->
	            <tbody id="userDispaly2" style="display:none;">
	            	<c:forEach var="vo" items="${vos}" varStatus="st">
			            <c:if test="${vo.userInfor == '비공개'}">
			            	<c:if test="${vo.userDel == 'OK'}"><c:set var="active" value="탈퇴신청"/></c:if>
						        <c:if test="${vo.userDel != 'OK'}"><c:set var="active" value="활동중"/></c:if>
			              <tr>
			                <td>
			                	<c:if test="${vo.level != 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}"/></c:if>
							          <c:if test="${vo.level == 0}"><input type="checkbox" name="idxFlag" id="idxFlag${vo.idx}" value="${vo.idx}" disabled /></c:if>
							          ${vo.idx}
			                </td>
			                <td>${vo.mid}</td>
							        <td>${vo.nickName}</td>
							        <td>${vo.name}</td>
							        <td>${fn:substring(vo.birthday,0,10)}</td>
							        <td>${vo.gender}</td>
							        <td>${fn:substring(vo.lastDate,0,10)}</td>
							        <td>${vo.todayCnt}</td>
							        <td>
							          <c:if test="${vo.userDel == 'OK'}"><font color="red"><b>${active}</b></font></c:if>
							          <c:if test="${vo.userDel != 'OK'}">${active}</c:if>
							          <c:if test="${vo.userDel == 'OK' && vo.deleteDiff >= 30}"><br/>
							            (<a href="javascript:memberDeleteOk('${vo.idx}','${vo.photo}')">30일경과</a>)
							          </c:if>
							        </td>
							        <td>
						            <c:if test="${vo.level != 0}">
								          <!-- <form name="levelForm"> -->
								          	<select name="level" id="level" onchange="levelChange(this)">
								          	  <option value="1/${vo.idx}"  ${vo.level == 3  ? "selected" : ""}>준회원</option>
								          	  <option value="2/${vo.idx}"  ${vo.level == 2  ? "selected" : ""}>정회원</option>
								          	  <option value="3/${vo.idx}"  ${vo.level == 1  ? "selected" : ""}>우수회원</option>
								          	  <option value="0/${vo.idx}"  ${vo.level == 0  ? "selected" : ""}>관리자</option>
								          	  <option value="99/${vo.idx}" ${vo.level == 99 ? "selected" : ""}>탈퇴신청회원</option>
								          	</select>
								          <!-- </form> -->
						          	</c:if>
						          	<c:if test="${vo.level == 0}">관리자</c:if>
							        </td>
			              </tr>
			            </c:if>
		            </c:forEach>
		          </tbody>
	            <!-- 비공개회원E -->
	            
	            
	          </table>
	        </form>
          <!-- 페이지처리 시작(이전/다음) -->
          <div class="text-center">
		  	    <c:if test="${pag > 1}">
		  	    	<a href="${ctp}/admin/member/memberList?pag=1&pageSize=${pageSize}" title="첫페이지">◁◁</a>
		  	    	<a href="${ctp}/admin/member/memberList?pag=${pag-1}&pageSize=${pageSize}" title="이전페이지">◀</a>
		  	    </c:if>
		  	    ${pag}/${totPage}
		  	    <c:if test="${pag < totPage}">
		  	    	<a href="${ctp}/admin/member/memberList?pag=${pag+1}&pageSize=${pageSize}" title="다음페이지">▶</a>
		  	    	<a href="${ctp}/admin/member/memberList?pag=${totPage}&pageSize=${pageSize}" title="마지막페이지">▷▷</a>
		  	    </c:if>
		  	  </div>
		  	  <!-- 페이지처리 끝(이전/다음) -->
        </div>
      </div>
	  </div>

  </div>
  <!-- /.container-fluid -->

</body>
</html>