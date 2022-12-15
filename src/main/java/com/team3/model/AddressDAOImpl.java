package com.team3.model;

import java.util.List;

import com.team3.model.member.MemberDTO;
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

	@Override
	public List<MemberDTO> getAddrList_search(String keyword) {
		return this.sqlSession.selectList("addressDao.getAddrList_search", keyword);
	}

	@Override
	public List<CustomerDTO> getAddrList_customer(int mem_no) {
		return this.sqlSession.selectList("addressDao.getAddrList_customer", mem_no);
	}

	@Override
	public int insert_customer(CustomerDTO customerDTO) {
		return this.sqlSession.insert("addressDao.insert_customer", customerDTO);
	} 


}
