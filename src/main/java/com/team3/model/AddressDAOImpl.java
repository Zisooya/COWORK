package com.team3.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AddressDAOImpl implements AddressDAO {

	 @Autowired
	 private SqlSessionTemplate sqlSession;
	 

	@Override
	public List<DepartmentDTO> getAllDeptList() {
		return this.sqlSession.selectList("addressDao.address_deptList");
	}

	@Override
	public int getMyDeptNum() {
		return this.sqlSession.selectOne("addressDao.address_myDeptNum");
	}

	@Override
	public List<MemberDTO> getMyDeptMemberList(int dept_no) {
		return this.sqlSession.selectList("addressDao.address_myDeptMemberList", dept_no);
	}

	@Override
	public List<MemberDTO> getAddrList_dept(String dept_name) {
		return this.sqlSession.selectList("addressDao.getAddrList_dept", dept_name);
	} 


}
