package Servlets;

import Classes.Quizzes.QuizManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/submit-quiz-attempt")
public class SubmitQuizAttemptServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        String username = (String) session.getAttribute("username");
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        // Simple manual JSON parsing (assumes well-formed input)
        String json = sb.toString();
        int quizId = extractInt(json, "quizId");
        int score = extractInt(json, "score");
        int total = extractInt(json, "total");
        int percent = extractInt(json, "percent");
        QuizManager manager = new QuizManager();
        manager.insertQuizAttempt(userId, quizId, score, 0);
        // Recalculate and update user points after this attempt
        manager.recalculateAndUpdateUserPoints(userId);
        response.setStatus(HttpServletResponse.SC_OK);
    }

    private int extractInt(String json, String key) {
        String pattern = "\"" + key + "\":";
        int idx = json.indexOf(pattern);
        if (idx == -1) return 0;
        int start = idx + pattern.length();
        int end = start;
        while (end < json.length() && Character.isDigit(json.charAt(end))) end++;
        return Integer.parseInt(json.substring(start, end));
    }
} 