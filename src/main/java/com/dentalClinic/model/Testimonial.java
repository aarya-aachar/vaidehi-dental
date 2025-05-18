package com.dentalClinic.model;

import java.sql.Timestamp;

public class Testimonial {
    private int testimonialId;
    private int patientId;
    private String content;
    private int rating;
    private Integer doctorId; 
    private boolean isApproved;
    private boolean isActive;
    private Timestamp createdAt;
    
    
	public Testimonial(int patientId, String content, int rating, Integer doctorId) {
		super();
		this.patientId = patientId;
		this.content = content;
		this.rating = rating;
		this.doctorId = doctorId;
	}
	
	public Testimonial()
	{
		super();
	}
	
	public int getTestimonialId() {
		return testimonialId;
	}
	public void setTestimonialId(int testimonialId) {
		this.testimonialId = testimonialId;
	}
	public int getPatientId() {
		return patientId;
	}
	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public Integer getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(Integer doctorId) {
		this.doctorId = doctorId;
	}
	public boolean isApproved() {
		return isApproved;
	}
	public void setApproved(boolean isApproved) {
		this.isApproved = isApproved;
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


}
