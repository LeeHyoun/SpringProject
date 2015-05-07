package com.spring.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

// 요청이 들어온 해당 uri를 판별해 인증과정을 거친다.

@WebFilter("/")
public class FilterImpl implements Filter {
	
    /**
    * init() : init() 메소드가 호출되면 필더가 생성된다.
    * 필터가 생된후 첫번째로 usr는 애플리케이션에서 호출된다.
    */
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {  }
    
    /**
    * doFilter() : doFilter() 메소드는 서블릿이 호출되기 전에 필터에 매핑된
    * 필터를 호출하도록 한다. 이 필더는 usr와 매핑되어 있으며,
    * 메소드는 usr 액션 이전에 호출되어 전달된다.
    */
   /* public void doFilter(ServletRequest request, ServletResponse response,
        FilterChain chain) throws IOException, ServletException {
        	
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        
        String uri = req.getRequestURI(); // "/" 의 요청은 무조건 필터로 처음 오게된다.
        System.out.println("req.getRequestURI() ====>>> "+ uri);
        
         * 여기서 필터는 주소값이 /usrlogin 로 요청이 왔다면, 로그인 인증처리를 위해서 패스
         * /usrlogin 를 거치지 않고온 나머지 것들은 세션이 살아있다면, 그전에 로그인이 되어있는 것들이므로 패스,
         * 반면 살아있는 세션이 없다는 것은 로그인이 처리가 되지 않았으므로 다시 로그인 페이지로 강제 이동시킴. 
         
        
        HttpSession session = req.getSession();
        String id = (String) session.getAttribute("usr");
        
        // 세션으로 부터 id라는 key의 Attribute를 가져온다. /usrlogin 을 한번도 안거쳤다면, 세션은 비어있을 것이다.
        
        if(uri.indexOf("usrlogin") < 0){ // /usrlogin 가 없으면 -1을 반환
        	// 1. 주소에 usrlogin 가 없다면.
        	System.out.println("[필터 : 인증되지 않은 요청이 들어왔습니다.]\n인증을 시도해 보겠습니다...");
        	
        	if( id == null || id.trim().length() <= 0 ){ // 1-1. 세션값이 없다면. (로그인 되어있지 않다면)
        		System.out.println("[필터 : 로그인 되지 않은 사용자 입니다.]\n[로그인 페이지로 강제 이동시켰습니다.]");
        		res.sendRedirect("joinform");
        		return;
    
        	}else { //1-2. 세션 값이 있다는건, 이미 한번 로그인처리를 통해 인증이 된 사용자의 요청이 있었다는 증거.
        		//이미 로그인이 되어있다.
        		System.out.println("[필터 : " + id + "님의 요청입니다.]\n패스합니다.");
        	}
        }else { // 2. 주소에 /usrlogin 가 있다면, 로그인을 시도했다는 것이므로, 인증을 위해 패스해준다.
        	System.out.println("[필터 : 로그인 요청이 들어왔습니다.]\n패스합니다.");
        	
        }
        
        chain.doFilter(request, response); //필터 패스
        
    }*/

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException ,ServletException {
		// seq 에 얻어오는 세션을 HttpServletRequest 으로 형변환 
		HttpServletRequest req = (HttpServletRequest)request;
		
		//세션객체 얻어오기
		HttpSession session = req.getSession();
		
		boolean login_flag = false; //로그인 되어있는지 확인하기
		
		if( session != null ){
			//세션에서 id 꺼내오기 (로그인한 사용자는 세션에 id가 저장되어 있음)
			String id = (String)session.getAttribute("usr");
			
			if( id != null ){ //로그인한 사용자라면
				login_flag = true; //로그인 상태를 true로 설정
			}
		}
		
		if( login_flag ){ //로그인 한경우
			chain.doFilter(request, response);
		}else { //로그인 안한경우
			HttpServletResponse resp = (HttpServletResponse)response;
			resp.encodeURL("/*");
			resp.sendRedirect("joinform"); //로그인 페이지로 이동.
		}
	}
	
    /**
     * destroy() : destroy() 메소드는 필터가 서비스를 벗어나는 경우 호출된다.
     */
 	@Override
     public void destroy() {  }
   
}