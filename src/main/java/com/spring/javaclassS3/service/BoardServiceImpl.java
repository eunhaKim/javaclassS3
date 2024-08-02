package com.spring.javaclassS3.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaclassS3.common.JavaclassProvide;
import com.spring.javaclassS3.dao.BoardDAO;
import com.spring.javaclassS3.vo.BoardReplyVO;
import com.spring.javaclassS3.vo.BoardVO;
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public int setBoardInput(BoardVO vo, String boardName) {
		return boardDAO.setBoardInput(vo, boardName);
	}

	//content에 이미지가 있다면 이미지를 'ckeditor'폴더에서 'board'폴더로 복사처리한다.
	@Override
	public void imgCheck(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS3/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS3/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 32;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "board/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] b = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(b)) != -1) {
				fos.write(b, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<BoardVO> getBoardList(String boardName, int startIndexNo, int pageSize, String part) {
		return boardDAO.getBoardList(boardName, startIndexNo, pageSize, part);
	}

	@Override
	public void setReadNumPlus(String boardName, int idx) {
		boardDAO.setReadNumPlus(boardName, idx);
	}

	@Override
	public BoardVO getBoardContent(String boardName, int idx) {
		return boardDAO.getBoardContent(boardName, idx);
	}

	@Override
	public BoardVO setListImgUpload(MultipartHttpServletRequest mFile, BoardVO vo) {
		// 리스트 이미지파일 업로드
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
			
				javaclassProvide.writeFile(file, sFileName, "board");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
		} catch (IOException e) { e.printStackTrace(); }
		
		return vo;
	}
	
	@Override
	public BoardVO setListImgUpload2(MultipartHttpServletRequest mFile, BoardVO vo, BoardVO origVo) {
		// 리스트 이미지파일 수정시 추가업로드
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			
			if(origVo.getFName() != null && origVo.getFName() != "") {
				oFileNames = origVo.getFName() + "/";
				sFileNames = origVo.getFSName() + "/";
			}
			
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				String sFileName = javaclassProvide.saveFileName(oFileName);
				javaclassProvide.writeFile(file, sFileName, "board");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
		} catch (IOException e) { e.printStackTrace(); }
		
		return vo;
	}

	@Override
	public void imgDelete(String content) {
		//  							0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS3/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS3/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
		String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
		
		String origFilePath = realPath + "board/" + imgFile;
		
		fileDelete(origFilePath);	// board폴더의 그림파일 삭제한다.
		
		if(nextImg.indexOf("src=\"/") == -1) sw = false;
		else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}
	
	//서버에 존재하는 파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardDelete(String boardName, int idx) {
		return boardDAO.setBoardDelete(boardName, idx);
	}

	@Override
	public void imgBackup(String content) {
		//                0         1         2         3
		//                01234567890123456789012345678901234567890
		// <p><img alt="" src="/javaclassS3/data/board/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		// <p><img alt="" src="/javaclassS3/data/ckeditor/240626093722_5.jpg" style="height:433px; width:700px" /></p>
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "board/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 board폴더위치로 복사처리하는 메소드.
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
	}

	@Override
	public int setBoarddelListImg(String boardName, BoardVO vo) {
		return boardDAO.setBoarddelListImg(boardName, vo);
	}

	@Override
	public int setBoardUpdate(String boardName, BoardVO vo) {
		return boardDAO.setBoardUpdate(boardName, vo);
	}

	@Override
	public int setBoardGoodCheck(String boardName, int idx) {
		return boardDAO.setBoardGoodCheck(boardName, idx);
	}

	@Override
	public BoardReplyVO getBoardParentReplyCheck(BoardReplyVO replyVO) {
		return boardDAO.getBoardParentReplyCheck(replyVO);
	}

	@Override
	public int setBoardReplyInput(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<BoardReplyVO> getBoardReply(String boardName, int idx) {
		return boardDAO.getBoardReply(boardName, idx);
	}

	@Override
	public int setBoardReplyDelete(int idx) {
		return boardDAO.setBoardReplyDelete(idx);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		boardDAO.setReplyOrderUpdate(boardIdx, re_order);
	}

	@Override
	public int setBoardReplyUpdate(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyUpdate(replyVO);
	}
	
	@Override
	public Map<String, Integer> analyzer(String content) {
		int wordFrequenciesToReturn = 10;
		int minWordLength = 2;
		
		Map<String, Integer> frequencyMap = new HashMap<>();
		
		String[] words = content.split("\\s+");
		
		for(String word : words) {
			if(word.length() >= minWordLength) {
				word = word.toLowerCase();
				frequencyMap.put(word, frequencyMap.getOrDefault(word, 0) + 1);
			}
		}
		
    return frequencyMap.entrySet().stream()
        .sorted((e1, e2) -> e2.getValue().compareTo(e1.getValue()))
        .limit(wordFrequenciesToReturn)
        .collect(HashMap::new, (m, e) -> m.put(e.getKey(), e.getValue()), HashMap::putAll);
	}

	@Override
	public List<BoardVO> getBoardList2(String boardName, int startIndexNo, int pageSize, String mid) {
		return boardDAO.getBoardList2(boardName, startIndexNo, pageSize, mid);
	}


}
