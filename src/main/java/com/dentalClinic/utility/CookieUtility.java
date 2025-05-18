
package com.dentalClinic.utility;

import java.util.Arrays;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class CookieUtility {
	
	
	   public static Cookie createCookie(String name, String value, Integer maxAge, boolean secure) {
	        Cookie cookie = new Cookie(name, value);
	        cookie.setPath("/");
	        cookie.setMaxAge(maxAge);
	        cookie.setSecure(secure);
	        return cookie;
	    }
	   
	   public static Cookie createCookie(String name, String value) {
	        Cookie cookie = new Cookie(name, value);
	        cookie.setPath("/");
	        cookie.setHttpOnly(true);	        
	        return cookie;
	    }
	   
	   // Delete all cookies
	    public static void deleteAllCookies(HttpServletRequest request, HttpServletResponse response) {
	        Cookie[] cookies = request.getCookies();
	        if (cookies != null) {
	            Arrays.stream(cookies).forEach(cookie -> {
	                Cookie deletedCookie = new Cookie(cookie.getName(), "");
	                deletedCookie.setPath("/");
	                deletedCookie.setMaxAge(0); // Immediately expire
	                response.addCookie(deletedCookie);
	            });
	        }
	    }
	    
	    
	    public static String getCookieValue(HttpServletRequest request, String cookieName) {
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
	    
	    
	    // Delete specific cookie by name
	    public static void deleteCookie(HttpServletResponse response, String cookieName) {
	        Cookie cookie = new Cookie(cookieName, "");
	        cookie.setPath("/");
	        cookie.setMaxAge(0); // Immediately expire
	        response.addCookie(cookie);
	    }
	    
}
