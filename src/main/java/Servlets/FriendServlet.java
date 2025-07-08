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

@WebServlet("/FriendServlet")
public class FriendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String currentUser = (String) request.getSession().getAttribute("username");
        
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        switch (action) {
            case "search":
                String query = request.getParameter("query");
                List<String> foundUsers = FriendsManager.searchUserForFriend(currentUser, query);
                out.write("[");
                for (int i = 0; i < foundUsers.size(); i++) {
                    out.write('"' + foundUsers.get(i) + '"');
                    if (i < foundUsers.size() - 1) out.write(",");
                }
                out.write("]");
                break;
                
            case "getPendingRequests":
                List<String> pendingRequests = FriendsManager.getPendingFriendRequests(currentUser);
                out.write("[");
                for (int i = 0; i < pendingRequests.size(); i++) {
                    out.write('"' + pendingRequests.get(i) + '"');
                    if (i < pendingRequests.size() - 1) out.write(",");
                }
                out.write("]");
                break;
                
            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String currentUser = (String) request.getSession().getAttribute("username");
        
        if (currentUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        switch (action) {
            case "sendRequest":
                String toUser = request.getParameter("toUser");
                if (toUser != null && !toUser.isEmpty()) {
                    boolean success = FriendsManager.sendFriendRequest(currentUser, toUser);
                    out.write("{\"success\": " + success + "}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                break;
                
            case "acceptRequest":
                String fromUser = request.getParameter("fromUser");
                if (fromUser != null && !fromUser.isEmpty()) {
                    boolean success = FriendsManager.acceptFriendRequest(fromUser, currentUser);
                    out.write("{\"success\": " + success + "}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                break;
                
            case "declineRequest":
                String fromUserDecline = request.getParameter("fromUser");
                if (fromUserDecline != null && !fromUserDecline.isEmpty()) {
                    boolean success = FriendsManager.declineFriendRequest(fromUserDecline, currentUser);
                    out.write("{\"success\": " + success + "}");
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
                break;
                
            default:
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                break;
        }
    }
}
