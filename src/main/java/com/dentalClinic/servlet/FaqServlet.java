package com.dentalClinic.servlet;

import java.io.IOException;

import com.dentalClinic.config.DatabaseConfig.DatabaseConnectionException;
import com.dentalClinic.model.FAQ;
import com.dentalClinic.service.FaqService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class FaqServlet
 */
@WebServlet("/admin/faq")
public class FaqServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");
        
        // Validate input
        if (!isValidFAQInput(question, answer)) {
            return;
        }
        
        FAQ faq = new FAQ(question.trim(), answer.trim());
        try {
			int createdId = FaqService.createFAQ(faq);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // Store result or do further processing
    }
	
	
	/**
	 * @see HttpServlet#doDelete(HttpServletRequest, HttpServletResponse)
	 */
	 protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String faqIdParam = request.getParameter("id");
	        
	        // Validate input
	        if (faqIdParam == null || !isValidId(faqIdParam)) {
	            return;
	        }
	        
	        int faqId = Integer.parseInt(faqIdParam);
	        try {
				boolean deleted = FaqService.deleteFAQ(faqId);
			} catch (DatabaseConnectionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        

	    }
	
	
	
	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String faqIdParam = request.getParameter("id");
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");
        
        // Validate input
        if (faqIdParam == null || !isValidId(faqIdParam) || !isValidFAQInput(question, answer)) {
            return;
        }
        
        int faqId = Integer.parseInt(faqIdParam);
        FAQ existingFaq;
		try {
			existingFaq = FaqService.getFAQById(faqId);
			if (existingFaq != null) {
	            existingFaq.setQuestion(question.trim());
	            existingFaq.setAnswer(answer.trim());
	            try {
					boolean updated = FaqService.updateFAQ(existingFaq);
				} catch (DatabaseConnectionException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            // Store result or do further processing
	        }
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
    }
	
	 private boolean isValidFAQInput(String question, String answer) {
	        return question != null && !question.trim().isEmpty() && 
	               answer != null && !answer.trim().isEmpty();
	    }
	
	
	private boolean isValidId(String idParam) {
        if (idParam == null) return false;
        try {
            int id = Integer.parseInt(idParam);
            return id > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

}
