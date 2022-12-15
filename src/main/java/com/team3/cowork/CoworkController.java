package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.team3.model.*;
import com.team3.model.member.MemberDAO;
import com.team3.model.member.MemberDTO;
import com.team3.model.member.MemberService;
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
	public void project_insert(Model model, ProjectsDTO dto, HttpServletResponse response, MemberDTO mdto)throws IOException {
		if(dto.getProject_name().equals("")) {
			dto.setProject_name("프로젝트 명을 입력해 주세요.");
		}
		System.out.println("project_name : "+dto.getProject_name());

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
	public String ProjectModal(Model model, @RequestParam int num) throws IOException {
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
	@ResponseBody
	@RequestMapping("project_memberinsert.do")
	public Map<String, String> ProjectMemberInsert(ProjectsDTO dto, HttpServletResponse response) throws IOException {
		int check = 0;
		String taker = "";
		ProjectsDTO cont = this.dao_projects.getprojects(dto.getProject_no());
		List<MemberDTO> mlist = this.dao.getMemberList();
		if (cont.getProject_taker() == null) {
			check = this.dao_projects.updatetaker(dto);
			taker = dto.getProject_taker();
		} else if (cont.getProject_taker2() == null) {
			check = this.dao_projects.updatetaker2(dto);
			taker = dto.getProject_taker2();
		} else if (cont.getProject_taker3() == null) {
			check = this.dao_projects.updatetaker3(dto);
			taker = dto.getProject_taker3();
		} else if (cont.getProject_taker4() == null) {
			check = this.dao_projects.updatetaker4(dto);
			taker = dto.getProject_taker4();
		} else if (cont.getProject_taker5() == null) {
			check = this.dao_projects.updatetaker5(dto);
			taker = dto.getProject_taker5();
		}
		Map<String, String> map = new HashMap<String, String>();
		map.put("taker", taker);
		map.put("cat", "고양이");
		System.out.println(taker);
		return map;
	}

	// 프로젝트 멤버 제외하기 _ 세건
	@RequestMapping("project_Deletetaker1.do")
	public void projectDeletetaker1(ProjectsDTO dto, HttpServletResponse response) {
		int check = this.dao_projects.deletetaker1(dto);
	}

	@RequestMapping("project_Deletetaker2.do")
	public void projectDeletetaker2(ProjectsDTO dto, HttpServletResponse response) {
		int check = this.dao_projects.deletetaker2(dto);
	}

	@RequestMapping("project_Deletetaker3.do")
	public void projectDeletetaker3(ProjectsDTO dto, HttpServletResponse response) {
		int check = this.dao_projects.deletetaker3(dto);
	}

	@RequestMapping("project_Deletetaker4.do")
	public void projectDeletetaker4(ProjectsDTO dto, HttpServletResponse response) {
		int check = this.dao_projects.deletetaker4(dto);
	}

	@RequestMapping("project_Deletetaker5.do")
	public void projectDeletetaker5(ProjectsDTO dto, HttpServletResponse response) {
		int check = this.dao_projects.deletetaker5(dto);
	}

	// 프로젝트 삭제하기 _ 세건
	@RequestMapping("project_delete.do")
	public void ProjectDelete(@RequestParam int num, HttpServletResponse response) throws IOException {
		System.out.println(num);
		int check = this.dao_projects.deleteProjects(num);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (check > 0) {
			out.println("<script>");
			out.println("location.href='project_control.do'");
			out.println("</script>");
		}
	}

	// 프로젝트 status 변경 _ 세건
	@RequestMapping("project_move.do")
	public void ProjectMove(ProjectsDTO dto, HttpServletResponse response) throws IOException {
		int check = this.dao_projects.updateProjects(dto);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (check > 0) {
			out.println("<script>");
			out.println("alert('변경되었습니다.')");
			out.println("</script>");
		}
	}

	// 프로젝트 status 추가 _ 세건
	@RequestMapping("insert_status.do")
	public void InsertStatus(Projects_statusDTO dto, HttpServletResponse response) throws IOException {
		int check = this.dao_projects.insertStatus(dto);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (check > 0) {
			out.println("<script>");
			out.println("location.href='project_board.do'");
			out.println("</script>");
		}
	}

	// 프로젝트 시작일 변경 _ 세건
	@RequestMapping("project_UpdateStart.do")
	public void ProjectUpdateStart(ProjectsDTO dto, HttpServletResponse response) throws IOException {
		int check = this.dao_projects.updatestart(dto);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (check > 0) {
			out.println("<script>");
			out.println("alert('변경되었습니다.')");
			out.println("</script>");
		}
	}

	// 프로젝트 마감일 변경 _ 세건
	@RequestMapping("project_Updateend.do")
	public void ProjectUpdateEnd(ProjectsDTO dto, HttpServletResponse response) throws IOException {
		int check = this.dao_projects.updateend(dto);
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (check > 0) {
			out.println("<script>");
			out.println("alert('변경되었습니다.')");
			out.println("</script>");
		}
	}

	// 프로젝트 상세내용 추가하기 _ 세건
	@RequestMapping("project_InsertComment.do")
	public void ProjectComment(ProjectsDTO dto, HttpServletResponse response) throws IOException {
		this.dao_projects.updatecomment(dto);
		System.out.println(dto.getProject_comment());
		System.out.println(dto.getProject_no());
	}



	 // 프로젝트 보드 보기 _ 세건
	 @RequestMapping("project_board.do")
	 public String projectboard(Model model) {
	 List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsList();
	 List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
	 List<Projects_statusDTO> status = this.dao_projects.getStatusList();
	 List<MemberDTO> mlist = this.dao.getMemberList(); model.addAttribute("mlist",
	 mlist); model.addAttribute("list", list); model.addAttribute("main", main);
	 model.addAttribute("status", status);
	 return "projects_include/project_board";


	 }
	 // 프로젝트 status 변경 _ 세건
	 @RequestMapping("project_UpdateStatus.do")
	 public void updatestatus(ProjectsDTO dto, Projects_statusDTO sdto,HttpServletResponse response) throws IOException {
		 int status_no = this.dao_projects.selectStatus_no(sdto);
		 dto.setProject_status(status_no);
		 this.dao_projects.UpdateStatus(dto);
		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = response.getWriter();
	 }

	 // 프로젝트 보드 카드 생성 _ 세건
	 @RequestMapping("board_project_insert.do")
	 public void board_insert_project(ProjectsDTO dto,HttpServletResponse response) throws IOException {
		 int check = this.dao_projects.board_insertProject(dto);
		 response.setContentType("text/html; charset=UTF-8");
		 PrintWriter out = response.getWriter();
		 if (check > 0) {
				out.println("<script>");
				out.println("location.href='project_board.do'");
				out.println("</script>");
			}
	 }
	 
	 @RequestMapping("drag.do")
	 public String dragetest() {
		 return "projects_include/drag";
	 }
	

	@RequestMapping("member_login.do")	// 임시로 만든 메서드임. 추후 로그인 화면을 시작페이지로 변경 예정.
	public String login() {
		return "member/login";
	}

	@RequestMapping("member_login_ok.do")
	public String loginOk(@ModelAttribute MemberDTO dto, HttpServletRequest request) {
		HttpSession session = request.getSession();

		MemberDTO result = service.memberLogin(dto);

		if (result != null) {
			session.setAttribute("member", result);
			return "redirect:/";
		} else {
			return "redirect:member_login.do";
		}
	}

	@RequestMapping("member_logout.do")
	public String logout(HttpSession session) {
		service.memberLogout(session);

		return "redirect:member_login.do";
	}

	@RequestMapping("member_join.do")
	public String join() {

		return "member/join";
	}

	@RequestMapping("member_join_ok.do")
	public String joinOk(@ModelAttribute MemberDTO dto) {
		service.memberJoin(dto);
		return "redirect:member_login.do";
	}

	@RequestMapping("member_idCheck.do")
	@ResponseBody
	public void checkId(String mem_id, HttpServletResponse response) throws IOException {
		int result = 0;

		if (service.idCheck(mem_id) != 0) {
			result = 1;
		}
		response.getWriter().print(result);
	}

	@RequestMapping("member_edit.do")
	public ModelAndView memberEdit(@RequestParam String mem_id) {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("member/edit");
		mav.addObject("memberEdit", service.memberDetail(mem_id));

		return mav;
	}

	@RequestMapping("member_edit_ok.do")
	public String memberEditOk(@ModelAttribute MemberDTO dto) {
		service.memberEdit(dto);

		return "redirect:member_edit.do?mem_id=" + dto.getMem_id();
	}

	@RequestMapping("member_delete.do")
	public String memberDelete() {
		return "member/delete";
	}

	@RequestMapping("member_delete_ok.do")
	public String memberDeleteOk(@RequestParam String mem_id, HttpSession session) {
		service.memberDelete(mem_id, session);

		return "redirect:member_login.do";
	}

	@RequestMapping("member_findId.do")
	public String memberFindId() {
		return "member/findId";
	}

	@RequestMapping("member_findId_ok.do")
	public ModelAndView memberFindIdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		List<MemberDTO> list = service.memberFindId(dto);

		mav.setViewName("member/login");
		mav.addObject("memberFindId", list);

		return mav;
	}

	@RequestMapping("member_findPwd.do")
	public String memberFindPwd() {
		return "member/findPwd";
	}

	@RequestMapping("member_findPwd_ok.do")
	public ModelAndView memberFindPwdOk(@ModelAttribute MemberDTO dto) {
		ModelAndView mav = new ModelAndView();

		String pwd = service.memberFindPwd(dto);

		mav.setViewName("member/login");
		mav.addObject("memberFindPwd", pwd);

		return mav;
	}
}
