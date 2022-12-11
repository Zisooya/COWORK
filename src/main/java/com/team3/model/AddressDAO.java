package com.team3.model;

import java.util.List;

public interface AddressDAO {

	List<DepartmentDTO> getAllDeptList();
	
	int getMyDeptNum();
	
	List<MemberDTO> myDeptMemberList(int myDeptNum);
	
}