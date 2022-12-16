package com.team3.model.member;

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
        dto.setMem_name(dto.getMem_name());
        dto.setMem_id(dto.getMem_id());
        dto.setMem_pwd(dto.getMem_pwd());
        dto.setMem_position(dto.getMem_position());
        dto.setMem_rank(dto.getMem_rank());
        dto.setDept_name(dto.getDept_name());
        dto.setTeam_name(dto.getTeam_name());
        dto.setMem_email(dto.getMem_email());
        dto.setMem_phone(dto.getMem_phone());
        dto.setMem_image(dto.getMem_image());

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
    public List<MemberDTO> memberFindId(MemberDTO dto) {
        return dao.memberFindId(dto);
    }

    @Override
    public String memberFindPwd(MemberDTO dto) {
        return dao.memberFindPwd(dto);
    }

    @Override
    public int idCheck(String mem_id) {
        return dao.idCheck(mem_id);
    }
}
