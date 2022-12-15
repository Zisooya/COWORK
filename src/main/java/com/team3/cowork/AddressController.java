package com.team3.cowork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.model.AddressDAO;
import com.team3.model.DepartmentDTO;
import com.team3.model.member.MemberDTO;

@Controller
public class AddressController {

	@Autowired
	private AddressDAO addressDao;

	@RequestMapping("address.do")
	public String address(Model model){
		
		// 전체 부서 목록 조회
		List<DepartmentDTO> deptList = this.addressDao.getAllDeptList();
		
		// 내 부서 번호 조회
		int dept_no = this.addressDao.getMyDeptNum();
		
		// 나와 같은 부서 멤버 리스트 조회
		List<MemberDTO> myDeptMemberList = this.addressDao.getMyDeptMemberList(dept_no);
		
		
		model.addAttribute("deptList", deptList);
		model.addAttribute("myDept_no", dept_no);
		model.addAttribute("myDeptMemberList", myDeptMemberList);
		
		return "address";
	}	
	
	@RequestMapping("getAddrList_dept.do")
	public @ResponseBody List<MemberDTO> getAddrList_dept(String dept_name) {
		
		System.out.println("넘어온 부서명 : " + dept_name);
		// ajax로 넘어온 부서명에 해당하는 부서의 멤버 전체 리스트 조회
		List<MemberDTO> addrList_dept = this.addressDao.getAddrList_dept(dept_name);
		
		System.out.println(addrList_dept);
		
		return addrList_dept;
	}
	
}
