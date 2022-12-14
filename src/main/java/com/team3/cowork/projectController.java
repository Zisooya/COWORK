package com.team3.cowork;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.team3.model.Main_ProjectsDTO;
import com.team3.model.MemberDAO;
import com.team3.model.MemberDTO;
import com.team3.model.PageDTO;
import com.team3.model.ProjectsDAO;
import com.team3.model.ProjectsDTO;
import com.team3.model.Projects_statusDTO;

@Controller
public class projectController {

	
	// ProjectDAO 변수 생성 _ 세건
		@Autowired
		private ProjectsDAO dao_projects;
		
	// MemeberDAO 변수 생성
		@Autowired
		private MemberDAO dao;
		
	// 한 페이지당 보여질 게시물의 수
	private final int rowsize = 15;
	
	// DB 상의 전체 게시물의 수
	private int totalRecord = 0;
	
	// 프로젝트 목록 생성 페이지 _ 세건
	@RequestMapping("project_control.do")
	public String project_control(Model model,HttpServletRequest request) {
		List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
		List<Projects_statusDTO> status = this.dao_projects.getStatusList();
		List<MemberDTO> mlist = this.dao.getMemberList();
		model.addAttribute("mlist", mlist);
		model.addAttribute("main", main);
		model.addAttribute("status", status);
		
		// 페이징
		int page;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;
		}
		totalRecord = this.dao_projects.getListCount();
		com.team3.model.PageDTO dto = new com.team3.model.PageDTO(page, rowsize, totalRecord);
		List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsList(dto);
		model.addAttribute("list", list);
		model.addAttribute("Paging", dto);
		return "project_control";
	}
	
	// 프로젝트 테이블 검색 _ 세건
		 @RequestMapping("project_search.do")
		 public String project_search(Model model,HttpServletRequest request,PageDTO dto) {
			List<Main_ProjectsDTO> main = this.dao_projects.getMainList();
			List<Projects_statusDTO> status = this.dao_projects.getStatusList();
			List<MemberDTO> mlist = this.dao.getMemberList();
			model.addAttribute("mlist", mlist);
			model.addAttribute("main", main);
			model.addAttribute("status", status);
			
			// 페이징
			int page;
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}else {
				page = 1;
			}
			totalRecord = this.dao_projects.getListCount();
			String field = request.getParameter("field").trim();
			String keyword = request.getParameter("keyword").trim();
			dto = new com.team3.model.PageDTO(page, rowsize, totalRecord, field, keyword);
			
			if(dto.getField().equals("name")) {
				List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsListByname(dto);
				model.addAttribute("list", list);
			}else {
				List<com.team3.model.ProjectsDTO> list = this.dao_projects.getProjectsListByProjects(dto);
				model.addAttribute("list", list);
			}
			model.addAttribute("Paging", dto);
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
	 
	 
	 
}