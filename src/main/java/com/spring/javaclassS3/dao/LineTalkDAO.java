package com.spring.javaclassS3.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS3.vo.LineTalkVO;

public interface LineTalkDAO {

	public int lineTalkInput(@Param("mid") String mid, @Param("chat") String chat);

	public ArrayList<LineTalkVO> getLineTalkList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setLineTalkDelete(@Param("idx") int idx);

	public int getTotRecCnt();

}
