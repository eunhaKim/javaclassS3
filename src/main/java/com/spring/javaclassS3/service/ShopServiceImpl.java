package com.spring.javaclassS3.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS3.common.JavaclassProvide;
import com.spring.javaclassS3.dao.ShopDAO;
import com.spring.javaclassS3.vo.DbBaesongVO;
import com.spring.javaclassS3.vo.DbCartVO;
import com.spring.javaclassS3.vo.DbOrderVO;
import com.spring.javaclassS3.vo.OptionVO;
import com.spring.javaclassS3.vo.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {
	@Autowired
	ShopDAO shopDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public ArrayList<ProductVO> getCategory1List() {
		return shopDAO.getCategory1List();
	}

	@Override
	public ArrayList<ProductVO> getCategory2List() {
		return shopDAO.getCategory2List();
	}
	
	@Override
	public ArrayList<ProductVO> getCategory3List() {
		return shopDAO.getCategory3List();
	}

	@Override
	public int setCategory1Input(ProductVO vo) {
		return shopDAO.setCategory1Input(vo);
	}

	@Override
	public ProductVO getCategory1One(ProductVO vo) {
		return shopDAO.getCategory1One(vo);
	}

	@Override
	public int setCategory1Delete(String category1Code) {
		return shopDAO.setCategory1Delete(category1Code);
	}

	@Override
	public ProductVO getCategory2One(ProductVO vo) {
		return shopDAO.getCategory2One(vo);
	}
	
	@Override
	public ProductVO getCategory3One(ProductVO vo) {
		return shopDAO.getCategory3One(vo);
	}

	@Override
	public int setCategory2Input(ProductVO vo) {
		return shopDAO.setCategory2Input(vo);
	}

	@Override
	public ProductVO getCategory1OneAfter(ProductVO vo) {
		return shopDAO.getCategory1OneAfter(vo);
	}
	
	@Override
	public ProductVO getCategory2OneAfter(ProductVO vo) {
		return shopDAO.getCategory2OneAfter(vo);
	}

	@Override
	public int setCategory2Delete(String category2Code) {
		return shopDAO.setCategory2Delete(category2Code);
	}

	@Override
	public List<ProductVO> getCategory2Name(String category1Code) {
		return shopDAO.getCategory2Name(category1Code);
	}

	@Override
	public int setCategory3Input(ProductVO vo) {
		return shopDAO.setCategory3Input(vo);
	}

	@Override
	public int setCategory3Delete(String category3Code) {
		return shopDAO.setCategory3Delete(category3Code);
	}

	@Override
	public List<ProductVO> getCategory3Name(String category1Code, String category2Code) {
		return shopDAO.getCategory3Name(category1Code, category2Code);
	}

	@Override
	public int imgCheckProductInput(MultipartFile file, ProductVO vo) {
		int res = 0;
    // 메인 이미지 업로드 작업처리
    try {
      String originalFilename = file.getOriginalFilename();
      if(originalFilename != null && originalFilename != "") {
        // 상품 메인사진 업로드시 파일명 중복을 피하기 위한 처리(파일명 변경하기)
      	String saveFileName = javaclassProvide.saveFileName(originalFilename);
        
        // 메인 이미지파일을 서버 파일시스템에 업로드 처리하는 메소드 호출
        javaclassProvide.writeFile(file, saveFileName, "shop/product");
        vo.setFSName(saveFileName);		// 업로드된 메인이미지의 실제로 저장된 파일명을 vo에 저장시켜준다.
      }
      else {
        return res;
      }
    } catch (IOException e) {
      e.printStackTrace();
    }

    // ckeditor에서 올린 이미지파일을 'ckeditor'에서 'shop/product'폴더로 복사한다.
    //             0         1         2         3         4         5
    //             012345678901234567890123456789012345678901234567890
    // <img alt="" src="/javaclassS/data/ckeditor/211229124318_4.jpg"
    // <img alt="" src="/javaclassS/data/dbShop/product/211229124318_4.jpg"

    // ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 'ckeditor'폴더에서 'shop/product'폴더로 복사작업처리 시켜준다.
    String content = vo.getContent();
    if(content.indexOf("src=\"/") == -1) return 0;    // content박스의 내용중 그림이 없으면 돌려보낸다.

    HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");

    int position = 31;
    String nextImg = content.substring(content.indexOf("src=\"/") + position);
    boolean sw = true;

    while(sw) {
      String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
      String copyFilePath = "";
      String oriFilePath = uploadPath + "ckeditor/" + imgFile;

      copyFilePath = uploadPath + "shop/product/" + imgFile;

      javaclassProvide.fileCopyCheck(oriFilePath, copyFilePath);

      if(nextImg.indexOf("src=\"/") == -1) sw = false;
      else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
    }
    
    vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/shop/product/"));

    // 고유번호 idx값 만들기(상품코드 만들때 필요함)
    int maxIdx = 1;
    ProductVO maxVo = shopDAO.getProductMaxIdx();
    if(maxVo != null) maxIdx = maxVo.getIdx() + 1;
    
    vo.setIdx(maxIdx);
    vo.setProductCode(vo.getCategory1Code()+vo.getCategory2Code()+vo.getCategory3Code()+maxIdx);	// 상품코드 만들기
    res = shopDAO.setProductInput(vo);	// vo안의 내용물을 모두 채운후 DB에 저장시킨다.
    return res;
	}

	@Override
	public List<ProductVO> getCat3Title() {
		return shopDAO.getCat3Title();
	}

	@Override
	public List<ProductVO> getShopList(String part, String mainPrice) {
		return shopDAO.getShopList(part, mainPrice);
	}

	@Override
	public ProductVO getShopProduct(int idx) {
		return shopDAO.getShopProduct(idx);
	}

	@Override
	public int getProductMaxIdx2() {
		return shopDAO.getProductMaxIdx2();
	}

	@Override
	public int setOptionInput(OptionVO vo) {
		return shopDAO.setOptionInput(vo);
	}

	@Override
	public List<ProductVO> getProductList(String cat1, String mainPrice) {
		return shopDAO.getProductList(cat1, mainPrice);
	}

	@Override
	public List<OptionVO> getShopOption(int idx) {
		return shopDAO.getShopOption(idx);
	}

	@Override
	public ProductVO getCategory2First(String cat1) {
		return shopDAO.getCategory2First(cat1);
	}

	@Override
	public ProductVO getCategory3First(String cat2) {
		return shopDAO.getCategory3First(cat2);
	}

	@Override
	public List<ProductVO> getProductListCat3(String cat3) {
		return shopDAO.getProductListCat3(cat3);
	}
	
	@Override
	public List<ProductVO> getProductListCat2(String cat2) {
		return shopDAO.getProductListCat2(cat2);
	}

	@Override
	public int shopCartInput(DbCartVO vo) {
		return shopDAO.shopCartInput(vo);
	}

	@Override
	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid) {
		return shopDAO.getDbCartProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public int shopCartUpdate(DbCartVO vo) {
		return shopDAO.shopCartUpdate(vo);
	}

	@Override
	public List<DbCartVO> getDbCartList(String mid) {
		return shopDAO.getDbCartList(mid);
	}

	@Override
	public int dbCartDelete(int idx) {
		return shopDAO.dbCartDelete(idx);
	}

	@Override
	public DbOrderVO getOrderMaxIdx() {
		return shopDAO.getOrderMaxIdx();
	}

	@Override
	public DbCartVO getCartIdx(int idx) {
		return shopDAO.getCartIdx(idx);
	}

	@Override
	public void setDbOrder(DbOrderVO vo) {
		shopDAO.setDbOrder(vo);
	}

	@Override
	public void setDbCartDeleteAll(int cartIdx) {
		shopDAO.setDbCartDeleteAll(cartIdx);
	}

	@Override
	public void setDbBaesong(DbBaesongVO baesongVO) {
		shopDAO.setDbBaesong(baesongVO);
	}

	@Override
	public void setMemberPointPlus(int point, String mid) {
		shopDAO.setMemberPointPlus(point, mid);
	}

	@Override
	public int getTotalBaesongOrder(String orderIdx) {
		return shopDAO.getTotalBaesongOrder(orderIdx);
	}

	@Override
	public List<DbBaesongVO> getOrderBaesong(String orderIdx) {
		return shopDAO.getOrderBaesong(orderIdx);
	}

	@Override
	public List<DbBaesongVO> getMyOrderList(int startIndexNo, int pageSize, String mid) {
		return shopDAO.getMyOrderList(startIndexNo, pageSize, mid);
	}

	@Override
	public List<DbBaesongVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun,
			String endJumun, String conditionOrderStatus) {
		return shopDAO.getMyOrderStatus(startIndexNo, pageSize, mid, startJumun,
				endJumun, conditionOrderStatus);
	}

}
