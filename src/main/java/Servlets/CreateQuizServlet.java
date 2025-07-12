package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
import Classes.Quizzes.CreateQuizManager;
import Classes.Quizzes.CreateQuizManager.QuizData;
import Classes.Quizzes.CreateQuizManager.QuestionData;
import Classes.Quizzes.CreateQuizManager.QuizCreationResult;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.http.Part;

@WebServlet("/createquiz")
public class CreateQuizServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        
        // Forward to the CreateQuiz.jsp page
        request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login");
            return;
        }
        
        try {
            // Get quiz basic information
            String quizName = request.getParameter("quizTitle");
            String quizCategory = request.getParameter("quizCategory");
            String quizDifficultyStr = request.getParameter("quizDifficulty");
            String quizDescription = request.getParameter("quizDescription");
            String durationStr = request.getParameter("quizDuration");
            
            // Get quiz settings
            String randomQuestionsStr = request.getParameter("randomQuestions");
            String onePageModeStr = request.getParameter("onePageMode");
            String immediateCorrectionStr = request.getParameter("immediateCorrection");
            
            // Validate required fields
            if (quizName == null || quizName.trim().isEmpty() ||
                quizCategory == null || quizCategory.trim().isEmpty() ||
                quizDifficultyStr == null || quizDifficultyStr.trim().isEmpty() ||
                durationStr == null || durationStr.trim().isEmpty()) {
                
                request.setAttribute("error", "Please fill in all required fields.");
                request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
                return;
            }
            
            // Parse duration
            int duration;
            try {
                duration = Integer.parseInt(durationStr);
                if (duration < 1 || duration > 120) {
                    throw new NumberFormatException("Duration out of range");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Please enter a valid duration (1-120 minutes).");
                request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
                return;
            }
            
            // Parse boolean settings
            boolean randomQuestions = "on".equals(randomQuestionsStr);
            boolean onePageMode = "on".equals(onePageModeStr);
            boolean immediateCorrection = "on".equals(immediateCorrectionStr);
            
            // Get username (not userId)
            String username = (String) session.getAttribute("username");
            if (username == null || username.trim().isEmpty()) {
                request.setAttribute("error", "User session error: username not found.");
                request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
                return;
            }
            
            // Map difficulty string to int
            int difficulty = 1;
            if (quizDifficultyStr.equalsIgnoreCase("easy")) difficulty = 1;
            else if (quizDifficultyStr.equalsIgnoreCase("medium")) difficulty = 2;
            else if (quizDifficultyStr.equalsIgnoreCase("hard")) difficulty = 3;
            
            // Create quiz data object
            QuizData quizData = new QuizData(
                quizName.trim(),
                quizCategory.trim(),
                difficulty,
                quizDescription != null ? quizDescription.trim() : "",
                duration,
                randomQuestions,
                onePageMode,
                immediateCorrection,
                username.trim()
            );

            // If randomQuestions is checked, skip user questions and set category
            if (randomQuestions) {
                quizData.category = "Random Quiz";
                quizData.questions = new ArrayList<>(); // No user questions
            } else {
                // Process questions
                List<QuestionData> questions = processQuestions(request);
                if (questions.isEmpty()) {
                    request.setAttribute("error", "Please add at least one question.");
                    request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
                    return;
                }
                quizData.questions = questions;
            }

            // Create quiz using CreateQuizManager
            CreateQuizManager quizManager = new CreateQuizManager();
            QuizCreationResult result = quizManager.createQuiz(quizData);
            
            if (result.success) {
                // Quiz created successfully
                request.setAttribute("success", "Quiz created successfully! Quiz ID: " + result.quizId);
                response.sendRedirect("quizzes?success=quiz_created&quizId=" + result.quizId);
            } else {
                // Quiz creation failed
                request.setAttribute("error", "Failed to create quiz: " + result.message);
                request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while creating the quiz: " + e.getMessage());
            request.getRequestDispatcher("/CreateQuiz.jsp").forward(request, response);
        }
    }
    
    private List<QuestionData> processQuestions(HttpServletRequest request) {
        List<QuestionData> questions = new ArrayList<>();
        
        // Get all question parameters
        String[] questionTexts = request.getParameterValues("questionText[]");
        String[] questionTypes = request.getParameterValues("questionType[]");
        String[] correctAnswers = request.getParameterValues("correctAnswer[]");
        String[] optionTexts = request.getParameterValues("optionText[]");
        // For image upload
        Part[] imageParts = null;
        try {
            imageParts = request.getParts().stream()
                .filter(p -> p.getName().equals("image[]"))
                .toArray(Part[]::new);
        } catch (Exception e) {
            imageParts = null;
        }
        
        // Debug output
        System.out.println("questionTexts: " + java.util.Arrays.toString(questionTexts));
        System.out.println("questionTypes: " + java.util.Arrays.toString(questionTypes));
        System.out.println("correctAnswers: " + java.util.Arrays.toString(correctAnswers));
        System.out.println("optionTexts: " + java.util.Arrays.toString(optionTexts));
        System.out.println("Total questions to process: " + (questionTexts != null ? questionTexts.length : 0));
        
        if (questionTexts == null || questionTypes == null || correctAnswers == null) {
            return questions;
        }

        int optionIndex = 0;
        int imageIndex = 0;
        for (int i = 0; i < questionTexts.length; i++) {
            String questionText = questionTexts[i];
            String questionTypeStr = questionTypes[i];
            String correctAnswer = correctAnswers[i];
            
            // Parse type early for optionIndex logic
            int questionType = -1;
            try {
                questionType = Integer.parseInt(questionTypeStr);
            } catch (NumberFormatException e) {
                // If it's MC, still increment optionIndex
                if (questionTypeStr != null && questionTypeStr.trim().equals("1")) {
                    optionIndex += 4;
                }
                continue;
            }

            // Skip empty questions
            boolean skip = false;
            if (questionText == null || questionText.trim().isEmpty() ||
                questionTypeStr == null || questionTypeStr.trim().isEmpty() ||
                correctAnswer == null || correctAnswer.trim().isEmpty()) {
                skip = true;
            }
            if (skip) {
                if (questionType == 1) {
                    optionIndex += 4;
                }
                continue;
            }

            // Create question data
            QuestionData questionData = new QuestionData(
                questionText.trim(),
                questionType,
                correctAnswer.trim()
            );

            // Handle multiple choice options
            if (questionType == 1) { // Multiple Choice
                List<String> options = new ArrayList<>();
                if (optionTexts != null && optionIndex + 4 <= optionTexts.length) {
                    for (int j = 0; j < 4; j++) {
                        String optionText = optionTexts[optionIndex++];
                        if (optionText != null && !optionText.trim().isEmpty()) {
                            options.add(optionText.trim());
                        }
                    }
                } else {
                    // Even if not enough options, increment index to keep in sync
                    optionIndex += 4;
                }
                questionData.options = CreateQuizManager.buildOptionsString(options);
            } else {
                questionData.options = "";
            }

            // Handle image upload for Picture-Response questions
            if (questionType == 4) { // Picture-Response
                // Save image file and store path
                if (imageParts != null && imageIndex < imageParts.length) {
                    Part imagePart = imageParts[imageIndex++];
                    if (imagePart != null && imagePart.getSize() > 0) {
                        try {
                            String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                            String uploadDir = request.getServletContext().getRealPath("/images/");
                            Files.createDirectories(Paths.get(uploadDir));
                            String filePath = uploadDir + java.io.File.separator + fileName;
                            imagePart.write(filePath);
                            questionData.imagePath = request.getContextPath() + "/images/" + fileName;
                        } catch (Exception ex) {
                            questionData.imagePath = null;
                        }
                    }
                }
            }

            questions.add(questionData);
        }
        
        System.out.println("Questions processed: " + questions.size());
        return questions;
    }
} 