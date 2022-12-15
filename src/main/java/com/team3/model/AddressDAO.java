package com.team3.model;

import com.team3.model.member.MemberDTO;

import java.util.List;

public interface AddressDAO {

	List<DepartmentDTO> getAllDeptList();
	
	int getMyDeptNum();
	
	List<MemberDTO> getMyDeptMemberList(int dept_no);
	
	List<MemberDTO> getAddrList_dept(String dept_name);
	
	
}