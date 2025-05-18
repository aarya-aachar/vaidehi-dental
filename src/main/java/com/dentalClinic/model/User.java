package com.dentalClinic.model;

import java.sql.Timestamp;
import java.time.Instant;

public class User {
    private int userId;
    private String firstName;
    private String lastName;
    private String email;
    private Timestamp dob;
    private String phone;
    private String address;
    private String password;
    private String role;
    private String profileImage;
    private boolean isActive;
    private Timestamp createdAt;
    
    
    

	public User(String firstName, String lastName, String email, Timestamp dob, String phone, String address,
			String password, String profileImage, boolean isActive, Timestamp createdAt) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.dob = dob;
		this.phone = phone;
		this.address = address;
		this.password = password;
		this.role = "patient";
		this.profileImage = profileImage;
		this.isActive = isActive;
		this.createdAt = createdAt;
	}
	
	
	

	public User(String firstName, String lastName, String email, Timestamp dob, String phone, String address,
			String password,  String profileImage, boolean isActive) {
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.dob = dob;
		this.phone = phone;
		this.address = address;
		this.password = password;
		this.role = "patient";
		this.profileImage = profileImage;
		this.isActive = isActive;
		this.createdAt = Timestamp.from(Instant.now());

	}




	public User(int userId, String firstName, String lastName, String email, Timestamp dob, String phone,
			String address, String password, String role, String profileImage, boolean isActive, Timestamp createdAt) {
		super();
		this.userId = userId;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.dob = dob;
		this.phone = phone;
		this.address = address;
		this.password = password;
		this.role = "patient";
		this.profileImage = profileImage;
		this.isActive = isActive;
		this.createdAt = createdAt;
	}

	
	public User() 
	{
		super();
		this.role = "patient";

	}



	public Timestamp getDob() {
		return dob;
	}

	public void setDob(Timestamp dob) {
		this.dob = dob;
	}

	public int getUserId() {
		return userId;
	}
	
	public String getFullName()
	{
		return this.firstName +" " + this.getLastName();
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return this.role;
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
	public boolean isActive() {
		return isActive;
	}
	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}




	@Override
	public String toString() {
		return "User [userId=" + userId + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email
				+ ", dob=" + dob + ", phone=" + phone + ", address=" + address + ", password=" + password + ", role="
				+ role + ", profileImage=" + profileImage + ", isActive=" + isActive + ", createdAt=" + createdAt + "]";
	}


}
