package com.spring.javaclassS3.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="boardName", defaultValue = "All", required = false) String boardName,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
		) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원에 가입되셨습니다. \n로그인해주세요.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원 가입 실패~~");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디 입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 닉네임 입니다.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("memberLoginNewOk")) {
			model.addAttribute("msg", mid+"님 로그인 되셨습니다.\\n신규 비밀번호가 발급되었습니다. 검점후 회원정보를 변경해주세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("kakaoLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되셨습니다.(kakao)");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일 업로드 실패~~");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원 정보가 변경되었습니다.");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원 정보 변경실패~~");
			model.addAttribute("url", "/member/memberUpdate");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속하실수 있습니다.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "회원 로그인후 사용하세요");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLevelNo")) {
			model.addAttribute("msg", "회원 등급을 확인하세요.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("multiFileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드 되었습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		}
		else if(msgFlag.equals("multiFileUploadNo")) {
			model.addAttribute("msg", "파일 업로드 실패~~");
			model.addAttribute("url", "/study/fileUpload/multiFile");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList?boardName="+boardName);
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시글 등록 실패~~");
			model.addAttribute("url", "/board/boardInput?boardName="+boardName);
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제 되었습니다.");
			model.addAttribute("url", "/board/boardList?boardName="+boardName);
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제 실패~~~");
			model.addAttribute("url", "/board/boardContent?boardName="+boardName+"&idx="+idx);
		}
		else if(msgFlag.equals("boardCreateOk")) {
			model.addAttribute("msg","새로운 게시판이 생성되었습니다.");
			model.addAttribute("url", "/admin/board/boardList");
		}
		else if(msgFlag.equals("boardCreateNo")) {
			model.addAttribute("msg","새로운 게시판 생성실패~~~");
			model.addAttribute("url", "/admin/board/boardCreate");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "/admin/shop/shopList");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "상품 등록 실패~~");
			model.addAttribute("url", "/admin/shop/product");
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "/shop/cartList");
		}
		else if(msgFlag.equals("cartOrderNo")) {
			model.addAttribute("msg", "장바구니에 상품 등록실패");
			model.addAttribute("url", "/shop/cartList");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결재가 성공적으로 완료되었습니다.");
			model.addAttribute("url", "/shop/paymentResultOk");
		}
		
		return "include/message";
	}
	
}
