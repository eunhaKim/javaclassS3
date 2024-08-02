package com.spring.javaclassS3.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS3.vo.MemberVO;
import com.spring.javaclassS3.vo.BoardListVO;

public interface AdminService {

	public int getMemberTotRecCnt(int level);

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	public int setMemberLevelCheck(int idx, int level);

	public int setMemberDeleteOk(int idx);

	public String setLevelSelectCheck(String idxSelectArray, int levelSelect);

	public int getBoardNameCheck(String boardName);

	public int getTableNameCheck(String tableName);

	public int setBoardCreate(BoardListVO vo);

	public List<BoardListVO> getBoardList(int startIndexNo, int pageSize);

	public int getboardListTotRecCnt();

	public int setboardDelete(int idx, String tableName);

}
