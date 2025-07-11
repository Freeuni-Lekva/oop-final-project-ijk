package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;
import Classes.Quizzes.QuizManager.QuizAttempt;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("LogIn.jsp");
            return;
        }
        QuizManager manager = new QuizManager();
        List<Quiz> quizzes = manager.getAllQuizzes();
        request.setAttribute("quizzes", quizzes);
        List<QuizAttempt> recentAttempts = null;
        if (session.getAttribute("userId") != null) {
            int userId = (Integer) session.getAttribute("userId");
            List<QuizAttempt> allAttempts = manager.getQuizAttemptsForUser(userId);
            recentAttempts = allAttempts.size() > 3 ? allAttempts.subList(0, 3) : allAttempts;
        }
        request.setAttribute("recentAttempts", recentAttempts);
        request.getRequestDispatcher("/Home.jsp").forward(request, response);
    }
} 