package com.team3.model.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberDTO memberLogin(MemberDTO dto) {
		return this.sqlSession.selectOne("memberLogin", dto);
	}

	@Override
	public void memberJoin(MemberDTO dto) {
		this.sqlSession.insert("memberJoin", dto);
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
	public String memberFindPwd(MemberDTO dto) {
		return this.sqlSession.selectOne("memberFindPwd", dto);
	}

	@Override
	public int idCheck(String mem_id) {
		return this.sqlSession.selectOne("idCheck", mem_id);
	}

	// 프로젝트 생성 시 멤버 리스트 가져오기
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("allMem");
	}
}
