package com.jspstudy.bbs.service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 모든 모델 클래스가 구현하는 슈퍼 인터페이스
public interface CommandProcess {	
	public abstract String requestProcess(
			HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException;
}
