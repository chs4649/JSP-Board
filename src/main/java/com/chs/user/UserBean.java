package com.chs.user;

public class UserBean {

	private String userID;
	private String userPW;
	private String userName;
	private String userGender;
	private String userEmail;

	public UserBean() {
		// TODO Auto-generated constructor stub
	}

	public UserBean(String userID, String userPW, String userName, String userGender, String userEmail) {
		super();
		this.userID = userID;
		this.userPW = userPW;
		this.userName = userName;
		this.userGender = userGender;
		this.userEmail = userEmail;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUserPW() {
		return userPW;
	}

	public void setUserPW(String userPW) {
		this.userPW = userPW;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserGender() {
		return userGender;
	}

	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

}
