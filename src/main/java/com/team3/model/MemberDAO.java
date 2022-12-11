package com.team3.model;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAO {

	MemberDTO login(MemberDTO dto);

	void logout(HttpSession session);

	void join(MemberDTO dto);

	int checkId(String mem_id);

	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
}
