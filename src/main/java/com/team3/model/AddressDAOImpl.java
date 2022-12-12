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
		return this.sqlSession.selectList("address_deptList");
	}

	@Override
	public int getMyDeptNum() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<MemberDTO> myDeptMemberList(int myDeptNum) {
		// TODO Auto-generated method stub
		return null;
	} 


}
