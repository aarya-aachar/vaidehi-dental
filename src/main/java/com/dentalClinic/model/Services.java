package com.dentalClinic.model;

import java.sql.Timestamp;
import java.time.Instant;

public class Services 
{

	private int serviceId ;
	private String name;
	private String description;
	private String coverImage; 
	private boolean is_active;
	private Timestamp createdAt;
	
	public Services(String name, String description, String coverImage) {
		super();
		this.name = name;
		this.description = description;
		this.coverImage = coverImage;
		this.is_active = true ;
		this.createdAt = Timestamp.from(Instant.now());
	}

	public int getServiceId() {
		return serviceId;
	}

	public void setServiceId(int serviceId) {
		this.serviceId = serviceId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}

	public boolean isIs_active() {
		return is_active;
	}

	public void setIs_active(boolean is_active) {
		this.is_active = is_active;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	
	
	
	
}
