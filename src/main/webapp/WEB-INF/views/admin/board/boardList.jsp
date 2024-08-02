<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<script>
	'use strict';
	
	function boardDelete(idx, tableName){
		let ans = confirm("선택하신 게시판을 삭제하시겠습니까?");
		if(!ans) return false;
		$.ajax({
			url : "${ctp}/admin/board/boardDelete",
			type : "post",
			data : { idx : idx, tableName : tableName },
			success : function(res){
				if(res != "0"){
					alert("선택하신 게시판이 삭제 되었습니다.");
					location.reload();
				}
				else{
					alert("게시판 삭제 실패");
				}
			},
			error : function(){
				alert("전송실패~~");
			}
		});
	}
</script>
</head>
<body>
	<!-- Begin Page Content -->
  <div class="container-fluid">

	  <!-- Page Heading -->
	  <h1 class="h3 mb-2 text-gray-800">게시판 관리</h1>
	
	  <!-- DataTales Example -->
	  <div class="card shadow mb-4">
      <div class="card-header pt-3">
      	<h6 class="m-0 font-weight-bold text-primary">게시판 리스트</h6>
        <div class="mt-3 d-flex">
				  <div class="input-group">
			      <input type="button" value="게시판생성" onclick="location.href='${ctp}/admin/board/boardCreate'" class="btn btn-primary" />
			    </div>
			    <div class="text-right ml-auto">
			      <select name="levelItem" id="levelItem" onchange="levelItemCheck()">
			        <option value="">타입별보기</option>
			        <option value="1"    ${level == 1 ? "selected"  : ""}>일반게시판</option>
			        <option value="2"    ${level == 2 ? "selected"  : ""}>포토갤러리</option>
			        <option value="3"    ${level == 3 ? "selected"  : ""}>자료실</option>
			      </select>
			    </div>
			  </div>
      </div>
      <div class="card-body">
        <div class="table-responsive">
        	<p class="text-right">(총게시판수 : ${totRecCnt}개)</p>
        	<form name="myform">
	          <table class="table table-bordered table-hover text-center" id="dataTable" width="100%" cellspacing="0">
	            <thead>
	              <tr>
	                <th>번호</th>
	                <th>테이블명</th>
	                <th>게시판이름</th>
	                <th>타입</th>
	                <th>카테고리</th>
	                <th>생성일</th>
	                <th>삭제</th>
	              </tr>
	            </thead>
	            <tbody>
		            <c:forEach var="vo" items="${vos}" varStatus="st">
			            <tr>
		                <td>${vo.idx}</td>
		                <td>${vo.tableName}</td>
		                <td><a href="${ctp}/board/boardList?boardName=${vo.tableName}">${vo.boardName}</a></td>
		                <td>${vo.boardType}</td>
		                <td>${vo.category}</td>
		                <td>${fn:substring(vo.CDate,0,16)}</td>
		                <td><a href="javascript:boardDelete(${vo.idx},'${vo.tableName}')" class="btn btn-danger btn-circle btn-sm" title="게시판 삭제"><i class="fas fa-trash" aria-hidden="true"></i></a></td>
		              </tr>
			          </c:forEach>
		          </tbody>
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