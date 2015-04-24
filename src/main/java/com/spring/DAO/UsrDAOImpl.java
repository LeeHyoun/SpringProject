package com.spring.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.DTO.UsrDTO;


@Repository
public class UsrDAOImpl implements UsrDAO{

	@Autowired
	private SqlSession sqlSession;
	private static final String NS = "com.library.mybatis.Usr.";
	
	@Override
	public UsrDTO getUsr(String usrId) {
		UsrDTO usr = sqlSession.selectOne(NS + "getUsr", usrId);
		return usr;
	}

}
