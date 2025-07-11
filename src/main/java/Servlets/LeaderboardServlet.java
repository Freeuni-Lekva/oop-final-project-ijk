package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import Classes.Leaderboard.LeaderboardManager;
import Classes.Quizzes.QuizManager;
import Classes.Friends.FriendsManager;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        LeaderboardManager leaderboardManager = new LeaderboardManager();
        List<LeaderboardManager.UserPointsEntry> leaderboard = leaderboardManager.getAllUserPoints();
        request.setAttribute("leaderboard", leaderboard);
        if (session != null && session.getAttribute("userId") != null && session.getAttribute("username") != null) {
            int userId = (Integer) session.getAttribute("userId");
            String username = (String) session.getAttribute("username");
            int userRank = leaderboardManager.getUserRank(userId);
            QuizManager quizManager = new QuizManager();
            int userPoints = quizManager.getUserPoints(userId);
            request.setAttribute("userRank", userRank);
            request.setAttribute("userPoints", userPoints);
            // Friends leaderboard
            List<String> friends = FriendsManager.getFriendsList(username);
            friends.add(username); // include self
            List<LeaderboardManager.UserPointsEntry> all = leaderboardManager.getAllUserPoints();
            List<LeaderboardManager.UserPointsEntry> friendsLeaderboard = new java.util.ArrayList<>();
            for (LeaderboardManager.UserPointsEntry entry : all) {
                if (friends.contains(entry.username)) {
                    friendsLeaderboard.add(entry);
                }
            }
            request.setAttribute("friendsLeaderboard", friendsLeaderboard);
        }
        request.getRequestDispatcher("/Leaderboard.jsp").forward(request, response);
    }
} 