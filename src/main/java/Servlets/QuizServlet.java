package Servlets;

import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;

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
        request.getRequestDispatcher("/Quizzes.jsp").forward(request, response);
    }
}
