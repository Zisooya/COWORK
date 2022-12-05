package com.team3.model;

import java.util.HashMap;
import java.util.List;

public interface MemberDAO {

	int memberCheck(String id);

	MemberDTO getMember(String id);
	
	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
}
