package com.spring.javaclassS3.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS3.vo.MemberVO;
import com.spring.javaclassS3.vo.BoardListVO;

public interface AdminDAO {

	public int getMemberTotRecCnt(@Param("level") int level);

	public ArrayList<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int level);

	public int setMemberDeleteOk(@Param("idx") int idx);

	public int getBoardNameCheck(@Param("boardName") String boardName);

	public int getTableNameCheck(@Param("tableName") String tableName);

	public int setBoardCreate(@Param("vo") BoardListVO vo);

	public List<BoardListVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getboardListTotRecCnt();

	public int setboardDelete(@Param("idx") int id, @Param("tableName") String tableName);

}
