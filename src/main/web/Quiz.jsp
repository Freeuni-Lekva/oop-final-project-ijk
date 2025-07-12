<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Classes.Quizzes.QuizManager.Quiz" %>
<%@ page import="Classes.Quizzes.QuizManager.Question" %>
<%! // Helper for JS escaping
  public static String escapeJS(String s) {
    if (s == null) return "";
    return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
  }
%>
<%
  Quiz quiz = (Quiz) request.getAttribute("quiz");
  List<Question> questions = (List<Question>) request.getAttribute("questions");
  String username = quiz != null ? quiz.user : "User";
  int duration = quiz != null ? quiz.duration : 25;
  String quizTitle = quiz != null ? quiz.name : "Quiz";
  int totalQuestions = questions != null ? questions.size() : 0;
  // Build questions JSON
  StringBuilder questionsJson = new StringBuilder();
  questionsJson.append("[");
  if (questions != null) {
    for (int i = 0; i < questions.size(); i++) {
      Question q = questions.get(i);
      // Find correct answer index
      String[] opts = (q.possibleAnswers != null ? q.possibleAnswers : "").split(q.possibleAnswers != null && q.possibleAnswers.contains("\n") ? "\\n" : ";");
      int correctIndex = -1;
      for (int j = 0; j < opts.length; j++) {
        if (opts[j].trim().equals(q.answer != null ? q.answer.trim() : "")) {
          correctIndex = j;
          break;
        }
      }
      questionsJson.append("{")
              .append("\"id\":").append(q.id).append(",")
              .append("\"type\":").append(q.type).append(",")
              .append("\"question\":\"").append(escapeJS(q.question)).append("\",")
              .append("\"possibleAnswers\":\"").append(escapeJS(q.possibleAnswers != null ? q.possibleAnswers : "")).append("\",")
              .append("\"correctIndex\":").append(correctIndex).append(",")
              .append("\"answer\":\"").append(escapeJS(q.answer == null ? "" : q.answer)).append("\"")
              .append("}");
      if (i < questions.size() - 1) questionsJson.append(",");
    }
  }
  questionsJson.append("]");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" type="image/png" href="./images/Logo.png">
  <title>quizition</title>
  <!-- Google Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  <!-- Remixicon -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
  <link rel="stylesheet" type="text/css" href="CSS/Quiz.css">
  <script defer src="Scripts/Quiz.js"></script>
</head>
<body class="quiz-bg">
<div class="quiz-header">
  <div class="quiz-header-content">
    <div>
      <div class="quiz-header-title" id="quiz-title"><%= quizTitle %></div>
      <div class="quiz-header-meta" id="quiz-meta">
        Question <span id="current-question-number">1</span> of <span id="total-questions"><%= totalQuestions %></span>
      </div>
    </div>
    <div class="quiz-header-timer blue" id="quiz-timer">
      <span id="timer-value"><%= String.format("%02d:00", duration) %></span>
    </div>
  </div>
</div>
<div class="quiz-container">
  <div class="progress-card">
    <div class="progress-title">Progress</div>
    <div class="progress-bar-container">
      <div style="position:relative;">
        <svg class="progress-bar-svg">
          <circle cx="40" cy="40" r="36" stroke="#f3f4f6" stroke-width="8" fill="none"/>
          <circle id="progress-bar" cx="40" cy="40" r="36" stroke="#2563eb" stroke-width="8" fill="none" stroke-dasharray="226.2" stroke-dashoffset="0"/>
        </svg>
        <div class="progress-bar-text" id="progress-bar-text">0%</div>
      </div>
      <div>
        <div id="progress-answered">0 of <%= totalQuestions %> answered</div>
        <div class="progress-questions" id="progress-questions"></div>
        <div class="progress-legend">
          <div class="progress-legend-item"><span class="progress-legend-dot answered"></span>Answered</div>
          <div class="progress-legend-item"><span class="progress-legend-dot current"></span>Current</div>
          <div class="progress-legend-item"><span class="progress-legend-dot unanswered"></span>Unanswered</div>
        </div>
      </div>
    </div>
  </div>
  <div class="question-card" id="question-card">
    <div class="question-number">
      <span class="question-number-badge" id="question-number-badge">1</span>
      <span id="question-number-label">Question 1</span>
    </div>
    <div class="question-title" id="question-title">Loading question...</div>
    <div class="options-list" id="options-list"></div>
  </div>
  <div class="navigation-card">
    <div class="navigation-controls">
      <button class="nav-btn prev" id="prev-btn">&larr; Previous</button>
      <button class="nav-btn next" id="next-btn">Next &rarr;</button>
    </div>
  </div>
</div>
<script>
  window.quizData = {
    quiz: {
      id: <%= quiz != null ? quiz.id : 0 %>,
      name: "<%= escapeJS(quizTitle) %>",
      user: "<%= escapeJS(username) %>",
      duration: <%= duration %>
    },
    questions: JSON.parse('<%= questionsJson.toString() %>')
  };
</script>
</body>
</html>
