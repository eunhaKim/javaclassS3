package com.spring.javaclassS3.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int idx;
	
	private String productCode;
	private String productName;
	private String detail;
	private int mainPrice;
	private String fSName;
	private String content;
	
	private String category1Code;
	private String category1Name;
	private String category2Code;
	private String category2Name;
	private String category3Code;
	private String category3Name;
}
