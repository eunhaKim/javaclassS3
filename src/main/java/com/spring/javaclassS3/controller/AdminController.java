package com.spring.javaclassS3.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS3.common.JavaclassProvide;
import com.spring.javaclassS3.service.AdminService;
import com.spring.javaclassS3.service.MemberService;
import com.spring.javaclassS3.vo.BoardListVO;
import com.spring.javaclassS3.vo.ProductVO;
import com.spring.javaclassS3.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
		
	@Autowired
	JavaclassProvide javaclassProvide;
	
	// 관리자 메인
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	// 회원리스트
	@RequestMapping(value="/member/memberList", method=RequestMethod.GET)
	public String memberListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "99", required = false) int level
		) {
		int totRecCnt = adminService.getMemberTotRecCnt(level);
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		ArrayList<MemberVO> vos = adminService.getMemberList(startIndexNo, pageSize, level);
		
		model.addAttribute("vos", vos);
		model.addAttribute("totRecCnt", totRecCnt);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "admin/member/memberList";
	}
	
	// 회원 등급 변경하기
	@ResponseBody
	@RequestMapping(value="/member/memberLevelChange", method=RequestMethod.POST)
	public String memberLevelChangePost(int idx, int level) {
		return adminService.setMemberLevelCheck(idx, level) + "";
	}
	
	//선택한 회원 전체적으로 등급 변경하기
	@ResponseBody
	@RequestMapping(value = "/member/memberLevelSelectCheck", method = RequestMethod.POST)
	public String memberLevelSelectCheckPost(String idxSelectArray, int levelSelect) {
		return adminService.setLevelSelectCheck(idxSelectArray, levelSelect);
	}
	
	//선택한 회원 영구 삭제하기
	@ResponseBody
	@RequestMapping(value = "/member/memberDeleteOk", method = RequestMethod.POST)
	public String memberDeleteOkPost(int idx, String photo) {
		// 사진도 함께 삭제처리한다.(noimage.jpg가 아닐경우)
		if(!photo.equals("noimage.jpg")) javaclassProvide.deleteFile(photo, "member");
		return adminService.setMemberDeleteOk(idx) + "";
	}
	
	// 게시판 리스트
	@RequestMapping(value="board/boardList", method=RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
		) {
		int totRecCnt = adminService.getboardListTotRecCnt();
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<BoardListVO> vos = adminService.getBoardList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("totRecCnt", totRecCnt);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);//
		return "admin/board/boardList";
	}
	
	// 게시판 리스트
	@RequestMapping(value="board/boardCreate", method=RequestMethod.GET)
	public String boardCreateGet() {
		return "admin/board/boardCreate";
	}
	
	// 게시판 생성시 이름 중복체크
	@ResponseBody
	@RequestMapping(value="/board/boardNameCheck", method=RequestMethod.POST)
	public String boardNameCheckPost(String boardName) {
		return adminService.getBoardNameCheck(boardName)+"";
	}
	
	// 게시판 생성시 테이블명 중복체크
	@ResponseBody
	@RequestMapping(value="/board/tableNameCheck", method=RequestMethod.POST)
	public String tableNameCheckPost(String tableName) {
		return adminService.getTableNameCheck(tableName)+"";
	}
	
	// 게시판 생성 - Validator를 사용한 BackEnd Check
	@RequestMapping(value="board/boardCreate", method=RequestMethod.POST)
	public String boardCreatePost(@Validated BoardListVO vo, BindingResult bindingResult) {
		if(bindingResult.hasFieldErrors()) {
			System.out.println("error 발생");
			System.out.println("에러 : " + bindingResult );
			return "redirect:/message/boardCreateNo";
		}
		
		int res = adminService.setBoardCreate(vo);
		
		if(res != 0) return "redirect:/message/boardCreateOk";
		else return "redirect:/message/boardCreateNo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/boardDelete", method=RequestMethod.POST)
	public String boardDeletePost(int idx, String tableName) {
		return adminService.setboardDelete(idx,tableName)+"";
	}
	
	
	//샘플 - 빈화면
	@RequestMapping(value="/sample/blankPage", method=RequestMethod.GET)
	public String blankPageGet() {
		return "admin/sample/blankPage";
	}
	
	//샘플 - 404
	@RequestMapping(value="/sample/404", method=RequestMethod.GET)
	public String sample404Get() {
		return "admin/sample/404";
	}
	
	//샘플 - chart
	@RequestMapping(value="/sample/charts", method=RequestMethod.GET)
	public String chartsGet() {
		return "admin/sample/charts";
	}
	
	//샘플 - tables
	@RequestMapping(value="/sample/tables", method=RequestMethod.GET)
	public String tablesGet() {
		return "admin/sample/tables";
	}
	
	//샘플 - main - dashboard
	@RequestMapping(value="/sample/dashboard", method=RequestMethod.GET)
	public String dashboardGet() {
		return "admin/sample/dashboard";
	}
	
	//샘플 - buttons
	@RequestMapping(value="/sample/buttons", method=RequestMethod.GET)
	public String buttonsGet() {
		return "admin/sample/buttons";
	}
	
	//샘플 - cards
	@RequestMapping(value="/sample/cards", method=RequestMethod.GET)
	public String cardsGet() {
		return "admin/sample/cards";
	}
	
	//샘플 - colors
	@RequestMapping(value="/sample/colors", method=RequestMethod.GET)
	public String colorsGet() {
		return "admin/sample/colors";
	}
	
	//샘플 - borders
	@RequestMapping(value="/sample/borders", method=RequestMethod.GET)
	public String bordersGet() {
		return "admin/sample/borders";
	}
	
	//샘플 - animations
	@RequestMapping(value="/sample/animations", method=RequestMethod.GET)
	public String animationsGet() {
		return "admin/sample/animations";
	}
	
	//샘플 - other
	@RequestMapping(value="/sample/other", method=RequestMethod.GET)
	public String otherGet() {
		return "admin/sample/other";
	}
}
