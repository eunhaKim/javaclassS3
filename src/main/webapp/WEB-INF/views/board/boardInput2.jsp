<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script>
	'use strict';
	
	function imgCheck(e){
		if(e.files && e.files[0]){
			$(".noImg").hide();
			let reader = new FileReader();
			reader.onload = function(e){
				document.getElementById("photoDemo").src = e.target.result;
			}
			reader.readAsDataURL(e.files[0]);
		}
		else {
			$(".noImg").show();
		}
	}
	
	function fCheck(){
		let file = $("#file").val();
		let fileLength = document.getElementById("file").files.length;	// 선택한 파일의 갯수
    	
		if(file.trim() == ""){
			alert("업로드할 파일을 선택하세요.");
			return false;
		}
		else if(fileLength < 1) {
   		alert("업로드할 파일을 선택하세요");
   		return false;
   	}
		
		let ext = "";
		let fileSize = 0;
		let maxSize = 1024 *1024 * 20; // 기본단위 : Byte, 20MByte 허용
		
		for(let i=0; i<fileLength; i++) {
			file = document.getElementById("file").files[i].name;		// 선택된 1개의 파일이름가져오기
   		ext = file.substring(file.lastIndexOf(".")+1).toLowerCase(); // 확장자만가져오기
    	fileSize += document.getElementById("file").files[i].size;
    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'tiff') {
    		alert("업로드 가능한 파일은 'jpg/gif/png/tiff'만 가능합니다.");
    	}
   	}
   	
   	if(fileSize > maxSize) {
   		alert("업로드 파일의 최대용량은 20MByte입니다.");
   	}
		else {
    	myform.fSize.value = fileSize;
   		myform.submit();
   	}
	}
</script>
<style>
	.boardList { border-bottom: 1px solid #dee2e6; padding-bottom:40px; margin-bottom:30px;}
	.boardList:last-child { border-bottom: 0;}
	.writeMember {margin-bottom:5px; }
	.writeMember img { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
	#att_zone{
		width: 100%;
		min-height:100px;
		padding:10px;
		border:1px solid #ddd;
		border-radius: 10px;
		margin:5px 0 15px;
	}
	#att_zone:empty:before{
		content : attr(data-placeholder);
		color : #999;
		font-size:.9em;
	}
</style>
</head>
<!-- Single Product Start -->
  <div class="container-fluid pt-3 pb-5">
    <div class="container py-5">
      <ol class="breadcrumb justify-content-start mb-4">
        <li class="breadcrumb-item"><a href="#">Home</a></li>
        <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
        <li class="breadcrumb-item active text-dark">${boardName}</li>
      </ol>
      <div class="row g-4">
      	<!-- 게시물등록 START -->
      		<div class="boardList">
           <form name="myform" method="post" class="mb-4" enctype="multipart/form-data">
             <div class="writeMember">
             	<a><img src="${ctp}/member/${vo.photo}" alt="${vo.nickName}}">${vo.nickName}</a>
             </div>
             <div class="title">
              <input type="text" name="title" id="title" placeholder="제목을 입력해주세요" class="form-control mb-3" required />
             </div>
			      <div class="form-group">
			      	<label for="file"><i class="fa-solid fa-image text-primary"></i> 리스트이미지 등록 : </label>
			      	<input type="file" name="file" id="file" multiple class="form-control-file" onchange="imgCheck(this)" accept=".jpg,.gif,.png,.tiff" />
				      <div id="att_zone" data-placeholder="파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요."></div>
				      <!-- <div class=" border rounded p-2 my-2">
				      	<img id="photoDemo" width="100px"/>
				      	<p class="noImg text-center"><i class="fa-solid fa-face-sad-tear"></i> 리스트 이미지를 등록해주세요~~</p>
				      </div> -->
			      </div>
              <div class="editor_area">
               <textarea name="content" id="CKEDITOR" rows="6" class="form-control" required ></textarea>
			        <script>
			          CKEDITOR.replace("content",{
			        	  height:400,
			        	  filebrowserUploadUrl:"${ctp}/imageUpload",	/* 파일(이미지)를 업로드시키기위한 매핑경로(메소드) 홈컨트롤러에 만들어놓음 */
			        	  uploadUrl : "${ctp}/imageUpload"						/* uploadUrl : 여러개의 그림파일을 드래그&드롭해서 올릴수 있다. */
			          });
			        </script>
			      </div>
			      <div class="cont_write_info text-center my-3"><p>게시글 작성 시 회원님의 소중한 개인정보가 포함되지 않도록 주의 부탁 드립니다.</p></div>
			      <div class="cont_btn text-center">
			      	<input type="button" value="글쓰기" onclick="fCheck()" class="btn btn-primary mr-2"/>
		          <input type="reset" value="취소" class="btn btn-warning mr-2"/>
		          <input type="button" value="목록보기" onclick="location.href='boardList?boardName=${boardName}';" class="btn btn-secondary"/>
			      </div>
			      <input type="hidden" name="mid" value="${sMid}"/>
  					<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
  					<input type="hidden" name="fSize" />
           </form>
         </div>
      	<!-- 게시물등록 END -->
        </div>
     </div>
 </div>
  <!-- Single Product End -->
</html>