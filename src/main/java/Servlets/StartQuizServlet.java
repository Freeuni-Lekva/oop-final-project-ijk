package Servlets;

import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;
import Classes.Quizzes.QuizManager.Question;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/start-quiz")
public class StartQuizServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        Quiz quiz = null;
        List<Question> questions = null;
        if (idParam != null) {
            try {
                int quizId = Integer.parseInt(idParam);
                QuizManager manager = new QuizManager();
                quiz = manager.getQuizById(quizId);
                questions = manager.getQuestionsByQuizId(quizId);
            } catch (NumberFormatException ignored) {}
        }
        if (quiz != null && questions != null) {
            request.setAttribute("quiz", quiz);
            request.setAttribute("questions", questions);
            request.getRequestDispatcher("/Quiz.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Quiz or questions not found");
        }
    }
} 