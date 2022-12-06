package com.jspstudy.bbs.vo;

import java.sql.Timestamp;

public class Board {
	// no, title, content, writer, reg_date, read_count, pass, file1
	private int no;
	private String title;
	private String content;
	private String writer;
	private Timestamp regDate;
	private int readCount;
	private String pass;
	private String file;
	
	public Board() { }
	public Board(int no, String title, String content, String writer,
			Timestamp regDate, int readCount, String pass, String file) {
		this.no = no;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.regDate = regDate;
		this.readCount = readCount;
		this.pass = pass;
		this.file = file;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
}
