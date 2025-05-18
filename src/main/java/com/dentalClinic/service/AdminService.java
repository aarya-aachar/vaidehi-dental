package com.dentalClinic.service;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.dentalClinic.config.DatabaseConfig;
import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.*;

public class AdminService {
	  
    
    // ================ USERS CRUD ================
    public static List<User> getAllUsers() throws SQLException, DatabaseConnectionException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setActive(rs.getBoolean("is_active"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        }
        return users;
    }

    public static boolean updateUserStatus(int userId, boolean isActive) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE users SET is_active = ? WHERE user_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setBoolean(1, isActive);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    // ================ DOCTORS CRUD ================
    public static int addDoctor(Doctor doctor) throws SQLException, DatabaseConnectionException {
        String sql = "INSERT INTO doctors (first_name, last_name, email, phone, address, " +
                     "specialization, qualifications, consultation_fee, profile_image) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, doctor.getFirstName());
            stmt.setString(2, doctor.getLastName());
            stmt.setString(3, doctor.getEmail());
            stmt.setString(4, doctor.getPhone());
            stmt.setString(5, doctor.getAddress());
            stmt.setString(6, doctor.getSpecialization());
            stmt.setString(7, doctor.getQualifications());
            stmt.setInt(8, doctor.getConsultationFee());
            stmt.setString(9, doctor.getProfileImage());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }
    
    public static Doctor getDoctorById(int doctorId) throws SQLException, DatabaseConnectionException {
        String sql = "SELECT * FROM doctors WHERE doctor_id = ?";
        Doctor doctor = null;
        
        try (Connection connection = DatabaseConfig.createConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setInt(1, doctorId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    doctor = new Doctor();
                    doctor.setDoctorId(resultSet.getInt("doctor_id"));
                    doctor.setFirstName(resultSet.getString("first_name"));
                    doctor.setLastName(resultSet.getString("last_name"));
                    doctor.setEmail(resultSet.getString("email"));
                    doctor.setPhone(resultSet.getString("phone"));
                    doctor.setAddress(resultSet.getString("address"));
                    doctor.setSpecialization(resultSet.getString("specialization"));
                    doctor.setQualifications(resultSet.getString("qualifications"));
                    doctor.setConsultationFee(resultSet.getInt("consultation_fee"));
                    doctor.setProfileImage(resultSet.getString("profile_image"));
                    doctor.setActive(resultSet.getBoolean("is_active"));
                    doctor.setCreatedAt(resultSet.getTimestamp("created_at"));
                }
            }
        }
        
