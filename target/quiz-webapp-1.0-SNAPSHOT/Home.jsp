<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 6/22/2025
  Time: 7:16 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="./images/Logo.png">
    <title>Quizition</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#0483cc',
                        secondary: '#5b0c8b',
                        accent: '#121d92'
                    },
                    borderRadius: {
                        'none': '0px',
                        'sm': '4px',
                        DEFAULT: '8px',
                        'md': '12px',
                        'lg': '16px',
                        'xl': '20px',
                        '2xl': '24px',
                        '3xl': '32px',
                        'full': '9999px',
                        'button': '8px'
                    }
                }
            }
        }
    </script>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Remixicon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <!-- Your custom CSS -->
    <link rel="stylesheet" href="./CSS/Home.css">
</head>
<body class="bg-gray-50 min-h-screen flex flex-col">
<!-- Notification Popup -->
<div id="notification" class="notification-popup">
    <div class="notification-icon">
        <i class="ri-award-line ri-lg"></i>
    </div>
    <div>
        <h4 class="font-semibold text-gray-900">Achievement Unlocked!</h4>
        <p class="text-sm text-gray-600">You've earned the "Quiz Master" badge</p>
    </div>
</div>
<!-- Header -->
<header class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-4 flex items-center justify-between">
        <div class="flex items-center">
            <img href="/Home.jsp" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
            <nav class="hidden md:flex space-x-6">
                <a href="./Home.jsp" class="text-primary font-medium">Home</a>
                <a href="quizzes" class="text-gray-600 hover:text-primary transition-colors">Quizzes</a>
                <a href="#" class="text-gray-600 hover:text-primary transition-colors">Leaderboard</a>
                <a href="#" class="text-gray-600 hover:text-primary transition-colors">Achievements</a>
            </nav>
        </div>
        <div class="flex items-center space-x-4">
            <div class="relative">
                <button id="categoryDropdown" class="flex items-center text-gray-700 hover:text-primary transition-colors">
                    <svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" fill="#1979bb" class="bi bi-tags-fill categories-icon" viewBox="0 0 16 16">
                        <path d="M2 2a1 1 0 0 1 1-1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 2 6.586zm3.5 4a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
                        <path d="M1.293 7.793A1 1 0 0 1 1 7.086V2a1 1 0 0 0-1 1v4.586a1 1 0 0 0 .293.707l7 7a1 1 0 0 0 1.414 0l.043-.043z"/>
                    </svg>
                </button>
                <div id="categoryMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Speed Challange</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Question-Response</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Fill in the Blank</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Multiple Choice</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Picture-Response</a>
                </div>
            </div>
            <!-- Friend Requests Icon and Dropdown -->
            <div class="relative">
                <button id="friendRequestsBtn" style="height:38px;display:flex;align-items:center;justify-content:center;background:none;border:none;cursor:pointer;padding:0;position:relative;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" fill="#5b0c8b" class="bi bi-person-fill-add friend-requests-icon" viewBox="0 0 16 16">
                        <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6"/>
                    </svg>
                    <% if (Boolean.TRUE.equals(session.getAttribute("requestNotification"))) { %>
                        <span id="friendRequestDot" style="position:absolute;top:6px;right:6px;width:12px;height:12px;background:#e53e3e;border-radius:50%;border:2px solid #fff;z-index:10;"></span>
                    <% } %>
                </button>
                <div id="friendRequestsDropdown" class="hidden absolute right-0 mt-2 w-64 bg-white rounded-md shadow-lg py-4 px-6 z-20 border border-gray-200" style="min-width:200px;">
                    <div id="friendRequestsList" class="text-center text-gray-700">no new friend requests</div>
                </div>
            </div>
            <div class="h-6 w-px bg-gray-200"></div>
            <div class="relative">
                <button id="userDropdown" class="flex items-center space-x-2">
                    <span class="hidden md:inline text-sm font-medium text-gray-700">
                        <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
                    </span>
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-arrow-down-s-line text-gray-400"></i>
                    </div>
                </button>
                <div id="userMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Profile</a>
                    <a href="#" id="openAddFriendModal" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Add Friend</a>
                    <a href="#" id="openFriendsModal" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Friends</a>
                    <div class="h-px bg-gray-200 my-1"></div>
                    <form action="logout" method="post" style="margin: 0;">
                        <button type="submit" class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" style="background: none; border: none; cursor: pointer;">
                            Log Out
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- Main Content -->
<main class="flex-grow container mx-auto px-4 py-8">
    <div class="max-w-6xl mx-auto">
        <!-- Welcome Section -->
        <div class="text-center mb-12">
            <h1 class="text-4xl font-bold text-gray-900 mb-4">Welcome to Quizition</h1>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">Challenge yourself with our diverse collection of quizzes. Test your knowledge, earn achievements, and compete with others!</p>
        </div>
        <!-- Quiz Types Grid -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-12">
            <div class="bg-gradient-to-br from-primary to-primary/80 rounded-lg p-6 text-white transform hover:scale-105 transition-transform cursor-pointer shadow-lg">
                <div class="w-12 h-12 flex items-center justify-center bg-white/20 rounded-lg mb-4">
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-shuffle" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M0 3.5A.5.5 0 0 1 .5 3H1c2.202 0 3.827 1.24 4.874 2.418.49.552.865 1.102 1.126 1.532.26-.43.636-.98 1.126-1.532C9.173 4.24 10.798 3 13 3v1c-1.798 0-3.173 1.01-4.126 2.082A9.6 9.6 0 0 0 7.556 8a9.6 9.6 0 0 0 1.317 1.918C9.828 10.99 11.204 12 13 12v1c-2.202 0-3.827-1.24-4.874-2.418A10.6 10.6 0 0 1 7 9.05c-.26.43-.636.98-1.126 1.532C4.827 11.76 3.202 13 1 13H.5a.5.5 0 0 1 0-1H1c1.798 0 3.173-1.01 4.126-2.082A9.6 9.6 0 0 0 6.444 8a9.6 9.6 0 0 0-1.317-1.918C4.172 5.01 2.796 4 1 4H.5a.5.5 0 0 1-.5-.5"/>
                        <path d="M13 5.466V1.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192m0 9v-3.932a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192"/>
                    </svg>
                </div>
                <h3 class="text-xl font-semibold mb-2">Random Quiz</h3>
                <p class="text-white/80 mb-4">Test your general knowledge across random topics</p>
                <div class="flex items-center text-sm">
                    <span>Start Quiz</span>
                    <div class="w-5 h-5 flex items-center justify-center ml-1">
                        <i class="ri-arrow-right-line"></i>
                    </div>
                </div>
            </div>
            <div class="bg-gradient-to-br from-secondary to-secondary/80 rounded-lg p-6 text-white transform hover:scale-105 transition-transform cursor-pointer shadow-lg">
                <div class="w-12 h-12 flex items-center justify-center bg-white/20 rounded-lg mb-4">
                    <i class="ri-timer-line ri-xl"></i>
                </div>
                <h3 class="text-xl font-semibold mb-2">Speed Challenge</h3>
                <p class="text-white/80 mb-4">Race against time to answer questions quickly</p>
                <div class="flex items-center text-sm">
                    <span>Start Quiz</span>
                    <div class="w-5 h-5 flex items-center justify-center ml-1">
                        <i class="ri-arrow-right-line"></i>
                    </div>
                </div>
            </div>
            <div class="bg-gradient-to-br from-accent to-accent/80 rounded-lg p-6 text-white transform hover:scale-105 transition-transform cursor-pointer shadow-lg">
                <div class="w-12 h-12 flex items-center justify-center bg-white/20 rounded-lg mb-4">
                    <i class="ri-trophy-line ri-xl"></i>
                </div>
                <h3 class="text-xl font-semibold mb-2">Daily Challenge</h3>
                <p class="text-white/80 mb-4">New questions every day to keep you sharp</p>
                <div class="flex items-center text-sm">
                    <span>Start Quiz</span>
                    <div class="w-5 h-5 flex items-center justify-center ml-1">
                        <i class="ri-arrow-right-line"></i>
                    </div>
                </div>
            </div>
        </div>
        <!-- Progress and Activity Section -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-12">
            <!-- Your Progress -->
            <div class="bg-white rounded-lg shadow-sm p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-gray-900 flex items-center">
                        <div class="w-6 h-6 flex items-center justify-center text-primary mr-2">
                            <i class="ri-line-chart-line"></i>
                        </div>
                        Your Progress
                    </h2>
                    <button class="text-sm text-primary hover:text-primary/80 transition-colors">Today</button>
                </div>
                <div class="space-y-4">
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Daily Goals</span>
                            <span class="text-sm text-gray-500"><%= request.getAttribute("dailyGoals") != null ? request.getAttribute("dailyGoals") : 0 %>/5 completed</span>
                        </div>
                        <div class="progress-bar">
                            <% int dailyGoalsWidth = (int)Math.round(100.0 * (request.getAttribute("dailyGoals") != null ? (Integer)request.getAttribute("dailyGoals") : 0) / 5); %>
                            <div class="progress-fill" style="width: <%= dailyGoalsWidth %>%;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Quiz Accuracy</span>
                            <span class="text-sm text-gray-500"><%= request.getAttribute("quizAccuracy") != null ? request.getAttribute("quizAccuracy") : 0 %>%</span>
                        </div>
                        <div class="progress-bar">
                            <% int quizAccuracyWidth = (request.getAttribute("quizAccuracy") != null ? (Integer)request.getAttribute("quizAccuracy") : 0); %>
                            <div class="progress-fill" style="width: <%= quizAccuracyWidth %>%;"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Daily Points</span>
                            <span class="text-sm text-gray-500"><%= request.getAttribute("userMaxPointsSum") != null ? request.getAttribute("userMaxPointsSum") : 0 %> Pts</span>
                        </div>
                        <div class="progress-bar">
                            <% int dailyStreakWidth = (int)Math.round(100.0 * (request.getAttribute("dailyStreak") != null ? (Integer)request.getAttribute("dailyStreak") : 0) / 7); %>
                            <div class="progress-fill" style="width: <%= dailyStreakWidth %>%;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Recent Activity -->
            <div class="bg-white rounded-lg shadow-sm p-6">
                <div class="flex justify-between items-center mb-6">
                    <h2 class="text-xl font-bold text-gray-900 flex items-center">
                        <div class="w-6 h-6 flex items-center justify-center text-primary mr-2">
                            <i class="ri-time-line"></i>
                        </div>
                        Recent Activity
                    </h2>
                    <button class="text-sm text-primary hover:text-primary/80 transition-colors" onclick="openActivityModal()">View All</button>
                </div>
                <div class="space-y-4">
                    <% java.util.List recentAttempts = (java.util.List) request.getAttribute("recentAttempts"); %>
                    <% java.util.List quizzes = (java.util.List) request.getAttribute("quizzes"); %>
                    <% java.util.Map questionCounts = (java.util.Map) request.getAttribute("questionCounts"); %>
                    <% if (recentAttempts != null && !recentAttempts.isEmpty()) {
                        for (Object obj : recentAttempts) {
                            Classes.Quizzes.QuizManager.QuizAttempt attempt = (Classes.Quizzes.QuizManager.QuizAttempt) obj;
                            String quizName = "Quiz #" + attempt.quizId;
                            int difficulty = 1;
                            for (Object qObj : quizzes) {
                                Classes.Quizzes.QuizManager.Quiz quiz = (Classes.Quizzes.QuizManager.Quiz) qObj;
                                if (quiz.id == attempt.quizId) { quizName = quiz.name; difficulty = quiz.difficulty; break; }
                            }
                            int percent = (int)Math.round(attempt.score);
                            int realPercent = (int)Math.round((attempt.score / (questionCounts.get(attempt.quizId) instanceof Integer ? (Integer)questionCounts.get(attempt.quizId) : 1)) * 100);
                            java.util.Date now = new java.util.Date();
                            long diffMillis = now.getTime() - attempt.takenAt.getTime();
                            long diffHours = diffMillis / (1000 * 60 * 60);
                            long diffDays = diffHours / 24;
                            String timeAgo;
                            if (diffHours < 24) {
                                timeAgo = diffHours + (diffHours == 1 ? " hour ago" : " hours ago");
                            } else if (diffDays < 7) {
                                timeAgo = diffDays + (diffDays == 1 ? " day ago" : " days ago");
                            } else {
                                long weeks = diffDays / 7;
                                timeAgo = weeks + (weeks == 1 ? " week ago" : " weeks ago");
                            }
                            int xp = percent;
                            if (difficulty == 2) xp = percent * 2;
                            if (difficulty == 3) xp = percent * 3;
                            String xpClass = difficulty == 1 ? "text-primary" : (difficulty == 2 ? "text-secondary" : "text-accent");
                            String bgClass = difficulty == 1 ? "bg-primary/10 text-primary" : (difficulty == 2 ? "bg-secondary/10 text-secondary" : "bg-accent/10 text-accent");
                    %>
                    <div class="flex items-center">
                        <div class="w-10 h-10 rounded-full <%= bgClass %> flex items-center justify-center mr-3">
                            <i class="ri-trophy-line"></i>
                        </div>
                        <div class="flex-grow">
                            <p class="text-sm font-medium text-gray-900">Completed <%= quizName %></p>
                            <p class="text-xs text-gray-500">Score: <%= realPercent %>% • <%= timeAgo %></p>
                        </div>
                        <div class="text-sm font-medium <%= xpClass %>">+<%= xp %> Pts</div>
                    </div>
                    <%   }
                       } else { %>
                    <div class="text-gray-400 text-sm">No recent activity.</div>
                    <% } %>
                </div>
            </div>
        </div>
        <!-- Achievements Section -->
        <%
            java.util.Map achievements = (java.util.Map) request.getAttribute("achievements");
            boolean fastLearnerActive = false;
            boolean onFireActive = false;
            boolean geniusActive = false;
            boolean championActive = false;
            if (achievements != null) {
                if (achievements.get("FAST_LEARNER") != null) fastLearnerActive = (Boolean) achievements.get("FAST_LEARNER");
                if (achievements.get("ON_FIRE") != null) onFireActive = (Boolean) achievements.get("ON_FIRE");
                if (achievements.get("GENIUS") != null) geniusActive = (Boolean) achievements.get("GENIUS");
                if (achievements.get("CHAMPION") != null) championActive = (Boolean) achievements.get("CHAMPION");
            }
        %>
        <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 flex items-center">
                    <div class="w-6 h-6 flex items-center justify-center text-primary mr-2">
                        <i class="ri-medal-line"></i>
                    </div>
                    Your Achievements
                </h2>
                <button class="text-sm text-primary hover:text-primary/80 transition-colors flex items-center">
                    View All
                    <div class="w-5 h-5 flex items-center justify-center ml-1">
                        <i class="ri-arrow-right-s-line"></i>
                    </div>
                </button>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-primary to-primary/80 mb-2 <%= fastLearnerActive ? "ring-4 ring-blue-400" : "opacity-40" %>">
                        <i class="ri-rocket-line ri-lg"></i>
                    </div>
                    <span class="text-sm font-medium text-gray-700">Fast Learner</span>
                    <span class="text-xs text-gray-500">Complete 5 quizzes</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-secondary to-secondary/80 mb-2 <%= onFireActive ? "ring-4 ring-orange-400" : "opacity-40" %>">
                        <i class="ri-fire-line ri-lg"></i>
                        <% if (onFireActive) { %><div class="badge-notification">ON</div><% } %>
                    </div>
                    <span class="text-sm font-medium text-gray-700">On Fire</span>
                    <span class="text-xs text-gray-500">2+ quizzes in 1 hour</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-accent to-accent/80 mb-2 <%= geniusActive ? "ring-4 ring-purple-400" : "opacity-40" %>">
                        <i class="ri-brain-line ri-lg"></i>
                    </div>
                    <span class="text-sm font-medium text-gray-700">Genius</span>
                    <span class="text-xs text-gray-500">Score 100% on 10 quizzes</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-primary/80 to-secondary/80 mb-2 <%= championActive ? "ring-4 ring-yellow-400" : "opacity-40" %>">
                        <i class="ri-medal-line ri-lg"></i>
                    </div>
                    <span class="text-sm font-medium text-gray-700">Champion</span>
                    <span class="text-xs text-gray-500">Reach #1 on leaderboard</span>
                </div>
            </div>
        </div>
        <!-- Leaderboard Section -->
        <div class="bg-white rounded-lg shadow-sm p-6 mb-12">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-xl font-bold text-gray-900 flex items-center">
                    <div class="w-6 h-6 flex items-center justify-center text-primary mr-2">
                        <i class="ri-trophy-line"></i>
                    </div>
                    Top Performers
                </h2>
            </div>
            <div class="overflow-hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <%-- Top 3 Players --%>
                    <% 
                        List leaderboard = (List) request.getAttribute("leaderboard");
                        Integer currentUserId = (Integer) session.getAttribute("userId");
                        int[] colors = {0xFFD700, 0xC0C0C0, 0xCD7F32};
                        for (int i = 0; i < Math.min(3, leaderboard.size()); i++) {
                            Classes.Leaderboard.LeaderboardManager.UserPointsEntry entry = (Classes.Leaderboard.LeaderboardManager.UserPointsEntry) leaderboard.get(i);
                    %>
                    <div class="flex items-center justify-between space-x-4">
                        <div class="flex-1 flex items-center space-x-4">
                            <div class="relative">
                                <div class="w-16 h-16 rounded-full <%= i==0?"bg-gradient-to-br from-[#FFD700] to-[#FFA500]":(i==1?"bg-gradient-to-br from-[#C0C0C0] to-[#A0A0A0]":"bg-gradient-to-br from-[#CD7F32] to-[#B87333]") %> flex items-center justify-center text-white text-xl font-bold"><%= (i+1) %></div>
                                <% if (i == 0) { %>
                                <div class="absolute -bottom-1 -right-1 w-6 h-6 bg-primary rounded-full flex items-center justify-center text-white">
                                    <i class="ri-crown-fill ri-sm"></i>
                                </div>
                                <% } %>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900"><%= entry.username %></h3>
                                <p class="text-sm text-gray-500"><%= entry.points %> points</p>
                            </div>
                        </div>
                        <div class="w-24 h-2 bg-gray-100 rounded-full overflow-hidden">
                            <div class="h-full <%= i==0?"bg-[#FFD700]":(i==1?"bg-[#C0C0C0]":"bg-[#CD7F32]") %> rounded-full" style="width: <%= Math.min(100, entry.points) %>%"></div>
                        </div>
                    </div>
                    <% } %>
                </div>
                <%-- Other Players --%>
                <div class="mt-6 space-y-4">
                    <% for (int i = 3; i < leaderboard.size(); i++) {
                        Classes.Leaderboard.LeaderboardManager.UserPointsEntry entry = (Classes.Leaderboard.LeaderboardManager.UserPointsEntry) leaderboard.get(i);
                    %>
                    <div class="flex items-center justify-between py-3 border-t border-gray-100 <%= (currentUserId != null && entry.userId == currentUserId) ? "bg-primary/10" : "" %>">
                        <div class="flex items-center space-x-4">
                            <div class="w-8 h-8 flex items-center justify-center <%= (currentUserId != null && entry.userId == currentUserId) ? "text-primary" : "text-gray-500" %> font-medium"><%= (i+1) %></div>
                            <div>
                                <h3 class="font-medium text-gray-900"><%= entry.username %></h3>
                                <p class="text-sm text-gray-500"><%= entry.points %> points</p>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <%-- Show 'You' row if user is not in top 10 --%>
                    <% Integer userRank = (Integer) request.getAttribute("userRank");
                       Integer userPoints = (Integer) request.getAttribute("userPoints");
                       boolean inTop = false;
                       if (currentUserId != null) {
                           for (int i = 0; i < leaderboard.size(); i++) {
                               Classes.Leaderboard.LeaderboardManager.UserPointsEntry entry = (Classes.Leaderboard.LeaderboardManager.UserPointsEntry) leaderboard.get(i);
                               if (entry.userId == currentUserId) { inTop = true; break; }
                           }
                       }
                       if (currentUserId != null && !inTop && userRank != null && userPoints != null) {
                    %>
                    <div class="flex items-center justify-between py-3 border-t border-gray-100 bg-primary/10">
                        <div class="flex items-center space-x-4">
                            <div class="w-8 h-8 flex items-center justify-center text-primary font-medium"><%= userRank %></div>
                            <div class="relative">
                                <h3 class="font-medium text-gray-900">You</h3>
                                <p class="text-sm text-gray-500"><%= userPoints %> points</p>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- Footer -->
<footer class="bg-white border-t border-gray-200 mt-12">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <a href="#" class="text-2xl font-['Pacifico'] text-primary">logo</a>
                <p class="mt-2 text-sm text-gray-600">Test your knowledge with fun and educational quizzes on a variety of topics.</p>
                <div class="flex space-x-4 mt-4">
                    <a href="#" class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 hover:bg-gray-200 transition-colors">
                        <i class="ri-facebook-fill text-gray-700"></i>
                    </a>
                    <a href="#" class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 hover:bg-gray-200 transition-colors">
                        <i class="ri-twitter-fill text-gray-700"></i>
                    </a>
                    <a href="#" class="w-8 h-8 flex items-center justify-center rounded-full bg-gray-100 hover:bg-gray-200 transition-colors">
                        <i class="ri-instagram-fill text-gray-700"></i>
                    </a>
                </div>
            </div>
            <div>
                <h3 class="font-semibold text-gray-900 mb-3">Quiz Categories</h3>
                <ul class="space-y-2">
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Science & Technology</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">History & Geography</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Arts & Literature</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Sports & Entertainment</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">General Knowledge</a></li>
                </ul>
            </div>
            <div>
                <h3 class="font-semibold text-gray-900 mb-3">Resources</h3>
                <ul class="space-y-2">
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Help Center</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Create Your Own Quiz</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Quiz Guidelines</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">API Documentation</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Community Forum</a></li>
                </ul>
            </div>
            <div>
                <h3 class="font-semibold text-gray-900 mb-3">Stay Updated</h3>
                <p class="text-sm text-gray-600 mb-3">Subscribe to our newsletter for the latest quizzes and features.</p>
                <div class="flex">
                    <input type="email" placeholder="Your email address" class="quiz-input rounded-r-none">
                    <button class="px-4 py-2 bg-primary text-white font-medium rounded-l-none rounded-button hover:bg-primary/90 transition-colors whitespace-nowrap">Subscribe</button>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-200 mt-8 pt-6 flex flex-col md:flex-row justify-between items-center">
            <p class="text-sm text-gray-600">© 2025 QuizMaster. All rights reserved.</p>
            <div class="flex space-x-4 mt-4 md:mt-0">
                <a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Privacy Policy</a>
                <a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Terms of Service</a>
                <a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Contact Us</a>
            </div>
        </div>
    </div>
</footer>
<!-- Add Friend Modal -->
<div id="addFriendModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
    <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6 relative">
        <button id="closeAddFriendModal" class="absolute top-2 right-2 text-gray-400 hover:text-gray-700 text-2xl">&times;</button>
        <h2 class="text-xl font-bold mb-4 text-center">Add New Friend</h2>
        <div class="flex mb-4">
            <input id="friendSearchInput" type="text" placeholder="Search users..." class="quiz-input flex-1" autocomplete="off">
        </div>
        <div id="friendSearchResults" class="space-y-2 min-h-[40px] text-center text-gray-400">Type to search for users</div>
    </div>
</div>
<!-- Friends Modal -->
<div id="friendsModal" class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50 hidden">
    <div class="bg-white rounded-lg shadow-lg p-8 max-w-md w-full relative">
        <button id="closeFriendsModal" class="absolute top-2 right-2 text-gray-400 hover:text-gray-700 text-2xl">&times;</button>
        <h2 class="text-xl font-bold mb-4 text-center">Your Friends</h2>
        <div id="friendsList" class="space-y-2 text-center text-gray-700">Loading...</div>
    </div>
</div>
<!-- Modal for All Activity -->
<div id="activityModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
    <div class="bg-white rounded-lg shadow-lg w-full max-w-lg max-h-[80vh] overflow-y-auto p-6 relative">
        <button onclick="closeActivityModal()" class="absolute top-3 right-3 text-gray-400 hover:text-primary text-2xl">&times;</button>
        <h2 class="text-xl font-bold text-gray-900 mb-4 flex items-center">
            <div class="w-6 h-6 flex items-center justify-center text-primary mr-2">
                <i class="ri-time-line"></i>
            </div>
            Full Activity History
        </h2>
        <div class="space-y-4">
            <% java.util.List allAttempts = (java.util.List) request.getAttribute("allAttempts"); %>
            <% java.util.List quizzesAll = (java.util.List) request.getAttribute("quizzes"); %>
            <% java.util.Map questionCountsAll = (java.util.Map) request.getAttribute("questionCounts"); %>
            <% if (allAttempts != null && !allAttempts.isEmpty()) {
                for (Object obj : allAttempts) {
                    Classes.Quizzes.QuizManager.QuizAttempt attempt = (Classes.Quizzes.QuizManager.QuizAttempt) obj;
                    String quizName = "Quiz #" + attempt.quizId;
                    int difficulty = 1;
                    for (Object qObj : quizzesAll) {
                        Classes.Quizzes.QuizManager.Quiz quiz = (Classes.Quizzes.QuizManager.Quiz) qObj;
                        if (quiz.id == attempt.quizId) { quizName = quiz.name; difficulty = quiz.difficulty; break; }
                    }
                    int percent = (int)Math.round(attempt.score);
                    int realPercent = (int)Math.round((attempt.score / (questionCountsAll.get(attempt.quizId) instanceof Integer ? (Integer)questionCountsAll.get(attempt.quizId) : 1)) * 100);
                    java.util.Date now = new java.util.Date();
                    long diffMillis = now.getTime() - attempt.takenAt.getTime();
                    long diffHours = diffMillis / (1000 * 60 * 60);
                    long diffDays = diffHours / 24;
                    String timeAgo;
                    if (diffHours < 24) {
                        timeAgo = diffHours + (diffHours == 1 ? " hour ago" : " hours ago");
                    } else if (diffDays < 7) {
                        timeAgo = diffDays + (diffDays == 1 ? " day ago" : " days ago");
                    } else {
                        long weeks = diffDays / 7;
                        timeAgo = weeks + (weeks == 1 ? " week ago" : " weeks ago");
                    }
                    int xp = percent;
                    if (difficulty == 2) xp = percent * 2;
                    if (difficulty == 3) xp = percent * 3;
                    String xpClass = difficulty == 1 ? "text-primary" : (difficulty == 2 ? "text-secondary" : "text-accent");
                    String bgClass = difficulty == 1 ? "bg-primary/10 text-primary" : (difficulty == 2 ? "bg-secondary/10 text-secondary" : "bg-accent/10 text-accent");
            %>
            <div class="flex items-center">
                <div class="w-10 h-10 rounded-full <%= bgClass %> flex items-center justify-center mr-3">
                    <i class="ri-trophy-line"></i>
                </div>
                <div class="flex-grow">
                    <p class="text-sm font-medium text-gray-900">Completed <%= quizName %></p>
                    <p class="text-xs text-gray-500">Score: <%= realPercent %>% • <%= timeAgo %></p>
                </div>
                <div class="text-sm font-medium <%= xpClass %>">+<%= xp %> Pts</div>
            </div>
            <%   }
               } else { %>
            <div class="text-gray-400 text-sm">No activity history.</div>
            <% } %>
        </div>
    </div>
</div>
<!-- Scripts -->
<script src="Scripts/Home.js"></script>
<script>
function openActivityModal() {
    document.getElementById('activityModal').classList.remove('hidden');
}
function closeActivityModal() {
    document.getElementById('activityModal').classList.add('hidden');
}
</script>
</body>
</html>