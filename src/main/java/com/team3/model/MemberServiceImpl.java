package com.team3.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO dao;

    @Override
    public MemberDTO login(MemberDTO dto) {
        return dao.login(dto);
    }

    @Override
    public void logout(HttpSession session) {
        session.invalidate();
    }

    @Override
    public void join(MemberDTO dto) {
        dao.join(dto);
    }

    @Override
    public int checkId(String mem_id) {
        return dao.checkId(mem_id);
    }
}
