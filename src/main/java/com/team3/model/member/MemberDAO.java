package com.team3.model.member;

import java.util.List;

public interface MemberDAO {

	MemberDTO memberLogin(MemberDTO dto);

	void memberJoin(MemberDTO dto);

	MemberDTO memberDetail(String mem_id);

	void memberEdit(MemberDTO dto);

	void memberDelete(String mem_id);

	List<MemberDTO> memberFindId(MemberDTO dto);

	String memberFindPwd(MemberDTO dto);

	int idCheck(String mem_id);

	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
}
