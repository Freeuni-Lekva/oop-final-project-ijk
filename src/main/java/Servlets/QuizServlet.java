package Servlets;

import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;
import Classes.Quizzes.QuizManager.QuizAttempt;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/quizzes")
public class QuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        QuizManager manager = new QuizManager();
        List<Quiz> quizzes = manager.getAllQuizzes();
        request.setAttribute("quizzes", quizzes);
        java.util.Map<String, Integer> categoryCounts = manager.getQuizCountByCategory();
        request.setAttribute("categoryCounts", categoryCounts);
        java.util.Map<Integer, Integer> questionCounts = new java.util.HashMap<>();
        for (Quiz q : quizzes) {
            questionCounts.put(q.id, manager.getQuestionCountForQuiz(q.id));
        }
        request.setAttribute("questionCounts", questionCounts);
        // Add recent attempts for the logged-in user
        HttpSession session = request.getSession(false);
        List<QuizAttempt> recentAttempts = null;
        if (session != null && session.getAttribute("userId") != null) {
            int userId = (Integer) session.getAttribute("userId");
            List<QuizAttempt> allAttempts = manager.getQuizAttemptsForUser(userId);
            recentAttempts = allAttempts.size() > 3 ? allAttempts.subList(0, 3) : allAttempts;
        }
        request.setAttribute("recentAttempts", recentAttempts);
        request.getRequestDispatcher("/Quizzes.jsp").forward(request, response);
    }
}
