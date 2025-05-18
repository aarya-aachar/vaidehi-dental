package com.dentalClinic.model;

import java.sql.Timestamp;
import java.time.Instant;


public class AuthUser 
{

    private int userId;
    private String email;
    private String role;
    private String profileImage;
    private String fname;
    private Timestamp timeStamp ;
    
    
	public AuthUser(int userId, String fname, String email, String role, String profileImage) {
		super();
		this.userId = userId;
		this.fname = fname;
		this.email = email;
		this.role = role;
		this.profileImage = profileImage;
		this.timeStamp = Timestamp.from(Instant.now());
	}
	
	
	
	
	
	public Timestamp getTimeStamp() {
		return timeStamp;
	}




	public void setTimeStamp(Timestamp timeStamp) {
		this.timeStamp = timeStamp;
	}




	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getProfileImage() {
		return profileImage;
	}
	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}




	@Override
	public String toString() {
		return "AuthUser [userId=" + userId + ", email=" + email + ", role=" + role + ", profileImage=" + profileImage
				+ ", fname=" + fname + "]";
	}
	
	
	
    
    
    
}
