package com.team3.model;

import javax.servlet.http.HttpSession;
import java.util.Map;

public interface MemberService {

    MemberDTO login(MemberDTO dto);

    void logout(HttpSession session);
}
