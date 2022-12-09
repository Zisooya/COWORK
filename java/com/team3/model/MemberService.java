package com.team3.model;

import javax.servlet.http.HttpSession;

public interface MemberService {

    boolean loginCheck(MemberDTO dto, HttpSession session);

    MemberDTO getMember(MemberDTO dto);

    void logout(HttpSession session);
}
