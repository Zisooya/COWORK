package com.team3.model;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

public interface MemberDAO {

	boolean loginCheck(MemberDTO dto);

	MemberDTO getMember(MemberDTO dto);

	void logout(HttpSession session);

	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
}
