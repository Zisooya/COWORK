package com.team3.model.member;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team3.model.Messenger_NotiDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO dao;

    @Override
    public MemberDTO memberLogin(MemberDTO dto) {
        return dao.memberLogin(dto);
    }

    @Override
    public void memberJoin(MemberDTO dto) {
        dao.memberJoin(dto);
    }

    @Override
    public MemberDTO memberDetail(String mem_id) {
        return dao.memberDetail(mem_id);
    }

    @Override
    public void memberEdit(MemberDTO dto) {
        dao.memberEdit(dto);
    }

    @Override
    public void memberDelete(String mem_id, HttpSession session) {
        session.invalidate();
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
