package com.spring.javaclassS3.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS3.dao.LineTalkDAO;
import com.spring.javaclassS3.vo.LineTalkVO;
@Service
public class LineTalkServiceImpl implements LineTalkService {
	
	@Autowired
	LineTalkDAO lineTalkDAO;

	@Override
	public int lineTalkInput(String mid, String chat) {
		return lineTalkDAO.lineTalkInput(mid, chat);
	}

	@Override
	public ArrayList<LineTalkVO> getLineTalkList(int startIndexNo, int pageSize) {
		return lineTalkDAO.getLineTalkList(startIndexNo, pageSize);
	}

	@Override
	public int setLineTalkDelete(int idx) {
		return lineTalkDAO.setLineTalkDelete(idx);
	}

	@Override
	public int getTotRecCnt() {
		return lineTalkDAO.getTotRecCnt();
	}

}
