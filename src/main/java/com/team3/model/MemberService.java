package com.team3.model;

import javax.servlet.http.HttpSession;

public interface MemberService {

    MemberDTO login(MemberDTO dto);

    void logout(HttpSession session);

    void join(MemberDTO dto);

    int checkId(String mem_id);
}
