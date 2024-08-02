package com.spring.javaclassS3.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS3.dao.BoardDAO;
import com.spring.javaclassS3.dao.ShopDAO;
import com.spring.javaclassS3.vo.PageVO;

@Service   
public class PageProcess {
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	ShopDAO shopDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String sectionName, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt(sectionName);
			else {
				search = part;
				totRecCnt = boardDAO.totRecCntSearch(sectionName, search, searchString);
			}
		}
		else if(section.equals("dbMyOrder")) {
			String mid = part;
			totRecCnt = shopDAO.totRecCnt(mid);
		}
		else if(section.equals("myOrderStatus")) {
			String mid = part;
			String[] searchStringArr = searchString.split("@");
			totRecCnt = shopDAO.totRecCntMyOrderStatus(mid,searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		else if(section.equals("adminDbOrderProcess")) {
			String[] searchStringArr = searchString.split("@");
			totRecCnt = shopDAO.totRecCntAdminStatus(searchStringArr[0],searchStringArr[1],searchStringArr[2]);
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearh(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
				
		return pageVO;
	}
}
