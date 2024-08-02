package com.spring.javaclassS3.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS3.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public String fileUpload(MultipartFile fName, String mid, String string);

	public void setMemberInforUpdate(String mid, int point);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public ArrayList<MemberVO> getMemberSearch(String fieldName, String searchString);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInput(String mid, String pwd, String nickName, String email);

	public int setUserDel(String mid);

	public int setPwdChangeOk(String mid, String pwd);

	public int setMemberUpdateOk(MemberVO vo);

}
