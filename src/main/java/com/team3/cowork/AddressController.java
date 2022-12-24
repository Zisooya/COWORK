package com.team3.cowork;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.team3.model.AddressDAO;
import com.team3.model.CustomerDTO;
import com.team3.model.DepartmentDTO;
import com.team3.model.member.MemberDTO;

import lombok.extern.log4j.Log4j;
@Controller
public class AddressController {

	@Autowired
	private AddressDAO addressDao;

	@RequestMapping("address.do")
	public String address(Model model, HttpServletRequest request){
		
		// 전체 부서 목록 조회
		List<DepartmentDTO> deptList = this.addressDao.getAllDeptList();
		
		
		HttpSession session = request.getSession();
		
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		
		int mem_no = memberDTO.getMem_no();
		
		
		// 내 부서 번호 조회
		int dept_no = this.addressDao.getMyDeptNum(mem_no);
		
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
	
	@RequestMapping("address_search.do")
	public @ResponseBody List<MemberDTO> getAddrList_search(@RequestParam ("keyword") String keyword) {
		
		System.out.println("넘어온 keyword : " + keyword);
		
		List<MemberDTO> addrList_search = this.addressDao.getAddrList_search(keyword);
		
		return addrList_search;
	}
	
	
	@RequestMapping("getAddrList_customer.do")
	public @ResponseBody List<CustomerDTO> getAddrList_customer(@RequestParam ("mem_no") int mem_no) {
		
		System.out.println("넘어온 mem_no : " + mem_no);
		
		List<CustomerDTO> addrList_customer = this.addressDao.getAddrList_customer(mem_no);
		
		return addrList_customer;
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/add_customer.do")
	public @ResponseBody int addCustomer( CustomerDTO customerDTO, Model model) throws IOException {
		  // 배열 타입으로 선언하여 여러 개의 파일 저장
	
	System.out.println("받아온 데이터 : "+ customerDTO);
	
	System.out.println(System.getProperty("java.io.tmpdir")); // 자바 임시 저장 디렉토리
	
	MultipartFile multi = customerDTO.getMulti_image();
	
	// 1) 연 / 월 / 일 로 경로를 맞추기 위한 포맷 선언
	String FORMAT_YYYYMMDD = "yyyy/MM/dd";
	DateTimeFormatter dtf = DateTimeFormatter.ofPattern(FORMAT_YYYYMMDD);
	
	// 2) DateTimeFormatter 를 이용하여 현재 날짜를 포맷에 맞게 파싱해준다. ex) 2021/06/25
    String basePath = "C:/Users/user/Desktop/Github_desktop/COWORK/src/main/webapp/resources/address";				 
    String todayPath = LocalDateTime.now().format(dtf);
    
    // 3) BasePath 와 현재 날짜를 합친 Path 객체 생성
    Path pathToday = Paths.get(basePath, todayPath);
    
    // 4) 폴더가 없을 경우 생성해준다.
    if (Files.notExists(pathToday)) {
        Files.createDirectories(pathToday);
    }
    
    // 5) BasePath + 날짜 + 파일명(확장자 포함) 을 합친 Path 객체 생성
 // 6) Client 에서 받은 multipart 로 부터 파일명+확장자를 넘겨주어 최종 Path 객체를 반환
    Path targetPath = Paths.get(pathToday.toString(), multi.getOriginalFilename());
    
    // 7) file 을 outputStream 으로 내보내준다 (save)
    multi.transferTo(targetPath.toFile()); 	
    
    System.out.println("이미지 폴더에 저장 완료");
	
	customerDTO.setCustomer_image(multi.getOriginalFilename().toString());
	
	int check = this.addressDao.insert_customer(customerDTO);
	
	return check;
	
	}	
	
	@RequestMapping("address_getMemDetail.do")
	public @ResponseBody MemberDTO getMemDetail(@RequestParam ("addrMemNo") int addrMemNo) {
		
		MemberDTO memberDetail = this.addressDao.getMemDetail(addrMemNo);
		
		return memberDetail;
	}
	
	
}
