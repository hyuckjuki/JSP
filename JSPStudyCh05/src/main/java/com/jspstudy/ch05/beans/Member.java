package com.jspstudy.ch05.beans;

public class Member {	
	
	private String name, id, pass, phone, gender, interest, job;
	private boolean noticeMail, addMail, infoMail;	
	
	public Member(String name, 
			String id, String pass, String phone) {
		this.name = name;
		this.id = id;
		this.pass = pass;
		this.phone = phone;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public boolean isNoticeMail() {
		return noticeMail;
	}
	public void setNoticeMail(boolean noticeMail) {
		this.noticeMail = noticeMail;
	}
	public boolean isAddMail() {
		return addMail;
	}
	public void setAddMail(boolean addMail) {
		this.addMail = addMail;
	}
	public boolean isInfoMail() {
		return infoMail;
	}
	public void setInfoMail(boolean infoMail) {
		this.infoMail = infoMail;
	}
}
