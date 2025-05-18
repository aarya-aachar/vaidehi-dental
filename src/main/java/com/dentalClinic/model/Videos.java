package com.dentalClinic.model;

import java.sql.Timestamp;

public class Videos {
	
	private int videoId ;
	private String name;
	private String link;
	private boolean is_active;
	private Timestamp createdAt;
	
	
	public Videos(String name, String link) {
		super();
		this.name = name;
		this.link = link;
	}
	
	public Videos() {  super();  }
	
	public int getVideoId() {
		return videoId;
	}
	public void setVideoId(int videoId) {
		this.videoId = videoId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
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
