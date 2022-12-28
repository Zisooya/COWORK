package com.team3.model.member;

import com.team3.model.DepartmentDTO;
import com.team3.model.TeamDTO;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.team3.model.Messenger_NotiDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO dao;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Override
    public MemberDTO memberLogin(String mem_id, String mem_pwd) {
        MemberDTO loginMember = dao.selectMember(mem_id);

        System.out.println("loginMember >> " + loginMember);
        System.out.println("passwordEncoder >> " + passwordEncoder.encode(mem_pwd));


        return loginMember != null && passwordEncoder.matches(mem_pwd, loginMember.getMem_pwd()) ? loginMember : null;
    }

    @Override
    public int memberJoin(MemberDTO dto) {
        int result = 0;

        dto.setMem_pwd(passwordEncoder.encode(dto.getMem_pwd()));
        result = dao.memberJoin(dto);

        return result;
    }

    @Override
    public MemberDTO memberDetail(String mem_id) {
        return dao.memberDetail(mem_id);
    }

    @Override
    public void memberEdit(MemberDTO dto) {
        dto.setMem_pwd(passwordEncoder.encode(dto.getMem_pwd()));
        dao.memberEdit(dto);
    }

    @Override
    public void memberDelete(String mem_id) {
        dao.memberDelete(mem_id);
    }

    @Override
    public void memberLogout(HttpSession session) {
        session.invalidate();
    }

    @Override
    public String memberFindId(MemberDTO dto) {
        return dao.memberFindId(dto);
    }

    @Override
    public int idCheck(String mem_id) {
        return dao.idCheck(mem_id);
    }

    @Override
    public List<DepartmentDTO> getDeptList() {
        return dao.getDeptList();
    }

    @Override
    public List<TeamDTO> getTeamList() {
        return dao.getTeamList();
    }

    // 로그인 시 메신저 알림 세션에 저장하기_Jisoo
	@Override
	public List<Messenger_NotiDTO> getMemNotiDTO(int mem_no) {
		return dao.getMemNotiDTO(mem_no);
	}

	@Override
	public int getMemNo(String mem_id) {
		return dao.getMemNo(mem_id);
	}

	@Override
	public int getNotiCount(int mem_no) {
		return dao.getNotiCount(mem_no);
	}
}
