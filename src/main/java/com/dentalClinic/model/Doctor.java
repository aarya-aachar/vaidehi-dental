package com.dentalClinic.model;

import java.sql.Timestamp;

public class Doctor {
    private int doctorId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String address;
    private String specialization;
    private String qualifications;
    private Integer consultationFee;
    private String profileImage;
    private boolean isActive;
    private Timestamp createdAt;
    
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
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
	public String getSpecialization() {
		return specialization;
	}
	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}
	public String getQualifications() {
		return qualifications;
	}
	public void setQualifications(String qualifications) {
		this.qualifications = qualifications;
	}
	public Integer getConsultationFee() {
		return consultationFee;
	}
	public void setConsultationFee(Integer consultationFee) {
		this.consultationFee = consultationFee;
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
		return "Doctor [doctorId=" + doctorId + ", firstName=" + firstName + ", lastName=" + lastName + ", email="
				+ email + ", phone=" + phone + ", address=" + address + ", specialization=" + specialization
				+ ", qualifications=" + qualifications + ", consultationFee=" + consultationFee + ", profileImage="
				+ profileImage + ", isActive=" + isActive + ", createdAt=" + createdAt + "]";
	}

}
