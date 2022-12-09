package com.team3.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDAO dao;

    @Override
    public boolean loginCheck(MemberDTO dto, HttpSession session) {
        boolean result = dao.loginCheck(dto);

        if (result) {
            MemberDTO member = getMember(dto);

            session.setAttribute("memId", member.getMem_id());
            session.setAttribute("memName", member.getMem_name());
        }

        return result;
    }

    @Override
    public MemberDTO getMember(MemberDTO dto) {
        return dao.getMember(dto);
    }

    @Override
    public void logout(HttpSession session) {
        session.invalidate();
    }
}
