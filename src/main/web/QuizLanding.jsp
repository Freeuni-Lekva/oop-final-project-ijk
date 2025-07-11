<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Platform</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.5.0/remixicon.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/QuizLanding.css?v=1">
</head>
<body>
<div class="main-bg">
    <div class="container center">
        <div class="mb-8">
            <div class="icon-circle mb-4">
                <i class="ri-book-open-line icon-3xl text-white"></i>
            </div>
            <h1 class="title mb-4">Quiz Platform</h1>
            <p class="subtitle mb-8">Test your knowledge with our comprehensive quiz system</p>
        </div>
        <div class="card mb-8">
            <h2 class="card-title mb-4">Featured Quiz</h2>
            <div class="quiz-feature mb-6">
                <h3 class="quiz-title mb-2"><%= ((request.getAttribute("quiz") != null) ? ((Classes.Quizzes.QuizManager.Quiz)request.getAttribute("quiz")).name : "") %></h3>
                <p class="quiz-desc mb-4"><%= ((request.getAttribute("quiz") != null) ? ((Classes.Quizzes.QuizManager.Quiz)request.getAttribute("quiz")).description : "") %></p>
                <div class="quiz-meta">
                    <div class="meta-item"><i class="ri-question-line"></i><span><%= (request.getAttribute("questionCount") != null ? request.getAttribute("questionCount") : 0) %> Questions</span></div>
                    <div class="meta-item"><i class="ri-time-line"></i><span><%= (request.getAttribute("quiz") != null ? ((Classes.Quizzes.QuizManager.Quiz)request.getAttribute("quiz")).duration : "") %> Minutes</span></div>
                    <%
                    String difficultyLabel = "";
                    if (request.getAttribute("quiz") != null) {
                        int diff = ((Classes.Quizzes.QuizManager.Quiz)request.getAttribute("quiz")).difficulty;
                        if (diff == 1) difficultyLabel = "Easy";
                        else if (diff == 2) difficultyLabel = "Medium";
                        else if (diff == 3) difficultyLabel = "Hard";
                    }
                    %>
                    <div class="meta-item"><i class="ri-award-line"></i><span><%= difficultyLabel %> Level</span></div>
                </div>
            </div>
            <a href="Quiz.jsp" class="btn btn-primary">
                <span>Start Quiz</span>
                <i class="ri-arrow-right-line"></i>
            </a>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon green"><i class="ri-trophy-line"></i></div>
                <h3 class="feature-title">Track Progress</h3>
                <p class="feature-desc">Monitor your performance and see detailed results</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon blue"><i class="ri-time-line"></i></div>
                <h3 class="feature-title">Timed Challenges</h3>
                <p class="feature-desc">Test your knowledge under time pressure</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon purple"><i class="ri-book-line"></i></div>
                <h3 class="feature-title">Expert Content</h3>
                <p class="feature-desc">Questions crafted by subject matter experts</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>