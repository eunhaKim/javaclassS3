<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<link rel="stylesheet" href="${ctp}/css/ai.css">
</head>
<body>
<!-- container Start -->
<div class="container-fluid pt-3 pb-5">
  <div class="container py-5">
    <ol class="breadcrumb justify-content-start mb-4 ml-3">
      <li class="breadcrumb-item"><a href="${ctp}/"><i class="fa-solid fa-house"></i> Home</a></li>
      <li class="breadcrumb-item"><a href="#">커뮤니티</a></li>
      <li class="breadcrumb-item active text-dark">AI 약초이미지 검색</li>
    </ol>
    <div class="bg-light rounded p-5 mobileBox">
    	<h2>약초 이미지 검색</h2>
    	<hr/>
			<p class="text-center"> 
				<a href="https://teachablemachine.withgoogle.com/train/image/1YXjJRZ0nw4I01bc9Us39TUKPin8WXEuF" target="_blank" class="btn btn-sm btn-success">학습경로 바로가기</a>
			</p>
			<!-- <button type="button" onclick="init()">Start</button> -->
			<div id="upload-area" class="area">
				<span class="guide-image">📷</span>
				<p>사진을 올려놓거나 눌러서 업로드해 주세요!</p>
				<input id="upload-input" style="display:none" type="file" accept="image/*" onchange="readFile(this.files[0]);"/>
			</div>
			<div id="loading-area" class="area" style="display:none;">
				<span class="guide-image">🏃 ‍~~</span>
				<p>인공지능 모델을 불러오는 중입니다...</p>
			</div>
			<div id="result-area" class="area" style="display:none;">
				<img id="upload-image" src="#" alt="your image"/>
				<div id="label-container"></div>
			</div>
			<div id="retry-area" class="area bg-primary text-white" style="display:none;">
				<span>다른 사진으로 테스트 하려면 Click!!</span>
			</div>
		</div>
	</div>
	<!-- <div id="webcam-container"></div> -->
	<!-- <div id="label-container"></div> -->
	<script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest/dist/tf.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@teachablemachine/image@latest/dist/teachablemachine-image.min.js"></script>
	<script type="text/javascript">
	    // More API functions here:
	    // https://github.com/googlecreativelab/teachablemachine-community/tree/master/libraries/image
	
	    // the link to your model provided by Teachable Machine export panel
	    const URL = "https://teachablemachine.withgoogle.com/models/zcnEYe4Sn/";
	    
	
	    let model, /* webcam,*/ labelContainer, maxPredictions;
	    let isModelReady = false;
      let input = document.getElementById("upload-input");
      let image = document.getElementById("upload-image");
      let uploadArea = document.getElementById("upload-area");
      let loadingArea = document.getElementById("loading-area");
      let resultArea = document.getElementById("result-area");
      let retryArea = document.getElementById("retry-area");
      const reader = new FileReader();
	    
	 		// 로딩중
      async function readFile(file){
        uploadArea.style.display = "none";
        if(isModelReady === false){
          loadingArea.style.display = "block";
          await init();
        }
        reader.readAsDataURL(file);
      }

      //결과페이지
      reader.onload = async function(event){
        await image.setAttribute('src',event.target.result);
        await predict();
        loadingArea.style.display = "none";
        resultArea.style.display = "block";
        retryArea.style.display = "block";
      }

      uploadArea.onclick = function(){
        input.click();
      }

      uploadArea.ondragover = function(){
        event.preventDefault();
      }

      uploadArea.ondrop = function(event){
        event.preventDefault();
        const file = event.dataTransfer.files[0];
        readFile(file);
      }

      retryArea.onclick = function(){
        retryArea.style.display = "none";
        resultArea.style.display ="none";
        uploadArea.style.display = "block";
        input.value = "";
      }
	
   		// Load the image model and setup the webcam
      async function init() {
          const modelURL = URL + "model.json";
          const metadataURL = URL + "metadata.json";
  
          // load the model and metadata
          // Refer to tmImage.loadFromFiles() in the API to support files from a file picker
          // or files from your local hard drive
          // Note: the pose library adds "tmImage" object to your window (window.tmImage)
          model = await tmImage.load(modelURL, metadataURL);
          maxPredictions = model.getTotalClasses();
  
          
          labelContainer = document.getElementById("label-container");
          for (let i = 0; i < maxPredictions+1; i++) { // and class labels
              labelContainer.appendChild(document.createElement("div"));
          }
      }
	
	    /* async function loop() {
	        webcam.update(); // update the webcam frame
	        await predict();
	        window.requestAnimationFrame(loop);
	    } */
	
	    // run the webcam image through the image model
	    async function predict() {
	        // predict can take in an image, video or canvas html element
	        /* const prediction = await model.predict(webcam.canvas); */
	        const prediction = await model.predict(image);
	        prediction.sort((x,y) => y.probability - x.probability);
	        
	        switch(prediction[0].className){
	        case "송이버섯":
	        	labelContainer.childNodes[0].innerHTML = "<h3>송이버섯이네요!</h3>";
	        	break;
	        case "능이버섯":
	        	labelContainer.childNodes[0].innerHTML = "<h3>능이버섯이네요!</h3>";
	        	break;
	        case "싸리버섯":
	        	labelContainer.childNodes[0].innerHTML = "<h3>싸리버섯이네요!</h3>";
	        	break;
	        case "표고버섯":
	        	labelContainer.childNodes[0].innerHTML = "<h3>표고버섯이네요!</h3>";
	        	break;
	        case "인삼":
	        	labelContainer.childNodes[0].innerHTML = "<h3>인삼이네요!</h3>";
	        	break;
	        case "산삼":
	        	labelContainer.childNodes[0].innerHTML = "<h3>산삼이네요!</h3>";
	        	break;
	        case "두릅":
	        	labelContainer.childNodes[0].innerHTML = "<h3>두릅이네요!</h3>";
	        	break;
	        case "더덕":
	        	labelContainer.childNodes[0].innerHTML = "<h3>더덕이네요!</h3>";
	        	break;
	        case "고사리":
	        	labelContainer.childNodes[0].innerHTML = "<h3>고사리네요!</h3>";
	        	break;
	        case "머위":
	        	labelContainer.childNodes[0].innerHTML = "<h3>머위네요!</h3>";
	        	break;
	        case "쑥":
	        	labelContainer.childNodes[0].innerHTML = "<h3>쑥이네요!</h3>";
	        	break;
	        case "산마늘":
	        	labelContainer.childNodes[0].innerHTML = "<h3>산마늘이네요!</h3>";
	        	break;
	        default:
            labelContainer.childNodes[0].innerHTML = "<h3></h3>";
	        }
	        for (let i = 0; i < maxPredictions; i++) {
              const classPrediction =
                  prediction[i].className + ": " + Math.round(prediction[i].probability*100)+"%";
              labelContainer.childNodes[i+1].innerHTML = classPrediction;
          }
          isModelReady = true;
	    }
	</script>
	
</body>
</html>