package com.spring.javaclassS3.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS3.vo.BoardReplyVO;
import com.spring.javaclassS3.vo.BoardVO;

public interface BoardService {

	public int setBoardInput(BoardVO vo, String boardName);

	public void imgCheck(String content);

	public ArrayList<BoardVO> getBoardList(String boardName, int startIndexNo, int pageSize, String part);

	public void setReadNumPlus(String boardName, int idx);

	public BoardVO getBoardContent(String boardName, int idx);

	public BoardVO setListImgUpload(MultipartHttpServletRequest mFile, BoardVO vo);
	
	public BoardVO setListImgUpload2(MultipartHttpServletRequest mFile, BoardVO vo, BoardVO origVo);

	public void imgDelete(String content);

	public int setBoardDelete(String boardName, int idx);

	public void imgBackup(String content);

	public int setBoarddelListImg(String boardName, BoardVO vo);

	public int setBoardUpdate(String boardName, BoardVO vo);

	public int setBoardGoodCheck(String boardName, int idx);

	public BoardReplyVO getBoardParentReplyCheck(BoardReplyVO replyVO);

	public int setBoardReplyInput(BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(String boardName, int idx);

	public int setBoardReplyDelete(int idx);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public int setBoardReplyUpdate(BoardReplyVO replyVO);

	public Map<String, Integer> analyzer(String content);

	public List<BoardVO> getBoardList2(String boardName, int startIndexNo, int pageSize, String mid);

}
