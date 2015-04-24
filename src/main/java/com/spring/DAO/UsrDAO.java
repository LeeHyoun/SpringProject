package com.spring.DAO;

import com.spring.DTO.UsrDTO;

public interface UsrDAO {
	
	// 유저 하나 가져오기  
	public UsrDTO getUsr(String usrId);
		
}
