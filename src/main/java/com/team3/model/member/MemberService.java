package com.team3.model.member;

import com.team3.model.DepartmentDTO;
import com.team3.model.TeamDTO;
import org.apache.ibatis.annotations.Param;

import com.team3.model.Messenger_NotiDTO;

import javax.servlet.http.HttpSession;
import java.util.List;

public interface MemberService {

    MemberDTO memberLogin(String mem_id, String mem_pwd);

    int memberJoin(MemberDTO dto);

    MemberDTO memberDetail(String mem_id);

    void memberEdit(MemberDTO dto);

    void memberDelete(MemberDTO dto, HttpSession session);

    void memberLogout(HttpSession session);

    String memberFindId(MemberDTO dto);

    int idCheck(String mem_id);

    List<DepartmentDTO> getDeptList();

    List<TeamDTO> getTeamList();

    // 로그인 시 메신저 알림 세션에 저장하기_Jisoo
    int getMemNo(String mem_id);
    List<Messenger_NotiDTO> getMemNotiDTO(int mem_no);
    int getNotiCount(int mem_no);
    
}
