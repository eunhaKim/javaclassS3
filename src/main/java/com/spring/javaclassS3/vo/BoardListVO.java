package com.spring.javaclassS3.vo;

import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class BoardListVO {
	private int idx;
	
	// Validator를 사용한 BackEnd Check부분
	@Size(min=2, max=20, message="게시판이름 길이가 잘못되었습니다.")
	private String boardName;
	
	@Size(min=2, max=10, message="테이블이름 길이가 잘못되었습니다.")
	private String tableName;
	
	private String boardType;
	private String category;
	private String cDate;
	
}
