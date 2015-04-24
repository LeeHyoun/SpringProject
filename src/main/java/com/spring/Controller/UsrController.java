package com.spring.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.DTO.UsrDTO;
import com.spring.Service.UsrService;

@Controller
public class UsrController {
	
	@Autowired
	UsrService usrService;
	
	@RequestMapping(value = "/usrlogin", method = { RequestMethod.POST })
	public String login(HttpServletRequest request,
			@RequestParam("usrId") String usrId,
			@RequestParam("usrPw") String usrPw,
			Model model) throws Exception {

			UsrDTO usr = usrService.getUsr(usrId);

			if (usr == null) {
				return "usrJoin";

			} else if (usrPw.equals(usr.getUsrPw())) {
				HttpSession session = request.getSession();
				session.setAttribute("usr", usr);
				System.out.println(usr);
				return "redirect:/booklist";

			} else {
				return "usrJoin";
			}
			
	}

	@RequestMapping(value = "/logout", method =  RequestMethod.POST)
	public String logout(HttpServletRequest request,
			HttpServletResponse response, @RequestParam("usrId") String usrId,
			Model model) throws Exception {

		HttpSession session = request.getSession();
		session.setAttribute("usrid", usrId);
		session.removeAttribute("usrid");
		session.invalidate();

		return "usrlogin";
	}
}
