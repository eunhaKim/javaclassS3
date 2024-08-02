package com.spring.javaclassS3.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS3.vo.DbBaesongVO;
import com.spring.javaclassS3.vo.DbCartVO;
import com.spring.javaclassS3.vo.DbOrderVO;
import com.spring.javaclassS3.vo.OptionVO;
import com.spring.javaclassS3.vo.ProductVO;

public interface ShopService {

	public ArrayList<ProductVO> getCategory1List();

	public ArrayList<ProductVO> getCategory2List();

	public ArrayList<ProductVO> getCategory3List();

	public int setCategory1Input(ProductVO vo);

	public ProductVO getCategory1One(ProductVO vo);

	public int setCategory1Delete(String category1Code);

	public ProductVO getCategory2One(ProductVO vo);
	
	public ProductVO getCategory3One(ProductVO vo);

	public int setCategory2Input(ProductVO vo);

	public ProductVO getCategory1OneAfter(ProductVO vo);
	
	public ProductVO getCategory2OneAfter(ProductVO vo);

	public int setCategory2Delete(String category2Code);

	public List<ProductVO> getCategory2Name(String category1Code);

	public int setCategory3Input(ProductVO vo);

	public int setCategory3Delete(String category3Code);

	public List<ProductVO> getCategory3Name(String category1Code, String category2Code);

	public int imgCheckProductInput(MultipartFile file, ProductVO vo);

	public List<ProductVO> getCat3Title();

	public List<ProductVO> getShopList(String part, String mainPrice);

	public ProductVO getShopProduct(int idx);

	public int getProductMaxIdx2();

	public int setOptionInput(OptionVO vo);

	public List<ProductVO> getProductList(String cat1, String mainPrice);

	public List<OptionVO> getShopOption(int idx);

	public ProductVO getCategory2First(String cat1);

	public ProductVO getCategory3First(String cat2);

	public List<ProductVO> getProductListCat3(String cat3);

	public List<ProductVO> getProductListCat2(String cat2);

	public int shopCartInput(DbCartVO vo);

	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid);

	public int shopCartUpdate(DbCartVO vo);

	public List<DbCartVO> getDbCartList(String mid);

	public int dbCartDelete(int idx);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(int idx);

	public void setDbOrder(DbOrderVO vo);

	public void setDbCartDeleteAll(int cartIdx);

	public void setDbBaesong(DbBaesongVO baesongVO);

	public void setMemberPointPlus(int i, String mid);

	public int getTotalBaesongOrder(String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(String orderIdx);

	public List<DbBaesongVO> getMyOrderList(int startIndexNo, int pageSize, String mid);

	public List<DbBaesongVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus);


}
