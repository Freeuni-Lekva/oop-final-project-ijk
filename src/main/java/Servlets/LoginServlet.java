package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import Classes.Login.AccountManager;
import Classes.Quizzes.QuizManager;
import Classes.Quizzes.QuizManager.Quiz;
import Classes.Quizzes.QuizManager.QuizAttempt;
import java.util.List;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private AccountManager accountManager;

    @Override
    public void init() throws ServletException {
        // Initialize the AccountManager once when the servlet is created for efficiency.
        this.accountManager = new AccountManager();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect GET requests to the login page
        response.sendRedirect("LogIn.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Use the AccountManager to get a detailed authentication result.
        AccountManager.LoginResult result = accountManager.authenticateUser(username, password);

        // Handle the result with a switch statement for clarity.
        switch (result) {
            case SUCCESS:
                // User is valid, create session and redirect to the home page.
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                Boolean requestNotification = accountManager.getRequestNotification(username);
                session.setAttribute("requestNotification", requestNotification);
                int userId = accountManager.getUserIdByUsername(username);
                session.setAttribute("userId", userId);
                // Fetch quizzes and recent attempts for activity
                QuizManager manager = new QuizManager();
                List<Quiz> quizzes = manager.getAllQuizzes();
                request.setAttribute("quizzes", quizzes);
                List<QuizAttempt> recentAttempts = null;
                List<QuizAttempt> allAttempts = null;
                if (userId != -1) {
                    List<QuizAttempt> allFetchedAttempts = manager.getQuizAttemptsForUser(userId);
                    allAttempts = allFetchedAttempts;
                    recentAttempts = allAttempts.size() > 3 ? allAttempts.subList(0, 3) : allAttempts;
                }
                request.setAttribute("recentAttempts", recentAttempts);
                request.setAttribute("allAttempts", allAttempts);
                request.getRequestDispatcher("/Home.jsp").forward(request, response);
                break;
            case USER_NOT_FOUND:
                // Username does not exist, redirect with a specific error.
                response.sendRedirect("LogIn.jsp?error=user_not_found");
                break;
            case INCORRECT_PASSWORD:
                // Password was incorrect, redirect with a specific error.
                response.sendRedirect("LogIn.jsp?error=incorrect_password");
                break;
            case DB_ERROR:
            default:
                // A database error occurred, redirect with a generic error.
                response.sendRedirect("LogIn.jsp?error=db_error");
                break;
        }
    }
}
