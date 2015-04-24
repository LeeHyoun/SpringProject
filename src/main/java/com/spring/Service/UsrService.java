package com.spring.Service;

import com.spring.DTO.UsrDTO;

public interface UsrService {
	
	// 유저 하나 가져오기  
	public UsrDTO getUsr(String usrId);

}
