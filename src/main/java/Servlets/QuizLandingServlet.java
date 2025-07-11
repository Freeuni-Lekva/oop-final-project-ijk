package Servlets;

import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/quiz-landing")
public class QuizLandingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        Quiz quiz = null;
        if (idParam != null) {
            try {
                int quizId = Integer.parseInt(idParam);
                QuizManager manager = new QuizManager();
                quiz = manager.getQuizById(quizId);
            } catch (NumberFormatException ignored) {}
        }
        if (quiz != null) {
            request.setAttribute("quiz", quiz);
            QuizManager manager = new QuizManager();
            int questionCount = manager.getQuestionCountForQuiz(quiz.id);
            request.setAttribute("questionCount", questionCount);
            request.getRequestDispatcher("/QuizLanding.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Quiz not found");
        }
    }
} 