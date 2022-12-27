package com.team3.model.member;

import com.team3.model.DepartmentDTO;
import com.team3.model.TeamDTO;
import org.apache.ibatis.annotations.Param;

import com.team3.model.Messenger_NotiDTO;

import java.util.HashMap;
import java.util.List;

public interface MemberDAO {

	MemberDTO selectMember(@Param("mem_id") String mem_id);

	int memberJoin(MemberDTO dto);

	MemberDTO memberDetail(String mem_id);

	void memberEdit(MemberDTO dto);

	void memberDelete(MemberDTO dto);

	String memberFindId(MemberDTO dto);

	int updatePwd(HashMap<String, Object> map);

	int idCheck(String mem_id);

	List<DepartmentDTO> getDeptList();

	List<TeamDTO> getTeamList();

	// 프로젝트 생성 시 멤버 리스트 가져오기 _ 세건
	List<MemberDTO> getMemberList();
	
	// 로그인 시 메신저 알림 세션에 저장하기_Jisoo
	List<Messenger_NotiDTO> getMemNotiDTO(int mem_no);
	int getMemNo(String mem_id);
	int getNotiCount(int mem_no);
}
