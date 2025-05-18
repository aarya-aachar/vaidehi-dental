package com.dentalClinic.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.Instant;

public class Appointment {
    private int appointmentId;
    private int doctorId;
    private int patientId;
    private Date appointmentDate;
    private Time appointmentTime;
    private String status; 
    private String patientDescription;
    private String doctorPrescription;
    private Timestamp createdAt;
    
    
    
    
	public Appointment(int doctorId, int patientId, Date appointmentDate, Time appointmentTime,
			String patientDescription) {
		super();
		this.doctorId = doctorId;
		this.patientId = patientId;
		this.appointmentDate = appointmentDate;
		this.appointmentTime = appointmentTime;
		this.patientDescription = patientDescription;
		this.createdAt = Timestamp.from(Instant.now());
		this.status = "pending";
		this.doctorPrescription = "";
	}
	
	public Appointment()
	{
		super();
		this.createdAt = Timestamp.from(Instant.now());
		this.status = "pending";
		this.doctorPrescription = "";
	}
	
	
	
	public int getAppointmentId() {
		return appointmentId;
	}
	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public int getPatientId() {
		return patientId;
	}
	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}
	public Date getAppointmentDate() {
		return appointmentDate;
	}
	public void setAppointmentDate(Date appointmentDate) {
		this.appointmentDate = appointmentDate;
	}
	public Time getAppointmentTime() {
		return appointmentTime;
	}
	public void setAppointmentTime(Time appointmentTime) {
		this.appointmentTime = appointmentTime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPatientDescription() {
		return patientDescription;
	}
	public void setPatientDescription(String patientDescription) {
		this.patientDescription = patientDescription;
	}
	public String getDoctorPrescription() {
		return doctorPrescription;
	}
	public void setDoctorPrescription(String doctorPrescription) {
		this.doctorPrescription = doctorPrescription;
	}
	public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "Appointment [appointmentId=" + appointmentId + ", doctorId=" + doctorId + ", patientId=" + patientId
				+ ", appointmentDate=" + appointmentDate + ", appointmentTime=" + appointmentTime + ", status=" + status
				+ ", patientDescription=" + patientDescription + ", doctorPrescription=" + doctorPrescription
				+ ", createdAt=" + createdAt + "]";
	}

}
