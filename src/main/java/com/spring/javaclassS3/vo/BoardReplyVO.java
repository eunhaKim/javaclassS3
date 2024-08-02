package com.spring.javaclassS3.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private String boardName;
	private int boardIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String photo;
	private String wDate;
	private String hostIp;
	private String content;
}