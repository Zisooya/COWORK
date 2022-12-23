package com.team3.model.member;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
