package com.spring.javaclassS3.service;

import java.util.ArrayList;

import com.spring.javaclassS3.vo.LineTalkVO;

public interface LineTalkService {

	public int lineTalkInput(String mid, String chat);

	public ArrayList<LineTalkVO> getLineTalkList(int startIndexNo, int pageSize);

	public int setLineTalkDelete(int idx);

	public int getTotRecCnt();

}
