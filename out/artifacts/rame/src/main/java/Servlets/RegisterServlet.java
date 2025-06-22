package Servlets;

import Classes.Login.AccountManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private AccountManager accountManager;

    @Override
    public void init() throws ServletException {
        accountManager = new AccountManager();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        if (accountManager.usernameExists(username)) {
            response.sendRedirect("Register.jsp?error=username_exists");
        } else {
            boolean success = accountManager.registerUser(username, password, email);
            if (success) {
                response.sendRedirect("LogIn.jsp?register=success");
            } else {
                response.sendRedirect("Register.jsp?error=db_error");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Register.jsp");
    }
} 