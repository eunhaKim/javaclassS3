package com.spring.javaclassS3.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaclassS3.dao.AdminDAO;
import com.spring.javaclassS3.vo.MemberVO;
import com.spring.javaclassS3.vo.BoardListVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int getMemberTotRecCnt(int level) {
		return adminDAO.getMemberTotRecCnt(level);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public int setMemberDeleteOk(int idx) {
		return adminDAO.setMemberDeleteOk(idx);
	}

	@Override
	public String setLevelSelectCheck(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		int res = 0;
		for(String idx : idxSelectArrays) {
			res += adminDAO.setMemberLevelCheck(Integer.parseInt(idx), levelSelect);
		}
		return ((int) res/idxSelectArrays.length)+"";
	}

	@Override
	public int getBoardNameCheck(String boardName) {
		return adminDAO.getBoardNameCheck(boardName);
	}

	@Override
	public int getTableNameCheck(String tableName) {
		return adminDAO.getTableNameCheck(tableName);
	}

	@Transactional
	@Override
	public int setBoardCreate(BoardListVO vo) {
		return adminDAO.setBoardCreate(vo);
	}

	@Override
	public List<BoardListVO> getBoardList(int startIndexNo, int pageSize) {
		return adminDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public int getboardListTotRecCnt() {
		return adminDAO.getboardListTotRecCnt();
	}

	@Transactional
	@Override
	public int setboardDelete(int idx, String tableName) {
		return adminDAO.setboardDelete(idx, tableName);
	}
	
}
