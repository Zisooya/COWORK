package com.team3.model.member;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface MemberService {

    MemberDTO memberLogin(MemberDTO dto);

    void memberJoin(MemberDTO dto);

    MemberDTO memberDetail(String mem_id);

    void memberEdit(MemberDTO dto);

    void memberDelete(String mem_id, HttpSession session);

    void memberLogout(HttpSession session);

    String memberFindId(MemberDTO dto);

    String memberFindPwd(MemberDTO dto);

    int idCheck(String mem_id);
}
