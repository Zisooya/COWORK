package com.team3.model;

public interface MemberDAO {

	int memberCheck(String id);

	MemberDTO getMember(String pwd);
}
