<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quiz - Quantum Physics Fundamentals</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.5.0/remixicon.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/QuizLanding.css?v=1">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Quiz.css?v=1">
</head>
<body>
<div class="quiz-bg">
  <div id="quiz-header" class="quiz-header"></div>
  <div class="quiz-container">
    <div id="progress-indicator"></div>
    <div id="question-display"></div>
    <div id="navigation-controls"></div>
    <div id="quiz-result" style="display:none;"></div>
  </div>
</div>
<script src="./Scripts/Quiz.js"></script>
</body>
</html>