package com.dentalClinic.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import com.dentalClinic.utility.CookieUtility;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login", "/register", "/", "/about", "/blog", 
        "/contact", "/logout", "/public", "/assets"
    );

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String path = request.getRequestURI().substring(request.getContextPath().length());

        // Bypass authentication for public paths
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }
     

        // Validate user role from cookie
        String userRole = getCookieValue(request, "user_role");
        
     // General authentication requirement
        if (userRole == null) {
        	 request.getSession().invalidate();
             CookieUtility.deleteAllCookies(request, response);
            redirectToLogin(request, response);
            return;
        }
       
        // Admin path protection
        if (path.startsWith("/admin")) {
            if (!"admin".equals(userRole)) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, 
                    "Cannot Access this endpoint");
                return;
            }
            chain.doFilter(request, response);
            return;
        }
        
        // Patient path protection
        if (path.startsWith("/patient") || path.equals("/patient")) {
            if (!"patient".equals(userRole)) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, 
                    "Cannot Access this endpoint");
                return;
            }
            chain.doFilter(request, response);
            return;
        }

        

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path) {
        return PUBLIC_PATHS.stream().anyMatch(path::equals);
    }

    private String getCookieValue(HttpServletRequest request, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookieName.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        String originalRequest = request.getRequestURI();
        
        if (request.getQueryString() != null) {
            originalRequest += "?" + request.getQueryString();
        }
        
        HttpSession session = request.getSession(true);
        session.setAttribute("originalRequest", originalRequest);
        
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}