package com.team3.cowork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team3.model.AddressDAO;
import com.team3.model.DepartmentDTO;

@Controller
public class AddressController {

	@Autowired
	private AddressDAO addressDao;

	@RequestMapping("address.do")
	public String address(Model model){
		
		// 전체 부서 목록 조회
		List<DepartmentDTO> deptList = this.addressDao.getAllDeptList();
/*		
		// 내 부서 번호 조회
		int myDeptNum = this.addressDao.getMyDeptNum();
		// 나와 같은 부서 멤버 리스트 조회
		List<MemberDTO> memberDto = this.addressDao.myDeptMemberList(myDeptNum);
 */		
		
		model.addAttribute("deptList", deptList);
/*		model.addAttribute("memberDto", memberDto); */
		
		return "address";
	}	
}
