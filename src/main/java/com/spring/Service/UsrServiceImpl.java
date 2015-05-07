package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.dao.UsrDAO;
import com.spring.dto.UsrDTO;


@Service
@Transactional
public class UsrServiceImpl implements UsrService {
	@Autowired
	UsrDAO usrDAO;

	@Override
	// @Transactional(readOnly=true)
	public UsrDTO getUsr(String usrId) {
		
		UsrDTO usrDTO = usrDAO.getUsr(usrId);
		
		return usrDTO;
		
	}
}
