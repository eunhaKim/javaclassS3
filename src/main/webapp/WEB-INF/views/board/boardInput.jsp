<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardContent.jsp</title>
<script src="${ctp}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.js"></script>
<script>
	var sel_files = []; // 선택된 이미지리스트 저장소
	let totFileSize = 0; // 선택된 이미지리스트 총사이즈
	let maxSize = 1024 *1024 * 20; // 기본단위 : Byte, 총크기 20MByte 허용
	
	function fCheck(){
		
		var formData = new FormData(document.getElementById('myform'));
		
		// FormData 객체를 수동으로 채우는 과정에서, <textarea>와 같은 일부 입력 필드가 빠질 수 있습니다. 
		// 그럴땐 content 값을 FormData에 추가하는 코드를 명시적으로 작성해줘야 합니다.
	  formData.set('content', CKEDITOR.instances.CKEDITOR.getData());
		
		// 선택된 이미지리스트 파일을 FormData 객체에 넣어주는 부분
		formData.set('file', null); // 중복을 없애기 위해
    for (var i = 0; i < sel_files.length; i++) {
        formData.append('file', sel_files[i]); // 파일 하나씩 추가해주는 부분
    }
		
		// Fetch API는 특정 URL로 네트워크 요청을 보내는 비동기 함수. 특정 서버로부터 데이터를 받아올 때 많이 사용함.
    fetch('${ctp}/board/boardInput?boardName=${boardName}', {
        method: 'POST',
        body: formData
    }).then(response => {
        // 서버 응답 처리
        alert('업로드 성공:', response);
        location.href='${ctp}/board/boardList?boardName=${boardName}';
    }).catch(error => {
        alert('업로드 실패:', error);
    });
	}
	
	$(document).ready(function(){
		( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
		  imageView = function imageView(att_zone, btn){

		    var attZone = document.getElementById(att_zone);
		    var btnAtt = document.getElementById(btn)
		    
		    
		    // 이미지와 엑스버튼를 감싸고 있는 div 속성
		    var div_style = 'display:inline-block;position:relative;'
		                  + 'width:100px;height:80px;margin:5px;z-index:1';
		    // 미리보기 이미지 속성
		    var img_style = 'width:100%;height:100%;border-radius:5px;z-index:none';
		    // 이미지안에 표시되는 엑스버튼의 속성
		    var chk_style = 'position:absolute;font-size:18px;line-height:1.2;font-weight:bold;border:0;border-radius:50%;'
		                  + 'right:0px;bottom:0px;z-index:999;background-color:rgba(255,0,0,0.8);color:#fff;';
		  
		    btnAtt.onchange = function(e){
		      // console.log("파일선택 버튼 클릭시 이미지 체크 시작!");
		      var files = e.target.files;
		      
		      if(imgCheck(files)){ // 이미지 체크 통과시 이미지를 리스트에 넣고 뿌려준다.
					  for(f of files) imageLoader(f);
		      }
		    }  
		    
		  
		    // 탐색기에서 드래그앤 드롭 사용
		    attZone.addEventListener('dragenter', function(e){
		      e.preventDefault();
		      e.stopPropagation();
		    }, false)
		    
		    attZone.addEventListener('dragover', function(e){
		      e.preventDefault();
		      e.stopPropagation();
		      
		    }, false)
		  
		    attZone.addEventListener('drop', function(e){
		    	// console.log("파일드로그앤드롭시 이미지 체크 시작!");
		      var files = {};
		      e.preventDefault();
		      e.stopPropagation();
		      var dt = e.dataTransfer;
		      files = dt.files;
		      
		      if(imgCheck(files)){ // 이미지 체크 통과시 이미지를 리스트에 넣고 뿌려준다.
					  for(f of files) imageLoader(f);
		      }
		      
		    }, false)
		    
		    /* 이미지 체크(갯수, 총용량) */
		    imgCheck = function(files){
				      
			    let fileLength = sel_files.length + files.length;	// 선택한 파일의 갯수
			    // console.log("파일들의 갯수: " + fileLength);
					if(fileLength > 5) {
			   		alert("리스트 이미지는 5개까지만 등록 가능합니다.");
			   		return false;
			   	}
					
					let totFileSize2 = totFileSize;
			  
				  for(f of files){
					  let fileName = f.name;		// 선택된 1개의 파일이름가져오기
						// console.log(fileName);
						let ext = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase(); // 확장자만가져오기
			    	if(ext != 'jpg' && ext != 'gif' && ext != 'png' && ext != 'tiff') {
			    		alert("업로드 가능한 파일은 'jpg/gif/png/tiff'만 가능합니다.");
			    		return false;
			    	}
			    	totFileSize2 += f.size;
			    	// console.log("totFileSize2 : " + totFileSize2);
			    	if(totFileSize2 > maxSize) {
				   		alert("업로드 파일의 최대용량은 20MByte입니다.");
				   		return false;
				   	}
				  }
		    	totFileSize = totFileSize2; // 선택된 이미지 총 사이즈 업데이트
		    	$("#totFileSize").html(" <i class='fa-solid fa-floppy-disk'></i> 선택된 이미지 총사이즈 : " + totFileSize.toLocaleString() + "Byte");
				  return true;
		    }
		    

		    
		    /*첨부된 이미리들을 배열에 넣고 미리보기 */
		    imageLoader = function(file){
		      sel_files.push(file);
		      var reader = new FileReader();
		      reader.onload = function(ee){
		        let img = document.createElement('img')
		        img.setAttribute('style', img_style)
		        img.src = ee.target.result;
		        attZone.appendChild(makeDiv(img, file));
		      }
		      
		      reader.readAsDataURL(file);
		    }
		    
		    /*첨부된 파일이 있는 경우 엑스버튼와 함께 attZone에 추가할 div를 만들어 반환 */
		    makeDiv = function(img, file){
		      var div = document.createElement('div')
		      div.setAttribute('style', div_style)
		      
		      var btn = document.createElement('input')
		      btn.setAttribute('type', 'button')
		      btn.setAttribute('value', 'X')
		      btn.setAttribute('delFile', file.name);
		      btn.setAttribute('style', chk_style);
		      btn.onclick = function(ev){
		        var ele = ev.srcElement;
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
		        btnAtt.files = dt.files;
		        var p = ele.parentNode;
		        attZone.removeChild(p)
		      }
		      div.appendChild(img)
		      div.appendChild(btn)
		      return div
		    }
		  }
		)('att_zone', 'btnAtt')
	});
