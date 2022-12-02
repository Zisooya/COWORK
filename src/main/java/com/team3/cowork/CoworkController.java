package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team3.model.CalendarDAO;
import com.team3.model.CalendarDTO;
import com.team3.model.Main_ProjectsDTO;
import com.team3.model.MemberDAO;
import com.team3.model.MemberDTO;
import com.team3.model.ProjectsDAO;
import com.team3.model.ProjectsDTO;
import com.team3.model.Projects_statusDTO;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CoworkController {

	@Autowired
	private MemberDAO dao;
  
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
    model.addAttribute("mlist", mlist);
    model.addAttribute("cont", cont);
    model.addAttribute("main", main);
    return "projects_include/Project_modal";
    }
  
  @RequestMapping("project_memberinsert.do")
  public void ProjectMemberInsert(@RequestParam String project_member,@RequestParam int project_no){
	  ProjectsDTO cont = this.dao_projects.getprojects(project_no);
	  if(cont.getProject_taker2() == null) {
		  this.dao_projects.updatetaker(project_no);
	  }
	  
  }

	@Autowired
	private CalendarDAO dao_cal;
	
	/*
	 * @RequestMapping("calendar.do") public String calendarMain(@RequestParam("no")
	 * int memNo, Model model) {
	 * 
	 * List<CalendarDTO> list = this.dao_cal.getCalList(memNo);
	 * model.addAttribute("list", list);
	 * 
	 * return "cal_main";
	 */




	@RequestMapping("member_login.do")	// 임시로 만든 메서드임. 추후 로그인 화면을 시작페이지(main.jsp)로 변경 예정.
	public String memberLogin() {
		return "login";
	}

	@RequestMapping("member_login_ok.do")
	public String memberLoginOk(@RequestParam("mem_id") String id, @RequestParam("mem_pwd") String pwd, HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = "";

		PrintWriter out = response.getWriter();

		int check = dao.memberCheck(id);

		System.out.println("check값 >> " + check);

		if (check > 0) {
			MemberDTO dto = dao.getMember(id);

			if (!dto.getMem_pwd().equals(pwd)) {
				System.out.println("비번틀림");
				out.println("<script>");
				out.println("alert('비밀번호가 틀립니다.')");
				out.println("</script>");
				path = "login";
			} else {
				System.out.println("로그인 성공");
				HttpSession session = request.getSession();

				session.setAttribute("memId", dto.getMem_id());
				session.setAttribute("memName", dto.getMem_name());

				path = "home";
			}
		} else {
			System.out.println("아이디없음");
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디입니다.')");
			out.println("</script>");
			path = "login";
		}
		return path;
	}

}
