package Servlets;

import Classes.Friends.FriendsManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
// ... existing code ...
@WebServlet("/FriendServlet")
public class FriendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("search".equals(action)) {
            String query = request.getParameter("query");
            String currentUser = (String) request.getSession().getAttribute("username");
            String foundUser = FriendsManager.searchUserForFriend(currentUser, query);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (foundUser != null) {
                out.write("{\"username\":\"" + foundUser + "\"}");
            } else {
                out.write("{}");
            }
            return;
        }
    }
}
