package com.spring.javaclassS3.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS3.vo.BoardReplyVO;
import com.spring.javaclassS3.vo.BoardVO;

public interface BoardDAO {

	public int setBoardInput(@Param("vo") BoardVO vo, @Param("boardName") String boardName);

	public ArrayList<BoardVO> getBoardList(@Param("boardName") String boardName, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize,@Param("part") String part);

	public void setReadNumPlus(@Param("boardName") String boardName, @Param("idx") int idx);

	public BoardVO getBoardContent(@Param("boardName") String boardName, @Param("idx")int idx);

	public int setBoardDelete(@Param("boardName") String boardName, @Param("idx") int idx);

	public int setBoarddelListImg(@Param("boardName") String boardName, @Param("vo") BoardVO vo);

	public int setBoardUpdate(@Param("boardName") String boardName, @Param("vo") BoardVO vo);

	public int setBoardGoodCheck(@Param("boardName") String boardName, @Param("idx")int idx);

	public BoardReplyVO getBoardParentReplyCheck(@Param("replyVO") BoardReplyVO replyVO);

	public int setBoardReplyInput(@Param("replyVO") BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(@Param("boardName") String boardName, @Param("idx")int idx);

	public int setBoardReplyDelete(@Param("idx") int idx);

	public void setReplyOrderUpdate(@Param("boardIdx") int boardIdx, @Param("re_order") int re_order);

	public int setBoardReplyUpdate(@Param("replyVO") BoardReplyVO replyVO);

	public int totRecCnt(@Param("sectionName") String sectionName);

	public int totRecCntSearch(@Param("sectionName") String sectionName, @Param("search") String search, @Param("searchString") String searchString);

	public List<BoardVO> getBoardList2(@Param("boardName") String boardName, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

}
