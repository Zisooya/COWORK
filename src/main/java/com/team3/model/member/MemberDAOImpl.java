package com.team3.model.member;

import com.team3.model.DepartmentDTO;
import com.team3.model.TeamDTO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team3.model.Messenger_NotiDTO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberDTO selectMember(@Param("mem_id") String mem_id) {
		return this.sqlSession.selectOne("selectMember", mem_id);
	}

	@Override
	public int memberJoin(MemberDTO dto) {
		return this.sqlSession.insert("memberJoin", dto);
	}

	@Override
	public MemberDTO memberDetail(String mem_id) {
		return this.sqlSession.selectOne("memberDetail", mem_id);
	}

	@Override
	public void memberEdit(MemberDTO dto) {
		this.sqlSession.update("memberEdit", dto);
	}

	@Override
	public void memberDelete(String mem_id) {
		this.sqlSession.delete("memberDelete", mem_id);
	}

	@Override
	public String memberFindId(MemberDTO dto) {
		return this.sqlSession.selectOne("memberFindId", dto);
	}

	@Override
	public int updatePwd(HashMap<String, Object> map) {
		System.out.println("mem_id >> " + map.get("mem_id"));
		System.out.println("mem_email >> " + map.get("mem_email"));
		System.out.println("key >> " + map.get("key"));
		return this.sqlSession.update("updatePwd", map);
	}

	@Override
	public int idCheck(String mem_id) {
		return this.sqlSession.selectOne("idCheck", mem_id);
	}

	@Override
	public List<DepartmentDTO> getDeptList() {
		return this.sqlSession.selectList("deptList");
	}

	@Override
	public List<TeamDTO> getTeamList() {
		return this.sqlSession.selectList("teamList");
	}

	// 프로젝트 생성 시 멤버 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("allMem");
	}

	// 로그인 시 메신저 알림 세션에 저장하기_Jisoo
	@Override
	public List<Messenger_NotiDTO> getMemNotiDTO(int mem_no) {
		return this.sqlSession.selectList("getMemNotiDTO",mem_no);
	}

	@Override
	public int getMemNo(String mem_id) {
		return this.sqlSession.selectOne("getMemNo", mem_id);
	}

	@Override
	public int getNotiCount(int mem_no) {
		return this.sqlSession.selectOne("getNotiCount", mem_no);
	}
}
