package com.dentalClinic.model;

import java.sql.Timestamp;
import java.time.Instant;

public class FAQ {
    private int faqId;
    private String question;
    private String answer;
    private boolean isActive;
    private Timestamp createdAt;
    
    
    
	public FAQ( String question, String answer) {
		super();
		this.question = question;
		this.answer = answer;
		this.isActive = true;
		this.createdAt = Timestamp.from(Instant.now());
	}
	
	public  FAQ()
	{
		super();
	}
	
	public int getFaqId() {
		return faqId;
	}
	public void setFaqId(int faqId) {
		this.faqId = faqId;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
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
