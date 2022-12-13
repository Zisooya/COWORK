package com.team3.model;

import java.util.List;

public interface AddressDAO {

	List<DepartmentDTO> getAllDeptList();
	
	int getMyDeptNum();
	
	List<MemberDTO> getMyDeptMemberList(int dept_no);
	
	List<MemberDTO> getAddrList_dept(String dept_name);
	
	List<MemberDTO> getAddrList_search(String keyword);
	
	List<MemberDTO> getAddrList_customer(int mem_no);
	
	
}