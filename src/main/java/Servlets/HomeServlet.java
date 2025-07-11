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
import Classes.Leaderboard.LeaderboardManager;
import Classes.Achievements.Achievements;

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
        java.util.Map<Integer, Integer> questionCounts = new java.util.HashMap<>();
        for (Quiz q : quizzes) {
            questionCounts.put(q.id, manager.getQuestionCountForQuiz(q.id));
        }
        request.setAttribute("questionCounts", questionCounts);
        List<QuizAttempt> recentAttempts = null;
        List<QuizAttempt> allAttempts = null;
        if (session.getAttribute("userId") != null) {
            int userId = (Integer) session.getAttribute("userId");
            List<QuizAttempt> allFetchedAttempts = manager.getQuizAttemptsForUser(userId);
            allAttempts = allFetchedAttempts;
            recentAttempts = allAttempts.size() > 3 ? allAttempts.subList(0, 3) : allAttempts;
        }
        request.setAttribute("recentAttempts", recentAttempts);
        request.setAttribute("allAttempts", allAttempts);
        LeaderboardManager leaderboardManager = new LeaderboardManager();
        List<LeaderboardManager.UserPointsEntry> leaderboard = leaderboardManager.getTopUsersByPoints(10);
        request.setAttribute("leaderboard", leaderboard);
        if (session.getAttribute("userId") != null) {
            int userId = (Integer) session.getAttribute("userId");
            int userRank = leaderboardManager.getUserRank(userId);
            int userPoints = manager.getUserPoints(userId);
            int dailyGoals = manager.getDailyGoalsCompleted(userId);
            int quizAccuracy = manager.getQuizAccuracy(userId);
            int dailyStreak = manager.getDailyPointsStreak(userId);
            int userMaxPointsSum = manager.getUserMaxPointsSum(userId);
            request.setAttribute("userMaxPointsSum", userMaxPointsSum);
            request.setAttribute("userRank", userRank);
            request.setAttribute("userPoints", userPoints);
            request.setAttribute("dailyGoals", dailyGoals);
            request.setAttribute("quizAccuracy", quizAccuracy);
            request.setAttribute("dailyStreak", dailyStreak);
            // Update all achievements
            Achievements achievementsManager = new Achievements();
            achievementsManager.updateAllAchievements(userId);
            java.util.Map<String, Boolean> achievements = achievementsManager.getAchievementsForUser(userId);
            request.setAttribute("achievements", achievements);
        }
        request.getRequestDispatcher("/Home.jsp").forward(request, response);
    }
} 