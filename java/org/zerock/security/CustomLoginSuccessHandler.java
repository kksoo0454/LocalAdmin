package org.zerock.security;

/* 
   AuthenticationSuccessHandler �������̽� ��� ���� Ŭ����
    = �α��� ������ �ڵ� ȣ��Ǿ� ����� ���ѿ� ���� �ٸ� URL�� �����̷�Ʈ
   Authentication ��ü = �������� (�����, ���� ����)
 */ 
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("Login Succ");
/* ���� ����Ʈ ���� */
		List<String> roleNames = new ArrayList<String>();
/* �ٽ� API = Authentication.getAuthorities()�� ���� ���� */
		auth.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("ROLE NAMES : " + roleNames);

/* �α��� ���� �� ���ѿ� ���� �ٸ� URL�� �����̷�Ʈ */
		if(roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/resident/list");
			return;
		}
		
		response.sendRedirect("/404");		
	}
}
