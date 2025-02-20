package com.spring.javaclassS3.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS3.common.JavaclassProvide;
import com.spring.javaclassS3.pagination.PageProcess;
import com.spring.javaclassS3.service.MemberService;
import com.spring.javaclassS3.service.ShopService;
import com.spring.javaclassS3.vo.DbBaesongVO;
import com.spring.javaclassS3.vo.DbCartVO;
import com.spring.javaclassS3.vo.DbOrderVO;
import com.spring.javaclassS3.vo.DbPayMentVO;
import com.spring.javaclassS3.vo.MemberVO;
import com.spring.javaclassS3.vo.OptionVO;
import com.spring.javaclassS3.vo.PageVO;
import com.spring.javaclassS3.vo.ProductVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	JavaclassProvide javaclassProvide;
	
	//상품 리스트 페이지
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String productListGet(Model model, 
			@RequestParam(name="cat1", defaultValue = "전체", required = false) String cat1,
			@RequestParam(name="cat2", defaultValue = "전체", required = false) String cat2,
			@RequestParam(name="cat3", defaultValue = "전체", required = false) String cat3,
			@RequestParam(name="mainPrice", defaultValue = "0", required = false) String mainPrice){

		List<ProductVO> productVOS = shopService.getProductList(cat1, mainPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("category1Name", productVOS.get(0).getCategory1Name());
		
		ArrayList<ProductVO> cat1Vos = shopService.getCategory1List();
		ArrayList<ProductVO> cat2Vos = shopService.getCategory2List();
		ArrayList<ProductVO> cat3Vos = shopService.getCategory3List();
		model.addAttribute("cat1Vos",cat1Vos);
		model.addAttribute("cat2Vos",cat2Vos);
		model.addAttribute("cat3Vos",cat3Vos);
		
		model.addAttribute("cat1", cat1);
		
		//if(cat2.equals("전체")) cat2 = shopService.getCategory2First(cat1).getCategory2Code(); 
		if(!cat2.equals("전체")) productVOS = shopService.getProductListCat2(cat2);	// category2 해당 상품리스트 가져오기
		model.addAttribute("cat2", cat2);
		
		// if(cat3.equals("전체")) cat3 = shopService.getCategory3First(cat2).getCategory3Code();
		if(!cat3.equals("전체"))  productVOS = shopService.getProductListCat3(cat3);	// category3 해당 상품리스트 가져오기
		model.addAttribute("cat3", cat3);
		
		model.addAttribute("productVOS", productVOS);
		//model.addAttribute("price", mainPrice);
		return "shop/productList";
	}
	
	//상품 상세 페이지
	@RequestMapping(value="/productContent", method=RequestMethod.GET)
	public String productContentGet(Model model, int idx) {
		ProductVO productVo = shopService.getShopProduct(idx); // 상품의 상세정보 불러오기
		List<OptionVO> optionVos = shopService.getShopOption(idx);	// 옵션의 모든 정보 불러오기
		model.addAttribute("category1Name", shopService.getCategory1One(productVo).getCategory1Name());
		model.addAttribute("productVo", productVo);
		model.addAttribute("optionVos", optionVos);
		return "shop/productContent";
	}
	
	//장바구니 담기 - 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
	@RequestMapping(value="/productContent", method=RequestMethod.POST)
	public String productContentPost(DbCartVO vo, HttpSession session, String flag) {
		String mid = (String) session.getAttribute("sMid");
		// 같은 상품(옵션포함)을 주문했다면 새로운 항목으로 처리하지않고, 기존 상품의 수량만 구매수량만큼 증가처리한다.
		// 여러개의 상품을 구매했다면, optionName은 ','로 구분되어 넘어오게되고, DB에서 같은형식으로 저장처리되어 있다.(여러개의 같은품목을 구매시 배열에 담긴 문자열이 같다.(예:기본품목,리모콘)
		DbCartVO resVo = shopService.getDbCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);	// 지금 구매한 항목을 기존 구매 카트에서와 비교를 위해검색
		int res = 0;
		if(resVo != null) {	// 현재 구매상품이 기존 구매상품과 같은상품을 구매했을때만 이곳으로 들어온다. 즉, 이때 구매한 상품에 대하여 수량만 증가처리
			// 주문품목이 여러개를 구매했을경우, 수량과 같은 정보들(optonIdx,optionName,optoinPrice,optionNum)이 ','로 구분되어 DB에 저장되어 있다.(현재 구매후 넘어온 자료도 마찬가지이다.)
			String[] voOptionNums = vo.getOptionNum().split(",");			// 지금(현재) 구매한 장바구니의 수량을 가져와서 ','를 기준으로 분리 
			String[] resOptionNums = resVo.getOptionNum().split(",");	// 기존에 구매했었던 장바구니의 수량을 가져와서 ','를 기준으로 분리
			int[] nums = new int[99];	// 주문한 상품에 대한 수량을 누적하기위한 배열확보
			String strNums = "";		// 주문수량 변경후 다시 기존정보와 묶어주기위해서 문자열변수 선언
			for(int i=0; i<voOptionNums.length; i++) {	// 지금 주문한 상품(옵션)의 건수만큼 반복 비교처리
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));	// 현재 구매한 수량과 기존에 구매했던 상품의 수량을 합산해서 배열에 저장
				strNums += nums[i];
				if(i < nums.length - 1) strNums += ",";	// 구매상품이 2건 이상일때 기존상품 수량과의 구별을 위해 ','를 추가하고 있다.
			}
			if(strNums.indexOf(",") != -1) strNums = strNums.substring(0,strNums.length()-1);	// 여러개 상품을 구매했었다고하면, 구매 했었던 상품 수량의 마지막 쉼표 제거하기
			vo.setOptionNum(strNums);	// 새롭게 정비한 수량을 다시 vo에 set시켜준다.
			res = shopService.shopCartUpdate(vo);	// 수량이 변경되었기에 기존 장바구니에서 지금 변경내역으로 update처리한다.
		}
		else {
			res = shopService.shopCartInput(vo);	// 기존 장바구니에 없는 새로운 항목이면 insert처리하면 된다.
		}
		
		// 구매상품을 수량체크후(update또는 insert) 해당항목('장바구니보기' 또는 '주문 배송지 처리')으로 보내준다.
		if(res != 0) {
			if(flag.equals("order")) return "redirect:/message/cartOrderOk";	// 'flag'에 'order'이 넘어올경우는 '장바구니보기'로 가지않고 바로 '배송지'처리창으로 보낸다.(지금은 처리하지않음-장바구니보기로보냄)
			else return "redirect:/message/cartInputOk";	// '장바구니담기'버튼클릭시 장바구니에 구매상품의 정보를 담은후, 여기에서는 다시 쇼핑하기로 보냈다.(장바구니 보기로 이동해도 됨)
		}
		else return "redirect:/message/cartOrderNo";
	}
	
	// 장바구니 페이지
	@RequestMapping(value="cartList", method=RequestMethod.GET)
	public String cartListGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<DbCartVO> vos = shopService.getDbCartList(mid);	// idx오름차순으로 정리해서 가져왔다.
		
		if(vos.size() == 0) return "redirect:/message/cartEmpty";
		
		model.addAttribute("cartListVOS", vos);
		return "shop/cartList";
	}
	
	// 장바구니에서 선택한 상품을 장바구니에서 삭제시켜주기
	@ResponseBody
	@RequestMapping(value="/dbCartDelete", method=RequestMethod.POST)
	public String dbCartDeleteGet(int idx) {
		return shopService.dbCartDelete(idx) + "";
	}
	
	//장바구니에서 '주문하기' 버튼을 클릭시에 처리할 부분
	@RequestMapping(value="/cartList", method=RequestMethod.POST)
	public String dbCartListPost(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="baesong", defaultValue="0", required=false) int baesong) {
		String mid = (String) session.getAttribute("sMid");
		
		// 주문한 상품에 대한 '고유번호'를 만들어준다.
		DbOrderVO maxIdx = shopService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		// 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		DbCartVO cartVo = new DbCartVO();
		List<DbOrderVO> orderVOS = new ArrayList<DbOrderVO>();
   
		// 구매한 각각의 상품을 주문vo(orderVo)에 담은후 vos에 추가처리한다. 모든 작업이 완료되면 주문정보(orderVOS)세션에 담아준다.
		for(String strIdx : idxChecked) {
	     cartVo = shopService.getCartIdx(Integer.parseInt(strIdx));	// 장바구니에 담겨서 구매 선택한 항목에 대하여 고유번호를 검색해온다.
	     DbOrderVO orderVo = new DbOrderVO();	// 장바구니에서 구매한 상품정보를 '주문테이블'에 담아준다.
	     orderVo.setProductIdx(cartVo.getProductIdx());
	     orderVo.setProductName(cartVo.getProductName());
	     orderVo.setMainPrice(cartVo.getMainPrice());
	     orderVo.setThumbImg(cartVo.getThumbImg());
	     orderVo.setOptionName(cartVo.getOptionName());
	     orderVo.setOptionPrice(cartVo.getOptionPrice());
	     orderVo.setOptionNum(cartVo.getOptionNum());
	     orderVo.setTotalPrice(cartVo.getTotalPrice());
	     orderVo.setCartIdx(cartVo.getIdx());
	     orderVo.setBaesong(baesong);
	
	     orderVo.setOrderIdx(orderIdx); 
	     orderVo.setMid(mid);
	
	     orderVOS.add(orderVo);
		}
		session.setAttribute("sOrderVOS", orderVOS);
		 
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member2에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		
		return "shop/dbOrder";
	}
	
	// 결제시스템(결제창 호출) - 결제 API이용
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(DbOrderVO orderVo, DbPayMentVO payMentVO, DbBaesongVO baesongVO, HttpSession session, Model model) {
		model.addAttribute("payMentVO", payMentVO);
		
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("sBaesongVO", baesongVO);
		
		return "shop/paymentOk";
		// return "redirect:/dbShop/paymentResult";
	}
	
	//결제창 호출후, 결제완료후 주문내역을 '주문테이블'에 저장처리한다. - 주문/결제된 물품은 장바구니에서 제거시켜준다. 사용한 세션은 제거시킨다. - 구매한 상품들의 정보를 확인창으로 넘겨준다.
	@Transactional
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/paymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, DbPayMentVO receivePayMentVO, Model model) {
		// 결제전에 세션에 저장해 두었던 상품(주문/배송)의 주문내역을 dbOrder/dbBaesong테이블에 저장한다.
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		DbPayMentVO payMentVO = (DbPayMentVO) session.getAttribute("sPayMentVO");
		DbBaesongVO baesongVO = (DbBaesongVO) session.getAttribute("sBaesongVO");
		
		// 사용된 세션은 반환한다. 단, sOrderVOS 는 마지막 결제처리후에 결재결과창에서 확인하도록 하였기에 지금지우지 않고, 확인후 삭제처리한다.
		session.removeAttribute("sBaesongVO");
		
		for(DbOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8)));	// 주문테이블에 고유번호를 셋팅한다.
			vo.setOrderIdx(vo.getOrderIdx());		// 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());							
			
			shopService.setDbOrder(vo);		// 주문/결제 처리된 내용을 주문테이블(dbOrder)에 저장시킨다.
			shopService.setDbCartDeleteAll(vo.getCartIdx());	// 주문이 완료되었기에 장바구니테이블에서 주문한 내역을 삭제한다.
		}
		// 주문된 정보중 누락된 정보를 배송테이블에 담기위한 처리작업(기존 baesongVO에 담기지 않은 내역들을 담아주고 있다.)
		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(payMentVO.getBuyer_addr());
		baesongVO.setTel(payMentVO.getBuyer_tel());
		
		int totalBaesongOrder = 0;
		for(int i=0; i<orderVOS.size(); i++) {
			totalBaesongOrder += orderVOS.get(i).getTotalPrice();
		}
		// 배송정보를 저장하기전에, 총 주문금액이 5만원 미만이면, 배송비를 3000원 추가시킨다.
		if(totalBaesongOrder < 50000) baesongVO.setOrderTotalPrice(totalBaesongOrder + 3000);
		else baesongVO.setOrderTotalPrice(totalBaesongOrder);
		//System.out.println("baesongVO : " + baesongVO);
		shopService.setDbBaesong(baesongVO);	// 배송내역을 배송테이블(dbBaesong)에 저장한다.
		shopService.setMemberPointPlus((int)(baesongVO.getOrderTotalPrice() * 0.01), orderVOS.get(0).getMid());	// 회원테이블에 포인트 적립하기(1%)
		
		payMentVO.setImp_uid(receivePayMentVO.getImp_uid());
		payMentVO.setMerchant_uid(receivePayMentVO.getMerchant_uid());
		payMentVO.setPaid_amount(receivePayMentVO.getPaid_amount());
		payMentVO.setApply_num(receivePayMentVO.getApply_num());
		
		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getOrderTotalPrice());
		
		return "redirect:/message/paymentResultOk";
	}
	
	// 결재완료되고난후 주문/배송 테이블에 처리가 끝난 주문상품에 대한 결제정보 보여주기
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		
		// 구매한 총 금액(여러개의 상품이라도 주문번호는 1개를 부여했다)은 배송테이블에 있기에 주문고유번호로 배송테이블에서 구매한 총 금액을 가져온다.
		int totalBaesongOrder = shopService.getTotalBaesongOrder(orderVOS.get(orderVOS.size()-1).getOrderIdx());
		model.addAttribute("totalBaesongOrder", totalBaesongOrder);
		
		return "shop/paymentResult";
	}
	
	//배송지 정보 보여주기
	@RequestMapping(value="/dbOrderBaesong", method=RequestMethod.GET)
	public String dbOrderBaesongGet(String orderIdx, Model model) {
		List<DbBaesongVO> vos = shopService.getOrderBaesong(orderIdx);	// 같은 주문번호로 구매된 상품이 2개 이상 있을수 있기에 List객체로 가져온다.
		
		DbBaesongVO vo = vos.get(0);	// 같은 배송지라면 0번째것 하나만 vo에 담아서 처리한다.
		String payMethod = "";
		if(vo.getPayment().substring(0,1).equals("C")) payMethod = "카드결제";
		else payMethod = "은행(무통장)결제";
		
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("vo", vo);
		
		return "shop/dbOrderBaesong";
	}
	
	// 나의 주문 내역 보기
	@RequestMapping(value="/dbMyOrder", method=RequestMethod.GET)
	public String dbMyOrderGet(HttpServletRequest request, HttpSession session, Model model,
			String startJumun, String endJumun, 
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
 	  @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
		
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "전체";
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dbMyOrder","", mid, "");
		
		// 오늘 구매한 내역을 초기화면에 보여준다.
		List<DbBaesongVO> vos = shopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid);
		
		// model.addAttribute("vos", vos);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVO", pageVO);
		
		return "shop/dbMyOrder";
	}
	
	//현재 주문 상태 보여주기
	@RequestMapping(value="/dbMyOrderStatus", method=RequestMethod.GET)
	public String myOrderStatusGet(Model model, HttpServletRequest request, HttpSession session, 
			String startJumun, String endJumun, 
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
 	  @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		
		if(level == 0) mid = "전체";
		String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus","", mid, searchString);  // 5번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
		
		List<DbBaesongVO> vos = shopService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
		model.addAttribute("vos", vos);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		model.addAttribute("pageVO", pageVO);
		
		return "shop/dbMyOrder";
	}
	
}
