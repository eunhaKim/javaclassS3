package com.spring.javaclassS3.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS3.vo.DbBaesongVO;
import com.spring.javaclassS3.vo.DbCartVO;
import com.spring.javaclassS3.vo.DbOrderVO;
import com.spring.javaclassS3.vo.OptionVO;
import com.spring.javaclassS3.vo.ProductVO;

public interface ShopDAO {

	public ArrayList<ProductVO> getCategory1List();

	public ArrayList<ProductVO> getCategory2List();

	public ArrayList<ProductVO> getCategory3List();

	public int setCategory1Input(@Param("vo") ProductVO vo);

	public ProductVO getCategory1One(@Param("vo") ProductVO vo);

	public int setCategory1Delete(@Param("category1Code") String category1Code);

	public ProductVO getCategory2One(@Param("vo") ProductVO vo);
	
	public ProductVO getCategory3One(@Param("vo") ProductVO vo);

	public int setCategory2Input(@Param("vo") ProductVO vo);

	public ProductVO getCategory1OneAfter(@Param("vo") ProductVO vo);
	
	public ProductVO getCategory2OneAfter(@Param("vo") ProductVO vo);

	public int setCategory2Delete(@Param("category2Code") String category2Code);

	public List<ProductVO> getCategory2Name(@Param("category1Code") String category1Code);

	public int setCategory3Input(@Param("vo") ProductVO vo);

	public int setCategory3Delete(@Param("category3Code") String category3Code);

	public List<ProductVO> getCategory3Name(@Param("category1Code") String category1Code, @Param("category2Code") String category2Code);

	public ProductVO getProductMaxIdx();
	
	public int getProductMaxIdx2();

	public int setProductInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getCat3Title();

	public List<ProductVO> getShopList(@Param("part") String part, @Param("mainPrice") String mainPrice);

	public ProductVO getShopProduct(@Param("idx") int idx);

	public int setOptionInput(@Param("vo") OptionVO vo);

	public List<ProductVO> getProductList(@Param("cat1") String cat1, @Param("mainPrice") String mainPrice);

	public List<OptionVO> getShopOption(@Param("idx") int idx);

	public ProductVO getCategory2First(@Param("cat1") String cat1);

	public ProductVO getCategory3First(@Param("cat2") String cat2);

	public List<ProductVO> getProductListCat3(@Param("cat3") String cat3);

	public List<ProductVO> getProductListCat2(@Param("cat2") String cat2);

	public int shopCartInput(@Param("vo") DbCartVO vo);

	public DbCartVO getDbCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public int shopCartUpdate(@Param("vo") DbCartVO vo);

	public List<DbCartVO> getDbCartList(@Param("mid") String mid);

	public int dbCartDelete(@Param("idx") int idx);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(@Param("idx") int idx);

	public void setDbOrder(@Param("vo") DbOrderVO vo);

	public void setDbCartDeleteAll(@Param("cartIdx") int cartIdx);

	public void setDbBaesong(@Param("baesongVO") DbBaesongVO baesongVO);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	public int getTotalBaesongOrder(@Param("orderIdx") String orderIdx);

	public List<DbBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public int totRecCnt(@Param("mid") String mid);

	public List<DbBaesongVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public List<DbBaesongVO> getMyOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public int totRecCntAdminStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public int totRecCntMyOrderStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);



}
