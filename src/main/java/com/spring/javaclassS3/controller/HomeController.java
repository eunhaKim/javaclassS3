package com.spring.javaclassS3.controller;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.DataFlavor;
import java.awt.datatransfer.Transferable;
import java.awt.event.KeyEvent;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS3.service.BoardService;
import com.spring.javaclassS3.service.LineTalkService;
import com.spring.javaclassS3.service.ShopService;
import com.spring.javaclassS3.vo.BoardVO;
import com.spring.javaclassS3.vo.LineTalkVO;
import com.spring.javaclassS3.vo.ProductVO;

@Controller
public class HomeController {
	
	@Autowired
	LineTalkService lineTalkService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ShopService shopService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// 메인 홈화면
	@RequestMapping(value = {"","/h","/main"}, method = RequestMethod.GET)
	public String homeGet(Locale locale, Model model,HttpServletRequest request) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		// 메인 화면 상단 라인톡 출력
		List<LineTalkVO> LineTalkVOS = lineTalkService.getLineTalkList(lineTalkService.getTotRecCnt()-4, 4);
		model.addAttribute("LineTalkVOS",LineTalkVOS);
		
		// 메인 자연인 Mart 최신글 가져오기
		List<ProductVO> productCatAVOS = shopService.getProductList("A", "0");
		List<ProductVO> productCatBVOS = shopService.getProductList("B", "0");
		List<ProductVO> productCatCVOS = shopService.getProductList("C", "0");
		model.addAttribute("productCatAVOS",productCatAVOS);
		model.addAttribute("productCatBVOS",productCatBVOS);
		model.addAttribute("productCatCVOS",productCatCVOS);
		
		// 노하우공유 최신글 가져오기
		List<BoardVO> knowhowVOS = boardService.getBoardList("knowhow", 0, 5, "전체");
		model.addAttribute("knowhowVOS",knowhowVOS);
		
		// 자연인 토지 & 집 매매 최신글 가져오기
		List<BoardVO> realtyVOS = boardService.getBoardList("realty", 0, 5, "전체");
		model.addAttribute("realtyVOS",realtyVOS);
		
    
		
		return "home";
	}
	
	// about - 사이트 소개 페이지 연결
	@RequestMapping(value="/pages/about", method=RequestMethod.GET)
	public String pageAboutGet() {
		return "pages/about";
	}
	
	// video - 동영상 크롤링 모음
	@RequestMapping(value="/pages/movie", method=RequestMethod.GET)
	public String pageMovieGet(HttpServletRequest request, Model model) {
		// 크롤링해서 유튜브 동영상 가져오기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/crawling/");
		// ChromeDriver 경로 설정
		System.setProperty("webdriver.chrome.driver", realPath + "chromedriver.exe");
		
		// WebDriver 초기화
		WebDriver driver = new ChromeDriver();
		driver.get("https://www.youtube.com/playlist?list=PLCcVVysKhhY0eD4VNONTWc3noij8bc-ZM");
		
		// 페이지 로딩 대기
		try { Thread.sleep(2000); } catch (Exception e) {}
		
		// 동영상 요소 찾기
    List<WebElement> videoElements = driver.findElements(By.cssSelector("ytd-playlist-video-renderer"));

    List<String> videoTitles = new ArrayList<>();
    List<String> videoUrls = new ArrayList<>();

    for (WebElement videoElement : videoElements) {
        // 동영상 제목 가져오기
        String title = videoElement.findElement(By.cssSelector("#video-title")).getText();
        // 동영상 URL 가져오기
        String url = videoElement.findElement(By.cssSelector("#video-title")).getAttribute("href");

        videoTitles.add(title);
        videoUrls.add(url.substring(url.indexOf("v=")+2).replace("&list", "?list"));
    }

    // 결과 출력
    for (int i = 0; i < videoTitles.size(); i++) {
        System.out.println("Title: " + videoTitles.get(i));
        System.out.println("URL: " + videoUrls.get(i));
        System.out.println();
    }

    // 브라우저 종료
    driver.quit();
    model.addAttribute("videoTitles",videoTitles);
    model.addAttribute("videoUrls",videoUrls);
		return "pages/movie";
	}
	
	// ckeditor에서 파일(이미지)를 업로드시키기위한 처리부분
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		// MultipartFile 타입은 ckedit에서 upload란 이름으로 저장하게 된다
		
		response.setCharacterEncoding("utf-8"); // 한글깨짐을 방지하기위해 문자셋 설정
		response.setContentType("text/html; charset=utf-8"); // 마찬가지로 파라미터로 전달되는 response 객체의 한글 설정
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename(); // 업로드한 파일 이름
		
		// 파일명 중복방지를 위한 이름 설정하기(날짜로 분류처리...)
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(upload.getBytes()); // 서버로 업로드. write메소드의 매개값으로 파일의 총 바이트를 매개값으로 준다. 파일을 바이트 배열로 변환해서 출력 스트립에 쓴다 (출력하기 위해서)
		
		PrintWriter out = response.getWriter(); // 서버=>클라이언트로 텍스트 전송
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}
	
	@RequestMapping(value = "/fileDownAction", method = RequestMethod.GET)
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
		String file = request.getParameter("file");
		
		if(path.equals("pds")) path += "/temp/";
		
		String realPathFile = request.getSession().getServletContext().getRealPath("/resources/data/" + path) + file;
		
		File downFile = new File(realPathFile);
		String downFileName = new String(file.getBytes("UTF-8"), "8859_1");
		response.setHeader("Content-Disposition", "attachment;filename=" + downFileName);
		
		FileInputStream fis = new FileInputStream(downFile);
		ServletOutputStream sos = response.getOutputStream();
		
		byte[] bytes = new byte[2048];
		int data;
		while((data = fis.read(bytes, 0, bytes.length)) != -1) {
			sos.write(bytes, 0, data);
		}
		sos.flush();
		sos.close();
		fis.close();
		
		// 다운로드 완료후에 서버에 저장된 zip파일을 삭제처리한다.
		downFile.delete();
	}
	
	// 지도들어간 페이지 샘플
	@RequestMapping(value="/board/mapSample", method=RequestMethod.GET)
	public String mapSample() {
		return "board/mapSample";
	}
	
	// 404 페이지 샘플
	@RequestMapping(value="/error", method=RequestMethod.GET)
	public String errorPage() {
		return "error";
	}
	
	// ai - 약초 이미지 검색하기
	@RequestMapping(value="/ai", method=RequestMethod.GET)
	public String aiGet() {
		return "ai/ai";
	}
}
