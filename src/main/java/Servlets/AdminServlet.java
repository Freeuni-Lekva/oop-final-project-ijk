package Servlets;

import Classes.Admin.AdminManager;
import Classes.Admin.AdminManager.User;
import Classes.Admin.AdminManager.Quiz;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("administrator"))) {
            response.sendRedirect("Home.jsp");
            return;
        }
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quizdb", "root", "Alerteki1!")) {
            AdminManager adminManager = new AdminManager();
            request.setAttribute("userCount", adminManager.getUserCount(conn));
            request.setAttribute("quizAttemptsCount", adminManager.getQuizAttemptsCount(conn));
            List<User> users = adminManager.getAllUsers(conn);
            List<Quiz> quizzes = adminManager.getAllQuizzes(conn);
            request.setAttribute("adminUsers", users);
            request.setAttribute("adminQuizzes", quizzes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("Admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (session == null || !Boolean.TRUE.equals(session.getAttribute("administrator"))) {
            out.write("{\"success\":false,\"error\":\"Unauthorized\"}");
            return;
        }
        String action = request.getParameter("action");
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/quizdb", "root", "Alerteki1!")) {
            AdminManager adminManager = new AdminManager();
            boolean success = false;
            if ("removeUser".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                success = adminManager.removeUser(conn, userId);
            } else if ("removeQuiz".equals(action)) {
                int quizId = Integer.parseInt(request.getParameter("quizId"));
                success = adminManager.removeQuiz(conn, quizId);
            } else if ("promoteUser".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                success = adminManager.promoteUserToAdmin(conn, userId);
            }
            out.write("{\"success\":" + success + "}");
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\":false,\"error\":\"Exception\"}");
        }
    }
} 