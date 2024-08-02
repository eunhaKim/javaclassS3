package com.spring.javaclassS3.controller;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kennycason.kumo.CollisionMode;
import com.kennycason.kumo.WordCloud;
import com.kennycason.kumo.WordFrequency;
import com.kennycason.kumo.bg.CircleBackground;
import com.kennycason.kumo.font.KumoFont;
import com.kennycason.kumo.font.scale.LinearFontScalar;
import com.kennycason.kumo.nlp.FrequencyAnalyzer;
import com.kennycason.kumo.nlp.tokenizer.WhiteSpaceWordTokenizer;
import com.kennycason.kumo.palette.ColorPalette;
import com.spring.javaclassS3.common.JavaclassProvide;
import com.spring.javaclassS3.pagination.PageProcess;
import com.spring.javaclassS3.service.BoardService;
import com.spring.javaclassS3.service.MemberService;
import com.spring.javaclassS3.vo.BoardReplyVO;
import com.spring.javaclassS3.vo.BoardVO;
import com.spring.javaclassS3.vo.MemberVO;
import com.spring.javaclassS3.vo.PageVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	// 게시판 목록보기
	@RequestMapping(value="/boardList", method=RequestMethod.GET)
	public String boardListGet(Model model, String boardName,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", boardName, "" , "");
		ArrayList<BoardVO> vos = boardService.getBoardList(boardName,pageVO.getStartIndexNo(),pageSize,part);
		model.addAttribute("vos",vos);
		model.addAttribute("boardName",boardName);
		model.addAttribute("pageVO", pageVO);
		return "board/boardList";
	}
	
	// 게시판 글등록 폼보기
	@RequestMapping(value="/boardInput", method=RequestMethod.GET)
	public String boardInputGet(HttpSession session, Model model, String boardName) {
		MemberVO vo = memberService.getMemberIdCheck(session.getAttribute("sMid").toString());
		model.addAttribute("vo",vo);
		model.addAttribute("boardName",boardName);
		return "board/boardInput";
	}
	
	// 게시판 글등록
	@RequestMapping(value="/boardInput", method=RequestMethod.POST)
	public ResponseEntity<?> boardInputPost(MultipartHttpServletRequest mFile ,BoardVO vo, Model model, String boardName) {
		
		// 1.리스트이미지 처리(파일 업로드, vo에 리스트 이미지 주입)
		if(mFile.getFiles("file").size() >= 1)	vo = boardService.setListImgUpload(mFile, vo);
		
		// 2.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
		
		// 3.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 board폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		
		// 4.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
		int res = boardService.setBoardInput(vo, boardName);
		
		if(res != 0) return ResponseEntity.ok().build();
		else  return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	}
	
	// 게시판 상세보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentPost(int idx, String boardName, Model model, HttpServletRequest request, 
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		// 게시글 조회수 1씩 증가시키기(중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = boardName + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(boardName, idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		BoardVO vo = boardService.getBoardContent(boardName, idx);
		MemberVO mVo = memberService.getMemberIdCheck(session.getAttribute("sMid").toString());
		
		// 댓글(대댓글) 추가 입력처리
		List<BoardReplyVO> replyVos = boardService.getBoardReply(boardName, idx);
		
		// 글쓴이의 다른글
		List<BoardVO> wVos = boardService.getBoardList2(boardName, 0, pageSize, vo.getMid());
		
		model.addAttribute("vo", vo);
		model.addAttribute("mVo", mVo);
		model.addAttribute("wVos", wVos);
		model.addAttribute("boardName", boardName);
		model.addAttribute("replyVos", replyVos);
		
		return "board/boardContent";
	}
	
	// 게시판 삭제
	@RequestMapping(value="/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx, String boardName, HttpServletRequest request,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize) {
		
		BoardVO vo = boardService.getBoardContent(boardName, idx);
		
		// 서버에 저장된 리스트 이미지 실제 파일 삭제처리
		if(vo.getFSName() != null) {
			String[] fSNames = vo.getFSName().split("/");
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/");
			for(int i=0; i<fSNames.length; i++) {
				new File(realPath + fSNames[i]).delete(); // 서버에 저장된 실제 파일을 삭제처리
			}
		}
		
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		// 사진작업을 끝나면 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = boardService.setBoardDelete(boardName, idx);
			
		if(res != 0) return "redirect:/message/boardDeleteOk?boardName="+boardName;
		else return "redirect:/message/boardDeleteNo?boardName="+boardName+"&idx="+idx;
	}
	
	// 게시판 수정폼 보기
	@RequestMapping(value="/boardUpdate", method=RequestMethod.GET)
	public String boardUpdateGet(int idx, String boardName, Model model) {
		// 수정화면으로 이동할시에는 기존 원본파일의 그림파일이 존재한다면, 현재폴더(board)의 그림파일을 ckeditor폴더로 복사시켜준다.
		BoardVO vo = boardService.getBoardContent(boardName, idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgBackup(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("boardName", boardName);
		return "board/boardUpdate";
	}
	
	// 게시판 수정
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public ResponseEntity<Object> boardUpdatePost(MultipartHttpServletRequest mFile, BoardVO vo, int idx, String boardName, Model model) {
		BoardVO origVo = boardService.getBoardContent(boardName, vo.getIdx());
		// 1.리스트이미지 처리(파일 업로드, vo에 리스트 이미지 주입)
		if(mFile.getFiles("file").size() >= 1)	vo = boardService.setListImgUpload2(mFile, vo, origVo);
		else {
			vo.setFName(origVo.getFName());
			vo.setFSName(origVo.getFSName());
		}
		
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다. 즉, DB에 저장된 원본자료를 불러와서 현재 vo에 담긴 내용(content)과 비교해본다.
		// content의 내용이 조금이라도 변경이 되었다면 내용을 수정한것이기에, 그림파일 처리유무를 결정한다.
		if(!origVo.getContent().equals(vo.getContent())) {
			
			// 1.기존 board폴더에 그림이 존재했다면 원본그림을 모두 삭제처리한다.(원본그림은 수정창에 들어오기전에 ckeditor폴더에 저장시켜두었다.)
			if(origVo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(origVo.getContent());
			
			
			// 2.앞의 삭제 작업이 끝나면 'board'폴더를 'ckeditor'로 경로 변경한다.
			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
			
			// 1,2, 작업을 마치면 파일을 처음 업로드한것과 같은 작업처리를 해준다.
			// 즉, content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 '/data/board/'폴더에 복사 저장처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
			
			// 이미지들의 모든 복사작업을 마치면, 폴더명을 'ckeditor'에서 'board'폴더로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
			
		}
		
		// content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
		int res = boardService.setBoardUpdate(boardName, vo);
		
		if(res != 0) return ResponseEntity.ok().build();
		else  return ResponseEntity.status(HttpStatus.BAD_REQUEST).build();
	}
	
	// 게시판 수정폼에서 기존에 등록된 리스트 이미지 삭제
	@ResponseBody
	@RequestMapping(value = "/delListImg", method=RequestMethod.POST)
	public String delListImgPost(int idx, String boardName, String img, int delImgIndex, HttpServletRequest request) {
		// 서버에 저장된 실제 파일을 삭제처리
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/");
		new File(realPath + img).delete(); 
		
		// 디비에 저장된 리스트 이미지 관련부분 수정(fName,fSName)
		BoardVO vo = boardService.getBoardContent(boardName, idx);
		String[] fName = vo.getFName().split("/");
		String[] fSName = vo.getFSName().split("/");
		String newFName = "";
		String newFSName = "";
		if(fName.length > 1) {
			for(int i=0 ; i < fName.length ; i++) {
				if(i == delImgIndex) continue; // 삭제할 인덱스는 건너뜀
				newFName += fName[i]+"/";
				newFSName += fSName[i]+"/";
			}
			vo.setFName(newFName.substring(0,newFName.length()-1));
			vo.setFSName(newFSName.substring(0,newFSName.length()-1));
		}
		else { // 리스트 이미지 파일이 한개인 경우는 파일이 0개가 되므로..
			vo.setFName("");
			vo.setFSName("");
		}
		vo.setIdx(idx);
		int res = boardService.setBoarddelListImg(boardName, vo);
		
		return res+"";
	}
	
	// 좋아요수 증가처리(중복 불허)
	@ResponseBody
	@RequestMapping(value="/boardGoodCheck", method=RequestMethod.POST)
	public String boardGoodCheckPost(int idx, String boardName, HttpServletRequest request) {
		int res = 0;
		HttpSession session = request.getSession();
		ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentGood == null) contentGood = new ArrayList<String>();
		String imsiContentGood = "boardGood" + boardName + idx;
		if(!contentGood.contains(imsiContentGood)) {
			res = boardService.setBoardGoodCheck(boardName, idx);
			contentGood.add(imsiContentGood);
		}
		session.setAttribute("sContentGood", contentGood);
		
		return res + "";
	}
	
	//부모댓글 입력처리(원본글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		// 부모댓글의 경우는 re_step=0, re_order=1로 처리.(단, 원본글의 첫번째 부모댓글은 re_order=1이지만, 2번이상은 마지막부모댓글의 re_order보다 +1처리 시켜준다.
		BoardReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO);
		
		if(replyParentVO == null) { // 기존에 댓글이 없는경우
			replyVO.setRe_order(1);
		}
		else { // 가장 마지막 부모댓글번호 + 1
			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
		}
		replyVO.setRe_step(0);
		replyVO.setContent(replyVO.getContent().replace("<", "&lt;").replace(">", "&gt;"));
		
		int res = boardService.setBoardReplyInput(replyVO);
		
		return res + "";
	}
	
	//대댓글 입력처리(부모댓글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/boardReplyInputRe", method = RequestMethod.POST)
	public String boardReplyInputRePost(BoardReplyVO replyVO) {
		// 대댓글(답변글)의 1.re_step은 부모댓글의 re_step+1, 2.re_order는 부모의 re_order보다 큰 댓글은 모두 +1처리후, 3.자신의 re_order+1시켜준다.
		replyVO.setRe_step(replyVO.getRe_step() + 1);		// 1번처리
		
		boardService.setReplyOrderUpdate(replyVO.getBoardIdx(), replyVO.getRe_order());  // 2번 처리
		
		replyVO.setRe_order(replyVO.getRe_order() + 1);
		replyVO.setContent(replyVO.getContent().replace("<", "&lt;").replace(">", "&gt;"));
		int res = boardService.setBoardReplyInput(replyVO);
		
		return res + "";
	}
	
	// 댓글 수정처리
	@ResponseBody
	@RequestMapping(value="/boardReplyUpdate", method=RequestMethod.POST)
	public String BoardReplyUpdatePost(BoardReplyVO replyVO) {
		replyVO.setContent(replyVO.getContent().replace("<", "&lt;").replace(">", "&gt;"));
		return boardService.setBoardReplyUpdate(replyVO) + "";
	}
	
	
	// 댓글삭제처리
	@ResponseBody
	@RequestMapping(value="/boardReplyDelete", method=RequestMethod.POST)
	public String boardReplyDeletePost(int idx) {
		return boardService.setBoardReplyDelete(idx) + "";
	}
	
	// 상단, 하단  검색
	@RequestMapping(value="/knowhowSearch", method=RequestMethod.POST)
	public String knowhowSearchPost(Model model, String searchStr,
			@RequestParam(name = "boardName", defaultValue = "knowhow", required=false) String boardName,
			@RequestParam(name = "pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", boardName, "content" , searchStr);
		ArrayList<BoardVO> vos = boardService.getBoardList(boardName,pageVO.getStartIndexNo(),pageSize, searchStr);
		model.addAttribute("vos",vos);
		model.addAttribute("boardName",boardName);
		model.addAttribute("searchStr",searchStr);
		model.addAttribute("pageVO", pageVO);
		return "board/boardList";
	}
	
	// wordcloud
	@ResponseBody
	@RequestMapping(value = "/wordcloud/analyzer3", method = RequestMethod.POST)
	public Map<String, Integer> analyzer3Post(HttpServletRequest request,
			String url,
			String selector,
			String excludeWord
		) throws IOException {
		Connection conn = Jsoup.connect(url);
		
		Document document = conn.get();
		Elements selectors = document.select(selector);
		
		int i = 0;
		String str = "";
		for(Element select : selectors) {
			// System.out.println(i + " : " + select.html());
			str += select.html() + "\n";
		}
		
		// 제외할 문자 처리하기(분석에서 제외할 문자처리하기)
		String[] tempStrs = excludeWord.split("/");			// [특종]/[단독]
		for(int k=0; k<tempStrs.length; k++) {
			str = str.replace(tempStrs[i], "");
		}
		
		// 파일로 저장하기(분석문자로 처리된 텍스트형식의 내용물을 지정경로에 저장하기)
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/board/sample2.txt");
		try (FileWriter writer = new FileWriter(realPath)) {
			writer.write(str);
			// System.out.println("파일 생성 Ok");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardService.analyzer(str);	// 텍스트문서를 형태소 분석후 다시 돌려주기
	}
	
}
