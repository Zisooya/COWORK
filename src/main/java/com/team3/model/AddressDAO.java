package com.team3.model;

import com.team3.model.member.MemberDTO;

import java.util.List;

public interface AddressDAO {

	List<DepartmentDTO> getAllDeptList();
	
	int getMyDeptNum(int mem_no);
	
	List<MemberDTO> getMyDeptMemberList(int dept_no);
	
	List<MemberDTO> getAddrList_dept(String dept_name);
	
	List<MemberDTO> getAddrList_search(String keyword);
	
	List<CustomerDTO> getAddrList_customer(int mem_no);
	
	int insert_customer(CustomerDTO customerDTO);
	
	MemberDTO getMemDetail(int addrMemNo);
	
	
}