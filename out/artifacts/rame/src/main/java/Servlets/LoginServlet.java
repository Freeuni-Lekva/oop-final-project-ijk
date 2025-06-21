package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the login page
        response.sendRedirect("LogIn.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Simple authentication logic (you should implement proper authentication)
        if (isValidUser(username, password)) {
            // Create session and redirect to dashboard
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("loggedIn", true);
            
            response.sendRedirect("dashboard.jsp");
        } else {
            // Invalid credentials, redirect back to login with error
            response.sendRedirect("LogIn.jsp?error=1");
        }
    }
    
    private boolean isValidUser(String username, String password) {
        // Simple validation - replace with proper authentication logic
        // For demo purposes, accept any non-empty username/password
        return username != null && !username.trim().isEmpty() && 
               password != null && !password.trim().isEmpty();
    }
}
