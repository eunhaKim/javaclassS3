package com.spring.javaclassS3.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS3.service.LineTalkService;
import com.spring.javaclassS3.service.MemberService;
import com.spring.javaclassS3.vo.LineTalkVO;

@Controller
@RequestMapping("/lineTalk")
public class LineTalkController {
	
	@Autowired
	LineTalkService lineTalkService;
	
	@Autowired
	MemberService memberService;
	
	// 한줄수다 메인 페이지
	@RequestMapping(value="/lineTalk", method=RequestMethod.GET)
	public String lineTalkGet() {
		
		return "lineTalk/lineTalk";
	}
	
	// 한줄수다 리스트출력
	@RequestMapping(value="/lineTalkList", method=RequestMethod.GET)
	public String lineTalkListGet(Model model,
			@RequestParam(name="pag", defaultValue="1", required=false)int pag) {
		
		int pageSize = 5;
		int totRecCnt = lineTalkService.getTotRecCnt();
		int startIndexNo = totRecCnt-pageSize*pag;
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		
		ArrayList<LineTalkVO> vos = lineTalkService.getLineTalkList(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("totPage", totPage);
		return "lineTalk/lineTalkList";
	}
	
	@ResponseBody
	@RequestMapping(value="/lineTalkList", method=RequestMethod.POST)
	public ArrayList<LineTalkVO> lineTalkListPost(Model model, int pag) {
		int totRecCnt = lineTalkService.getTotRecCnt();
		int pageSize = 5;
		pageSize = (totRecCnt-pageSize*pag) >= 0 ? 5 : totRecCnt % pageSize;
		int startIndexNo = pageSize < 5 ? 0 :(totRecCnt-pageSize*pag);
		
		return lineTalkService.getLineTalkList(startIndexNo, pageSize);
	}
	
	// 한줄수다 입력
	@ResponseBody
	@RequestMapping(value="/lineTalkInput", method=RequestMethod.POST)
	public String lineTalkInputPost(String chat, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		chat = chat.replace("<", "&lt;").replace(">", "&gt;");
		
		return lineTalkService.lineTalkInput(mid,chat)+"";
	}
	
	// 한줄수다 삭제
	@ResponseBody
	@RequestMapping(value="/lineTalkDelete", method=RequestMethod.POST)
	public String lineTalkDeletePost(int idx) {
		return lineTalkService.setLineTalkDelete(idx)+"";
	}

}