        return doctor;
    }

    public static boolean updateDoctor(Doctor doctor) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE doctors SET first_name = ?, last_name = ?, email = ?, phone = ?, " +
                     "address = ?, specialization = ?, qualifications = ?, consultation_fee = ?, " +
                     "profile_image = ?, is_active = ? WHERE doctor_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setString(1, doctor.getFirstName());
            stmt.setString(2, doctor.getLastName());
            stmt.setString(3, doctor.getEmail());
            stmt.setString(4, doctor.getPhone());
            stmt.setString(5, doctor.getAddress());
            stmt.setString(6, doctor.getSpecialization());
            stmt.setString(7, doctor.getQualifications());
            stmt.setInt(8, doctor.getConsultationFee());
            stmt.setString(9, doctor.getProfileImage());
            stmt.setBoolean(10, doctor.isActive());
            stmt.setInt(11, doctor.getDoctorId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean deleteDoctor(int doctorId) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE doctors SET is_active = false WHERE doctor_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            return stmt.executeUpdate() > 0;
        }
    }

    // CREATE ==================================================================
    public static boolean createAppointment(Appointment appointment) throws SQLException, DatabaseConnectionException {
        String sql = "INSERT INTO appointments (doctor_id, patient_id, appointment_date, appointment_time, " +
                    " patient_description) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            setAppointmentParameters(stmt, appointment);
//            stmt.setString(5, "pending"); // Default status
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        appointment.setAppointmentId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    // READ ===================================================================
    public static List<Appointment> getAllAppointments() throws SQLException, DatabaseConnectionException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * from appointments";
        
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Appointment appoint = mapResultSetToAppointment(rs);
                System.out.print(appoint+": aa");

                appointments.add(appoint);
            }
        }
        System.out.print(appointments);

        return appointments;

    }

    public static Appointment getAppointmentById(int appointmentId) throws SQLException, DatabaseConnectionException {
        String sql = "SELECT a.*, u.first_name as patient_first_name, u.last_name as patient_last_name, " +
                    "d.first_name as doctor_first_name, d.last_name as doctor_last_name " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_id = u.user_id " +
                    "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                    "WHERE a.appointment_id = ?";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, appointmentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAppointment(rs);
                }
            }
        }
        return null;
    }

    public static List<Appointment> getAppointmentsByPatient(int patientId) throws SQLException, DatabaseConnectionException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, d.first_name as doctor_first_name, d.last_name as doctor_last_name " +
                    "FROM appointments a " +
                    "JOIN doctors d ON a.doctor_id = d.doctor_id " +
                    "WHERE a.patient_id = ? " +
                    "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, patientId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        }
        return appointments;
    }

    public static List<Appointment> getAppointmentsByDoctor(int doctorId) throws SQLException, DatabaseConnectionException {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT a.*, u.first_name as patient_first_name, u.last_name as patient_last_name " +
                    "FROM appointments a " +
                    "JOIN users u ON a.patient_id = u.user_id " +
                    "WHERE a.doctor_id = ? " +
                    "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, doctorId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    appointments.add(mapResultSetToAppointment(rs));
                }
            }
        }
        return appointments;
    }

    // UPDATE =================================================================
    public static boolean updateAppointment(Appointment appointment) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE appointments SET doctor_id = ?, patient_id = ?, appointment_date = ?, " +
                    "appointment_time = ?, patient_description = ? " +
                    "WHERE appointment_id = ?";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            setAppointmentParameters(stmt, appointment);
            stmt.setInt(6, appointment.getAppointmentId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean updateAppointmentStatus(int appointmentId, String status) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, appointmentId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    public static boolean updateDoctorPrescription(int appointmentId, String prescription) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE appointments SET doctor_prescription = ?, status = 'completed' WHERE appointment_id = ?";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, prescription);
            stmt.setInt(2, appointmentId);
            
            return stmt.executeUpdate() > 0;
        }
    }

    // DELETE =================================================================
    public static boolean cancelAppointment(int appointmentId) throws SQLException, DatabaseConnectionException {
        // Soft delete by changing status
        return updateAppointmentStatus(appointmentId, "cancelled");
    }
    
    public static boolean deleteAppointment(int appointmentId) throws SQLException, DatabaseConnectionException {
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DatabaseConfig.createConnection();
            String sql = "DELETE FROM appointments WHERE appointment_id = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, appointmentId);
            
            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;
        } finally {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        }
    }

    // HELPER METHODS =========================================================
    private static Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(rs.getInt("appointment_id"));
        appointment.setDoctorId(rs.getInt("doctor_id"));
        appointment.setPatientId(rs.getInt("patient_id"));
        appointment.setAppointmentDate(rs.getDate("appointment_date"));
        appointment.setAppointmentTime(rs.getTime("appointment_time"));
        appointment.setStatus(rs.getString("status"));
        appointment.setPatientDescription(rs.getString("patient_description"));
        appointment.setDoctorPrescription(rs.getString("doctor_prescription"));
        appointment.setCreatedAt(rs.getTimestamp("created_at"));
        
      
        return appointment;
    }

    private static void setAppointmentParameters(PreparedStatement stmt, Appointment appointment) throws SQLException {
        stmt.setInt(1, appointment.getDoctorId());
        stmt.setInt(2, appointment.getPatientId());
        stmt.setDate(3, new java.sql.Date(appointment.getAppointmentDate().getTime()));
        stmt.setTime(4, appointment.getAppointmentTime());
        stmt.setString(5, appointment.getPatientDescription());
    }

    // VALIDATION METHODS =====================================================
    public static boolean isTimeSlotAvailable(int doctorId, Date date, Time time) throws SQLException, DatabaseConnectionException {
        String sql = "SELECT COUNT(*) FROM appointments WHERE doctor_id = ? AND appointment_date = ? " +
                    "AND appointment_time = ? AND status NOT IN ('cancelled')";
        
        try (Connection conn = DatabaseConfig.createConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, doctorId);
            stmt.setDate(2, new java.sql.Date(date.getTime()));
            stmt.setTime(3, time);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        }
		return true;
    }
            
    
    
    

    // ================ BLOGS CRUD ================
    public static int addBlog(Blog blog) throws SQLException, DatabaseConnectionException {
        String sql = "INSERT INTO blogs (title, content, category) VALUES (?, ?, ?)";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getContent());
            stmt.setString(3, blog.getCategory());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public static boolean updateBlog(Blog blog) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE blogs SET title = ?, content = ?, category = ?, is_active = ? WHERE blog_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getContent());
            stmt.setString(3, blog.getCategory());
            stmt.setBoolean(4, blog.isActive());
            stmt.setInt(5, blog.getBlogId());
            
            return stmt.executeUpdate() > 0;
        }
    }

    // ================ FAQs CRUD ================
    public static int addFaq(FAQ faq) throws SQLException, DatabaseConnectionException {
        String sql = "INSERT INTO faqs (question, answer) VALUES (?, ?)";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, faq.getQuestion());
            stmt.setString(2, faq.getAnswer());
            
            stmt.executeUpdate();
            
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1;
    }

    public static boolean updateFaq(FAQ faq) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE faqs SET question = ?, answer = ?, is_active = ? WHERE faq_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setString(1, faq.getQuestion());
            stmt.setString(2, faq.getAnswer());
            stmt.setBoolean(3, faq.isActive());
            stmt.setInt(4, faq.getFaqId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    public  static List<Doctor> getAllDoctors() throws SQLException, DatabaseConnectionException {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM doctors WHERE is_active = true";
        
        try (Statement statement = DatabaseConfig.createConnection().prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Doctor doctor = new Doctor();
                doctor.setDoctorId(resultSet.getInt("doctor_id"));
                doctor.setFirstName(resultSet.getString("first_name"));
                doctor.setLastName(resultSet.getString("last_name"));
                doctor.setEmail(resultSet.getString("email"));
                doctor.setPhone(resultSet.getString("phone"));
                doctor.setAddress(resultSet.getString("address"));
                doctor.setSpecialization(resultSet.getString("specialization"));
                doctor.setQualifications(resultSet.getString("qualifications"));
                doctor.setConsultationFee(resultSet.getInt("consultation_fee"));
                doctor.setProfileImage(resultSet.getString("profile_image"));
                doctor.setActive(resultSet.getBoolean("is_active"));
                doctor.setCreatedAt(resultSet.getTimestamp("created_at"));
                
                doctors.add(doctor);
            }
        }
        return doctors;
    }

    // ================ TESTIMONIALS CRUD ================
    public static List<Testimonial> getAllTestimonials() throws SQLException, DatabaseConnectionException {
        List<Testimonial> testimonials = new ArrayList<>();
        String sql = "SELECT t.*, u.first_name as patient_first_name, u.last_name as patient_last_name, " +
                     "d.first_name as doctor_first_name, d.last_name as doctor_last_name " +
                     "FROM testimonials t " +
                     "JOIN users u ON t.patient_id = u.user_id " +
                     "LEFT JOIN doctors d ON t.doctor_id = d.doctor_id";
        
        try (PreparedStatement stmt =  DatabaseConfig.createConnection().prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Testimonial testimonial = new Testimonial();
                testimonial.setTestimonialId(rs.getInt("testimonial_id"));
                testimonial.setPatientId(rs.getInt("patient_id"));
                testimonial.setContent(rs.getString("content"));
                testimonial.setRating(rs.getInt("rating"));
                testimonial.setDoctorId(rs.getInt("doctor_id"));
                testimonial.setApproved(rs.getBoolean("is_approved"));
                testimonial.setActive(rs.getBoolean("is_active"));
                testimonial.setCreatedAt(rs.getTimestamp("created_at"));
                
                
                
                testimonials.add(testimonial);
            }
        }
        return testimonials;
    }

    public static boolean approveTestimonial(int testimonialId, boolean isApproved) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE testimonials SET is_approved = ? WHERE testimonial_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setBoolean(1, isApproved);
            stmt.setInt(2, testimonialId);
            return stmt.executeUpdate() > 0;
        }
    }

    // ================ TOKENS MANAGEMENT ================
    public static boolean deactivateToken(int tokenId) throws SQLException, DatabaseConnectionException {
        String sql = "UPDATE tokens SET is_active = false WHERE token_id = ?";
        
        try (PreparedStatement stmt = DatabaseConfig.createConnection().prepareStatement(sql)) {
            stmt.setInt(1, tokenId);
            return stmt.executeUpdate() > 0;
        }
    }

    
}