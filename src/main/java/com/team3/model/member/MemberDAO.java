package com.team3.model.member;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberDAO {

	MemberDTO memberLogin(MemberDTO dto);

	MemberDTO selectMember(@Param("mem_id") String mem_id);

	void memberJoin(MemberDTO dto);

	MemberDTO memberDetail(String mem_id);

	void memberEdit(MemberDTO dto);

	void memberDelete(String mem_id);

	String memberFindId(MemberDTO dto);

	int memberFindPwd(@Param("mem_id") String mem_id, @Param("mem_email") String mem_email, @Param("key") String key);

	int idCheck(String mem_id);

	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
}
