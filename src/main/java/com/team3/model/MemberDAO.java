package com.team3.model;

import java.util.HashMap;

public interface MemberDAO {

	int memberCheck(String id);

	MemberDTO getMember(String id);

}
