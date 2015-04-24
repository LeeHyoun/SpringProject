package com.spring.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.DAO.UsrDAO;
import com.spring.DTO.UsrDTO;


@Service
@Transactional
public class UsrServiceImpl implements UsrService {
	@Autowired
	UsrDAO usrDAO;

	@Override
	// @Transactional(readOnly=true)
	public UsrDTO getUsr(String usrId) {
		return usrDAO.getUsr(usrId);
	}

}
