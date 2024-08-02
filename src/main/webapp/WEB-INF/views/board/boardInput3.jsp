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
		let file = "";
		file = document.getElementById("file").value;
		if(file.trim() == "") {
   		alert("업로드할 파일을 선택하세요");
   		return false;
   	}
		let fileLength = 0;
		fileLength = document.getElementById("file").files.length;	// 선택한 파일의 갯수
		if(fileLength < 1) {
   		alert("업로드할 파일을 선택하세요");
   		return false;
   	}
		console.log(file, " : ", fileLength);	
		
		let ext = "";
		let fileSize = 0;
		let maxSize = 1024 *1024 * 20; // 기본단위 : Byte, 20MByte 허용
		
		for(let i=0; i<fileLength; i++) {
			file = document.getElementById("file").files[i].name;		// 선택된 1개의 파일이름가져오기
			// console.log(file);
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
   		//myform.submit();
   	}
	}
</script>
<style>
	.boardList { border-bottom: 1px solid #dee2e6; padding-bottom:40px; margin-bottom:30px;}
	.boardList:last-child { border-bottom: 0;}
	.writeMember {margin-bottom:5px; }
	.writeMember img { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
	.cke_notification_warning {display:none;}
	#fileBox{
		width: 100%;
		min-height:100px;
		padding:10px;
		border:1px dashed var(--bs-primary);
		border-radius: 10px;
		margin:5px 0 15px;
		background: #f4f6f8;
	}
	#fileBox:empty:before{
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
	      		<div id='image_preview'>
					    <label for="file"><i class="fa-solid fa-file-import text-success"></i> 리스트이미지 등록 : </label>
					    <input type='file' id='file' multiple='multiple' />
					    <div id='fileBox'
					      data-placeholder='리스트 이미지 파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그 앤 드롭 하세요'></div>
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
<script>
// 드래그 앤 드롭 방식 파일 첨부와 여러개 선택된 이미지 출력
( /* fileBox : 이미지들이 들어갈 위치 id, btn : file tag id */
  imageView = function imageView(fileBox, btn){

    var fileBox = document.getElementById(fileBox);
    var file = document.getElementById(btn)
    var sel_files = [];
    
    // 이미지와 체크 박스를 감싸고 있는 div 속성
    var div_style = 'display:inline-block; position:relative;'
                  + 'width:100px; height:80px; margin:5px; z-index:1';
    // 미리보기 이미지 속성
    var img_style = 'width:100%; height:100%; z-index:none';
    // 이미지안에 표시되는 닫기버튼의 스타일
    var close_style = 'position:absolute; font-size:14px; font-weight:bold; line-height:1.3; border:0; border-radius: 50%;'
                  + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,0,0,0.8);color:#fff';
  
    file.onchange = function(e){
      var files = e.target.files;
      var fileArr = Array.prototype.slice.call(files)
      for(f of fileArr){
        imageLoader(f);
      }
    }  
    
  
    // 탐색기에서 드래그앤 드롭 사용
    fileBox.addEventListener('dragenter', function(e){
      e.preventDefault(); // dragenter의 기본동작(새창에서 이미지띄위기)을 중단시킨다.
      e.stopPropagation(); // 이벤트가 상위 엘리먼트에 전달되지 않게 막아 준다.
    }, false)
    
    fileBox.addEventListener('dragover', function(e){
      e.preventDefault();
      e.stopPropagation();
      
    }, false)
  
    fileBox.addEventListener('drop', function(e){
      var files = {};
      e.preventDefault();
      e.stopPropagation();
      var dt = e.dataTransfer;
      files = dt.files;
      for(f of files){
        imageLoader(f);
      }
      
      // 기존파일에 추가해 주는 부분
      
			if(document.getElementById("file").value.trim() != "") {
				console.log("기존파일에 추가해주자");
				fileLength = document.getElementById("file").files.length;	// 선택한 파일의 갯수
				for(let i=0; i<fileLength; i++) {
					dt.items.add(document.getElementById("file").files[i]);
				}
	   	}
      
      document.getElementById("file").files=dt.files;
      //document.getElementById("file").files = files;
    }, false)
    

    
    /*첨부된 이미리들을 배열에 넣고 미리보기 */
    imageLoader = function(file){
      sel_files.push(file);
      var reader = new FileReader();
      reader.onload = function(ee){
        let img = document.createElement('img')
        img.setAttribute('style', img_style)
        img.src = ee.target.result;
        fileBox.appendChild(makeDiv(img, file));
      }
      
      reader.readAsDataURL(file);
    }
    
    /*첨부된 파일이 있는 경우 닫기버튼과 함께 fileBox에 추가할 div를 만들어 반환  */
    makeDiv = function(img, file){
      var div = document.createElement('div')
      div.setAttribute('style', div_style)
      
      var btn = document.createElement('input')
      btn.setAttribute('type', 'button')
      btn.setAttribute('value', 'X')
      btn.setAttribute('delFile', file.name);
      btn.setAttribute('style', close_style);
      btn.onclick = function(ev){ // 삭제 버튼을 누르면 이미지를 박스에서 제거한다.
        var ele = ev.srcElement; // event.srcElement : 이벤트가 발생한 개체를 반화/설정
        var delFile = ele.getAttribute('delFile');
        for(var i=0 ;i<sel_files.length; i++){
          if(delFile== sel_files[i].name){
            sel_files.splice(i, 1);      
          }
        }
        
        dt = new DataTransfer();
        for(f in sel_files) {
          var file = sel_files[f];
          dt.items.add(file);
        }
        file.files = dt.files;
        var p = ele.parentNode;
        fileBox.removeChild(p)
      }
      div.appendChild(img)
      div.appendChild(btn)
      return div
    }
  }
)('fileBox', 'file')

</script>
</html>