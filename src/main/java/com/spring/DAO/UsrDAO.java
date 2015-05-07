package com.spring.dao;

import com.spring.dto.UsrDTO;

public interface UsrDAO {
	
	// 유저 하나 가져오기  
	public UsrDTO getUsr(String usrId);
		
}
