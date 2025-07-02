package Servlets;

import Classes.Friends.FriendsManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
// ... existing code ...
@WebServlet("/FriendServlet")
public class FriendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("search".equals(action)) {
            String query = request.getParameter("query");
            String currentUser = (String) request.getSession().getAttribute("username");
            List<String> foundUsers = FriendsManager.searchUserForFriend(currentUser, query);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.write("[");
            for (int i = 0; i < foundUsers.size(); i++) {
                out.write('"' + foundUsers.get(i) + '"');
                if (i < foundUsers.size() - 1) out.write(",");
            }
            out.write("]");
            return;
        }
    }
}
