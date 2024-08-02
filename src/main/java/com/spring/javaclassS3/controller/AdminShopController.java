package com.spring.javaclassS3.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS3.service.MemberService;
import com.spring.javaclassS3.service.ShopService;
import com.spring.javaclassS3.vo.OptionVO;
import com.spring.javaclassS3.vo.ProductVO;

@Controller
@RequestMapping("/admin/shop")
public class AdminShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	MemberService memberService;
	
	// 상품 카테고리 관리 페이지 
	@RequestMapping(value="/shopCategory", method=RequestMethod.GET)
	public String shopCategoryGet(Model model) {
		ArrayList<ProductVO> category1Vos = shopService.getCategory1List();
		ArrayList<ProductVO> category2Vos = shopService.getCategory2List();
		ArrayList<ProductVO> category3Vos = shopService.getCategory3List();
		
		model.addAttribute("category1Vos", category1Vos);
		model.addAttribute("category2Vos", category2Vos);
		model.addAttribute("category3Vos", category3Vos);
		return "admin/shop/shopCategory";
	}
	
	// 상품 카테고리 등록 - category1
	@ResponseBody
	@RequestMapping(value="/category1Input", method=RequestMethod.POST)
	public String category1InputPost(ProductVO vo) {
		// 기존에 생성된 대분류코드명이 같은게 있는지 체크
		ProductVO pVo = shopService.getCategory1One(vo);
		if(pVo != null) return "0";
		// 기존에 생성된 대분류명이 같은게 있는지 체크
		pVo = shopService.getCategory1OneAfter(vo);
		if(pVo != null) return "2";
		return shopService.setCategory1Input(vo) + "";
	}
	
	// 상품 카테고리 등록 - category2
	@ResponseBody
	@RequestMapping(value="/category2Input", method=RequestMethod.POST)
	public String category2InputPost(ProductVO vo) {
		// 기존에 생성된 중분류코드명이 같은게 있는지 체크
		ProductVO pVo = shopService.getCategory2One(vo);
		if(pVo != null) return "0";
		// 기존에 생성된 중분류명과 대분류명이 같은게 있는지 체크
		pVo = shopService.getCategory2OneAfter(vo);
		if(pVo != null) return "2";
		return shopService.setCategory2Input(vo) + "";
	}
	
	// 상품 카테고리 등록 - category3
	@ResponseBody
	@RequestMapping(value = "/category3Input", method = RequestMethod.POST)
	public String category3InputPost(ProductVO vo) {
	// 기존에 생성된 중분류코드명이 같은게 있는지 체크
		ProductVO pVo = shopService.getCategory3One(vo);
		if(pVo != null) return "0";
		return shopService.setCategory3Input(vo) + "";
	}
	
	// 상품 카테고리 삭제 - category1
	@ResponseBody
	@RequestMapping(value="/category1Delete", method=RequestMethod.POST)
	public String category1DeletePost(ProductVO vo) {
		// 현재 대분류 아래 하위 항목이 있는지 체크
		ProductVO pVo = shopService.getCategory1One(vo);
		if(pVo.getIdx() != 0) return "0";
		return shopService.setCategory1Delete(vo.getCategory1Code()) + "";
	}
	
	// 상품 카테고리 삭제 - category2
	@ResponseBody
	@RequestMapping(value="/category2Delete", method=RequestMethod.POST)
	public String category2DeletePost(ProductVO vo) {
		// 현재 대분류 아래 하위 항목이 있는지 체크
		ProductVO pVo = shopService.getCategory2One(vo);
		if(pVo.getIdx() != 0) return "0";
		return shopService.setCategory2Delete(vo.getCategory2Code()) + "";
	}
	
	// 상품 카테고리 삭제 - category3
	@ResponseBody
	@RequestMapping(value="/category3Delete", method=RequestMethod.POST)
	public String category3DeletePost(ProductVO vo) {
		System.out.println("상품 카테고리 삭제 - category3");
		return shopService.setCategory3Delete(vo.getCategory3Code()) + "";
	}
	
	// 상품 카테고리 대분류 선택하면 중분류항목 가져오기
	@ResponseBody
	@RequestMapping(value = "/category2Name", method = RequestMethod.POST)
	public List<ProductVO> category2NamePost(String category1Code) {
		return shopService.getCategory2Name(category1Code);
	}
	
	//중분류 선택시에 소분류항목명을 가져오기
	@ResponseBody
	@RequestMapping(value = "/category3Name", method = RequestMethod.POST)
	public List<ProductVO> category3NamePost(String category1Code, String category2Code) {
		return shopService.getCategory3Name(category1Code, category2Code);
	}
	
	// 상품 등록 페이지
	@RequestMapping(value="/product", method=RequestMethod.GET)
	public String productGet(Model model) {
		List<ProductVO> cat1Vos = shopService.getCategory1List();
		model.addAttribute("cat1Vos",cat1Vos);
		return "admin/shop/product";
	}
	
	//상품 등록 처리하기
	@Transactional
	@RequestMapping(value = "/product", method=RequestMethod.POST)
	public String dbProductPost(MultipartFile file, ProductVO vo, String[] optionName, int[] optionPrice) {
		// 이미지파일 업로드시에 ckeditor폴더에서 'shop/product'폴더로 복사처리...후~ 처리된 내용을 DB에 저장하기
		int res = shopService.imgCheckProductInput(file, vo);
		
		// 옵션 등록처리
		OptionVO oVo = new OptionVO();
		for(int i=0; i<optionName.length; i++) {
			// 현재 옵션 이름과 가격을 set시킨후 옵션테이블에 등록처리한다.
			oVo.setProductIdx(shopService.getProductMaxIdx2());
			oVo.setOptionName(optionName[i]);
			oVo.setOptionPrice(optionPrice[i]);
			
			res += shopService.setOptionInput(oVo);
		}
		
		if(res == (1+optionName.length)) return "redirect:/message/productInputOk";
		return "redirect:/message/productInputNo";
	}
	
	//상품 리스트 페이지(관리자화면)
	@RequestMapping(value="/shopList", method=RequestMethod.GET)
	public String shopListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="mainPrice", defaultValue = "0", required = false) String mainPrice){
		List<ProductVO> cat3TitleVOS = shopService.getCat3Title();	// 소분류명을 가져온다.
		model.addAttribute("cat3TitleVOS", cat3TitleVOS);
		model.addAttribute("part", part);

		List<ProductVO> productVOS = shopService.getShopList(part, mainPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("price", mainPrice);
		return "admin/shop/shopList";
	}
	
	//상품 상세 페이지(관리자)
	@RequestMapping(value="/shopContent", method=RequestMethod.GET)
	public String shopContentGet(Model model, int idx) {
		ProductVO pVo = shopService.getShopProduct(idx);
		model.addAttribute("pVo",pVo);
		return "admin/shop/shopContent";
	}
}