</script>
<style>
	.writeMember {margin-bottom:5px; }
	.writeMember img { width:30px; height:30px; object-fit: cover; margin-right:10px; border-radius: 50%; }
	.cke_notification_warning {display:none;}
	#att_zone{
		width: 100%;
		min-height:100px;
		padding:10px;
		border:1px dashed var(--bs-primary);
		border-radius: 10px;
		margin:5px 0 1px;
		background: #f8f8f8;
		text-align:center;
	}
	#att_zone:empty:before{
		color : #999;
		content : attr(data-placeholder);
		content:"\f03e";
    font-size: 3em;
    font-family: FontAwesome;
    display:block;
	}
	#att_zone:empty:after{
		color : #999;
		content : attr(data-placeholder);
    font-size: .8em;
	}
	#totFileSize { margin: 5px 0 10px; text-align: center; font-size: 14px; color: var(--bs-primary); }
	.cont_write_info {background:#f8f8f8; text-align:center; padding:12px 0 1px; margin:0px 0 20px; border:1px solid #d1d1d1; border-top: 0}
</style>
</head>
<body>
<!-- Single Product Start -->
  <div class="container-fluid pt-3 pb-5">
    <div class="container py-5">
      <ol class="breadcrumb justify-content-start mb-4">
        <li class="breadcrumb-item"><a href="${ctp}/main">Home</a></li>
        <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
        <li class="breadcrumb-item active text-dark"><a href="${ctp}/board/boardList?boardName=${boardName}">${boardName}</a></li>
      </ol>
      <div class="row g-4">
      	<!-- 게시물등록 START -->
      	<div class="boardInput">
	        <form name="myform" id="myform" method="post" enctype="multipart/form-data">
	          <div class="writeMember">
	          	<a><img src="${ctp}/memberImg/${vo.photo}" alt="${vo.nickName}}">${vo.nickName}</a>
	          </div>
	          <div class="title">
	           <input type="text" name="title" id="title" placeholder="제목을 입력해주세요" class="form-control mb-3" required />
	          </div>
	      		<div id='image_preview'>
					    <label for="file"><i class="fa-solid fa-file-import text-success"></i> 리스트이미지 등록 : </label>
					    <input type='file' name="file" id='btnAtt' multiple='multiple' class="form-control-file" accept=".jpg,.gif,.png,.tiff" />
    					<div id='att_zone' data-placeholder='파일을 첨부 하시려면 파일 선택 버튼을 클릭하시거나 파일을 드래그앤드롭 하세요.'></div>
					    <div id="totFileSize"></div>
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
			      <div class="cont_write_info"><p><i class="fa-solid fa-face-smile-wink"></i> 게시글 작성 시 회원님의 소중한 개인정보가 포함되지 않도록 주의 부탁 드립니다.</p></div>
			      <div class="cont_btn text-center">
			      	<input type="button" value="글쓰기" onclick="fCheck()" class="btn btn-primary mr-2"/>
			        <input type="button" value="목록보기" onclick="location.href='boardList?boardName=${boardName}';" class="btn btn-secondary"/>
			      </div>
			      <input type="hidden" name="mid" value="${sMid}"/>
						<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	        </form>
	      </div>
    	<!-- 게시물등록 END -->
   		</div>
	 	</div>
	</div>
<!-- Single Product End -->
</body>
</html>