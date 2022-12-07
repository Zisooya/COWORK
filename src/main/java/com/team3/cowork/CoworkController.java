package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.ModelAndView;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;

	@Autowired
	private MemberService service;
  
	// ProjectDAO 변수 생성 _ 세건
	@Autowired
	private ProjectsDAO dao_projects;

	// 프로젝트 목록 생성 페이지 _ 세건
	@RequestMapping("project_control.do")
	public String project_control(Model model) {
		List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsList();
		List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
		List<Projects_statusDTO> status = this.dao_projects.getStatusList();
	    List<MemberDTO> mlist = this.dao.getMemberList();
	    model.addAttribute("mlist", mlist);
		model.addAttribute("list", list);
		model.addAttribute("main", main);
		model.addAttribute("status", status);
		return "project_control";
	}
			

  // 프로젝트 생성 페이지 _ 세건
  @RequestMapping("project_insert.do")
  public void project_insert(Model model,ProjectsDTO dto,HttpServletResponse response,MemberDTO mdto) throws IOException {
    this.dao_projects.insertProject(dto);
    List<MemberDTO> mlist = this.dao.getMemberList();
    model.addAttribute("mlist", mlist);
    response.setContentType("text/html; charset=UTF-8");
    PrintWriter out = response.getWriter();
    out.println("<script>");
    out.println("location.href='project_control.do'");
    out.println("</script>");
  }

  // 프로젝트 상세보기 모달창 띄우기 _ 세건
  @RequestMapping("content.do")
  public String ProjectModal(Model model,@RequestParam int num) throws IOException {
    ProjectsDTO cont = this.dao_projects.getprojects(num);
    List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
    List<MemberDTO> mlist = this.dao.getMemberList();
    List<Projects_statusDTO> status = this.dao_projects.getStatusList();
    model.addAttribute("mlist", mlist);
    model.addAttribute("cont", cont);
    model.addAttribute("main", main);
    model.addAttribute("status", status);
    return "projects_include/Project_modal";
    }
  
  // 프로젝트 멤버 추가하기 _ 세건
  @RequestMapping("project_memberinsert.do")
  public void ProjectMemberInsert(ProjectsDTO dto,HttpServletResponse response) throws IOException{
	  int check = 0;
	  ProjectsDTO cont = this.dao_projects.getprojects(dto.getProject_no());
	  if(cont.getProject_taker2() == null) {
		  check = this.dao_projects.updatetaker2(dto);
	  }else if(cont.getProject_taker3() == null) {
		  check = this.dao_projects.updatetaker3(dto);
	  }else if(cont.getProject_taker4() == null) {
		  check = this.dao_projects.updatetaker4(dto);
	  }else if(cont.getProject_taker5() == null) {
		  check = this.dao_projects.updatetaker5(dto);
	  }
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
	  if(check > 0) {
		  out.println("<script>");
		  out.println("alert('변경되었습니다.')");
		  out.println("</script>");
	  }
  }
  
  // 프로젝트 멤버 제외하기 _ 세건
  @RequestMapping("project_Deletetaker1.do")
  public void projectDeletetaker1(ProjectsDTO dto,HttpServletResponse response) {
	 int check = this.dao_projects.deletetaker1(dto);
  }
  @RequestMapping("project_Deletetaker2.do")
  public void projectDeletetaker2(ProjectsDTO dto,HttpServletResponse response) {
	 int check = this.dao_projects.deletetaker2(dto);
  }
  @RequestMapping("project_Deletetaker3.do")
  public void projectDeletetaker3(ProjectsDTO dto,HttpServletResponse response) {
	 int check = this.dao_projects.deletetaker3(dto);
  }
  @RequestMapping("project_Deletetaker4.do")
  public void projectDeletetaker4(ProjectsDTO dto,HttpServletResponse response) {
	 int check = this.dao_projects.deletetaker4(dto);
  }
  @RequestMapping("project_Deletetaker5.do")
  public void projectDeletetaker5(ProjectsDTO dto,HttpServletResponse response) {
	 int check = this.dao_projects.deletetaker5(dto);
  }
  
  // 프로젝트 삭제하기 _ 세건
  @RequestMapping("project_delete.do")
  public void ProjectDelete(@RequestParam int num, HttpServletResponse response) throws IOException {
	  System.out.println(num);
	  int check = this.dao_projects.deleteProjects(num);
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
	  if(check > 0) {
	  out.println("<script>");
	  out.println("location.href='project_control.do'");
	  out.println("</script>");
	  }
  }
  
  // 프로젝트 status 변경 _ 세건
  @RequestMapping("project_move.do")
  public void ProjectMove(ProjectsDTO dto,HttpServletResponse response) throws IOException {
	  int check = this.dao_projects.updateProjects(dto);
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
	  if(check > 0) {
	  out.println("<script>");
	  out.println("alert('변경되었습니다.')");
	  out.println("</script>");
	  }
  }
  
  // 프로젝트 시작일 변경 _ 세건
  @RequestMapping("project_UpdateStart.do")
  public void ProjectUpdateStart(ProjectsDTO dto,HttpServletResponse response) throws IOException {
	  int check = this.dao_projects.updatestart(dto);
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
	  if(check > 0) {
		  out.println("<script>");
		  out.println("alert('변경되었습니다.')");
		  out.println("</script>");
	  }
  }
  
  // 프로젝트 마감일 변경 _ 세건
  @RequestMapping("project_Updateend.do")
  public void ProjectUpdateEnd(ProjectsDTO dto,HttpServletResponse response) throws IOException {
	  int check = this.dao_projects.updateend(dto);
	  response.setContentType("text/html; charset=UTF-8");
	  PrintWriter out = response.getWriter();
	  if(check > 0) {
		  out.println("<script>");
		  out.println("alert('변경되었습니다.')");
		  out.println("</script>");
	  }
  }
  
  // 프로젝트 상세내용 추가하기 _ 세건
  @RequestMapping("project_InsertComment.do")
  public void ProjectComment(ProjectsDTO dto,HttpServletResponse response) throws IOException {
	  this.dao_projects.updatecomment(dto);
	  System.out.println(dto.getProject_comment());
	  System.out.println(dto.getProject_no());
  }
  

	@Autowired
	private CalendarDAO dao_cal;
	
	@RequestMapping("calendar.do")
	public String calendarMain(Model model) {
		 
		return "cal_main";
	}
	
	@RequestMapping("calendarList.do")
	@ResponseBody
	public List<CalendarDTO> calendarList(@RequestParam("no") int memNo, Model model) {
		List<CalendarDTO> list = this.dao_cal.getCalList(memNo);
		return list;
	}


	@RequestMapping("member_login.do")	// 임시로 만든 메서드임. 추후 로그인 화면을 시작페이지(main.jsp)로 변경 예정.
	public String login() {
		return "login";
	}

	@RequestMapping("member_login_ok.do")
	public ModelAndView loginOk(@ModelAttribute MemberDTO dto, HttpSession session) {
		boolean result = service.loginCheck(dto, session);

		ModelAndView mav = new ModelAndView();

		if (result) {
			mav.setViewName("home");
			mav.addObject("msg", "success");
		} else {
			mav.setViewName("login");
			mav.addObject("msg", "fail");
		}

		return mav;
	}

	@RequestMapping("member_logout.do")
	public ModelAndView logout(HttpSession session) {
		service.logout(session);

		ModelAndView mav = new ModelAndView();

		mav.setViewName("login");
		mav.addObject("msg", "logout");

		return mav;
	}
	
	@RequestMapping("address.do")
	public String address(){
		return "address";
	}

}
