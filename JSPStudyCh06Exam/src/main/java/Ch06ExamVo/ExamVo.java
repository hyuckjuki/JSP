package Ch06ExamVo;

import java.sql.*;

public class ExamVo {
	
	private int no;
	private String mname;
	private String writer;
	private String pass;
	private String vocal;
	private String content;
	private Date wdate;
	private String cover;

	public ExamVo() {}

	public ExamVo(int no, String mname, String writer, String pass, String vocal,
			String content, Date wdate, String cover) {
		
		this.no = no;
		this.mname = mname;
		this.writer = writer;
		this.pass = pass;
		this.vocal = vocal;
		this.content = content;
		this.wdate = wdate;
		this.cover = cover;
	}
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getVocal() {
		return vocal;
	}

	public void setVocal(String vocal) {
		this.vocal = vocal;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getWdate() {
		return wdate;
	}

	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}

	public String getCover() {
		return cover;
	}

	public void setCover(String cover) {
		this.cover = cover;
	}
}


