<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>footer.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<!-- Footer Start -->
<div class="container-fluid bg-dark footer py-5">
    <div class="container py-5">
        <div class="pb-4 mb-4" style="border-bottom: 1px solid rgba(255, 255, 255, 0.08);">
            <div class="row g-4">
                <div class="col-lg-3">
                    <a href="#" class="d-flex flex-column flex-wrap">
                        <img src="${ctp}/img/footerLogo.png" alt="하단로고" width="170px"/>
                    </a>
                </div>
                <div class="col-lg-9">
                	<form action="${ctp}/board/knowhowSearch" method="post" name="knowhowSearch">
                    <div class="d-flex position-relative rounded-pill overflow-hidden">
                        <input class="form-control border-0 w-100 py-3 rounded-pill" type="text" name="searchStr" placeholder="노하우 게시판 검색하기">
                        <button type="submit" class="btn btn-primary border-0 py-3 px-5 rounded-pill text-white position-absolute" style="top: 0; right: 0;">노하우 검색</button>
                    </div>
                  </form>
                </div>
            </div>
        </div>
        <div class="row g-5">
            <div class="col-lg-6 col-xl-3">
                <div class="footer-item-1">
                    <h4 class="mb-4 text-white">Get In Touch</h4>
                    <p class="text-secondary line-h">Address: <span class="text-white">충북 청주시 흥덕구</span></p>
                    <p class="text-secondary line-h">Email: <span class="text-white">ara419@naver.com</span></p>
                    <p class="text-secondary line-h">Phone: <span class="text-white">010-2622-0194</span></p>
                    <div class="d-flex line-h mt-5">
                        <a class="btn btn-light me-2 btn-md-square rounded-circle" href=""><i class="fab fa-twitter text-dark"></i></a>
                        <a class="btn btn-light me-2 btn-md-square rounded-circle" href=""><i class="fab fa-facebook-f text-dark"></i></a>
                        <a class="btn btn-light me-2 btn-md-square rounded-circle" href=""><i class="fab fa-youtube text-dark"></i></a>
                        <a class="btn btn-light btn-md-square rounded-circle" href=""><i class="fab fa-linkedin-in text-dark"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-xl-3">
                <div class="footer-item-2">
                    <div class="d-flex flex-column mb-4">
                        <h4 class="mb-4 text-white">나도 자연인</h4>
                        <a href="${ctp}/pages/about">
                            <div class="d-flex align-items-center">
                                <div class="rounded-circle border border-2 border-primary overflow-hidden">
                                    <img src="${ctp}/img/footer-1.jpg" class="img-zoomin img-fluid rounded-circle w-100" alt="">
                                </div>
                                <div class="d-flex flex-column ps-4">
                                    <p class="text-uppercase text-white mb-3">사이트소개</p>
                                    <a href="${ctp}/pages/about" class="h6 text-white" style="word-break:keep-all;">
                                        가진 것 없어도 행복하다! 자연에서 찾는 나...
                                    </a>
                                    <small class="text-white d-block"><a href="${ctp}/pages/about">자세히보기+</a></small>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-xl-3">
                <div class="d-flex flex-column text-start footer-item-3">
                    <h4 class="mb-4 text-white">Community</h4>
                    <a href="${ctp}/board/boardList?boardName=knowhow" class="btn-link text-white"><i class="fas fa-angle-right text-white me-2"></i> 자연인 노하우</a>
                    <a href="${ctp}/board/boardList?boardName=realty" class="btn-link text-white"><i class="fas fa-angle-right text-white me-2"></i> 토지&집매매</a> 
                    <a href="${ctp}/board/boardList?boardName=freeboard" class="btn-link text-white"><i class="fas fa-angle-right text-white me-2"></i> 자유게시판</a>
                </div>
            </div>
            <div class="col-lg-6 col-xl-3">
                <div class="d-flex flex-column text-start footer-item-3">
                    <h4 class="mb-4 text-white">자연인 Mart</h4>
                    <a class="btn-link text-white" href=""><i class="fas fa-angle-right text-white me-2"></i> 생존필수템</a>
                    <a class="btn-link text-white" href=""><i class="fas fa-angle-right text-white me-2"></i> 낭만템</a>
                    <a class="btn-link text-white" href=""><i class="fas fa-angle-right text-white me-2"></i> 비상식량</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Copyright Start -->
<div class="container-fluid copyright bg-dark py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                <span class="text-light"><a href="#"><i class="fas fa-copyright text-light me-2"></i>나도 자연인</a>, All right reserved.</span>
            </div>
            <div class="col-md-6 my-auto text-center text-md-end text-white">
                <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
                Designed By <a class="border-bottom" href="https://htmlcodex.com/demo/?item=3179" target="_blank">HTML Codex</a>
            </div>
        </div>
    </div>
</div>
<!-- Copyright End -->


<!-- Back to Top -->
<a href="#" class="btn btn-primary border-2 border-white rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   


<!-- JavaScript Libraries -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${ctp}/lib/easing/easing.min.js"></script>
<script src="${ctp}/lib/waypoints/waypoints.min.js"></script>
<script src="${ctp}/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="${ctp}/js/main.js"></script>

</body>
</html>