<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 7/10/2025
  Time: 2:28 AM
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Home.css?v=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Quizzes.css?v=1">
</head>
<body>
<!-- Header -->
<header class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-4 flex items-center justify-between">
        <div class="flex items-center">
            <img href="home" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
            <nav class="hidden md:flex space-x-6">
                <a href="home" class="text-gray-600 hover:text-primary transition-colors">Home</a>
                <a href="quizzes" class="text-primary font-medium">Quizzes</a>
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
<!-- Breadcrumb -->
<div class="bg-white border-b border-gray-200">
    <div class="container mx-auto px-4 py-3">
        <nav class="flex items-center space-x-2 text-sm">
            <a
                    href="./Home.jsp"
                    data-readdy="true"
                    class="text-gray-600 hover:text-primary transition-colors"
            >Home</a
            >
            <div class="w-4 h-4 flex items-center justify-center text-gray-400">
                <i class="ri-arrow-right-s-line"></i>
            </div>
            <span class="text-gray-900 font-medium">Quizzes</span>
        </nav>
    </div>
</div>

<!-- Main Content -->
<main class="container mx-auto px-4 py-8">
    <!-- Page Header -->
    <div class="text-center mb-8">
        <h1 class="text-4xl font-bold text-gray-900 mb-4">Explore Quizzes</h1>
        <p class="text-lg text-gray-600 max-w-2xl mx-auto">
            Discover thousands of engaging quizzes across various topics and
            difficulty levels. Challenge yourself and expand your knowledge!
        </p>
    </div>

    <!-- Search and Filter Bar -->
    <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
        <div class="flex flex-col lg:flex-row gap-4 items-center">
            <div class="relative flex-grow max-w-md">
                <div
                        class="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 flex items-center justify-center text-gray-400"
                >
                    <i class="ri-search-line"></i>
                </div>
                <input
                        type="text"
                        placeholder="Search quizzes..."
                        class="search-input text-sm"
                />
            </div>
            <div class="flex flex-wrap gap-3 items-center">
                <select class="filter-select text-sm pr-8">
                    <option>All Categories</option>
                    <option>Science</option>
                    <option>History</option>
                    <option>Geography</option>
                    <option>Literature</option>
                    <option>Mathematics</option>
                </select>
                <select class="filter-select text-sm pr-8">
                    <option>All Difficulties</option>
                    <option>Easy</option>
                    <option>Medium</option>
                    <option>Hard</option>
                </select>
                <select class="filter-select text-sm pr-8">
                    <option>Any Duration</option>
                    <option>0-15 minutes</option>
                    <option>15-30 minutes</option>
                    <option>30+ minutes</option>
                </select>
                <select class="filter-select text-sm pr-8">
                    <option>Sort by Newest</option>
                    <option>Most Popular</option>
                    <option>Highest Rated</option>
                    <option>Shortest Duration</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Quiz Categories Section -->
    <div class="mb-12">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">
            Categories
        </h2>
        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-primary to-primary/80 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-timer-line ri-xl"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Speed Challenge</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Speed Challenge") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Speed Challenge") : 0) %> quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-secondary to-secondary/80 rounded-lg flex items-center justify-center text-white"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-shuffle" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M0 3.5A.5.5 0 0 1 .5 3H1c2.202 0 3.827 1.24 4.874 2.418.49.552.865 1.102 1.126 1.532.26-.43.636-.98 1.126-1.532C9.173 4.24 10.798 3 13 3v1c-1.798 0-3.173 1.01-4.126 2.082A9.6 9.6 0 0 0 7.556 8a9.6 9.6 0 0 0 1.317 1.918C9.828 10.99 11.204 12 13 12v1c-2.202 0-3.827-1.24-4.874-2.418A10.6 10.6 0 0 1 7 9.05c-.26.43-.636.98-1.126 1.532C4.827 11.76 3.202 13 1 13H.5a.5.5 0 0 1 0-1H1c1.798 0 3.173-1.01 4.126-2.082A9.6 9.6 0 0 0 6.444 8a9.6 9.6 0 0 0-1.317-1.918C4.172 5.01 2.796 4 1 4H.5a.5.5 0 0 1-.5-.5"/>
                        <path d="M13 5.466V1.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192m0 9v-3.932a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384l-2.36 1.966a.25.25 0 0 1-.41-.192"/>
                    </svg>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Random Quiz</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Random Quiz") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Random Quiz") : 0) %> quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-accent to-accent/80 rounded-lg flex items-center justify-center text-white"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-hdd-network" viewBox="0 0 16 16">
                        <path d="M4.5 5a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1M3 4.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0"/>
                        <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v1a2 2 0 0 1-2 2H8.5v3a1.5 1.5 0 0 1 1.5 1.5h5.5a.5.5 0 0 1 0 1H10A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5H.5a.5.5 0 0 1 0-1H6A1.5 1.5 0 0 1 7.5 10V7H2a2 2 0 0 1-2-2zm1 0v1a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1m6 7.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5"/>
                    </svg>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Fill in the Blank</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Fill in the Blank") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Fill in the Blank") : 0) %> quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center text-white"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-list-ul" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5m-3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2m0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2m0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
                    </svg>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Multiple Choice</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Multiple Choice") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Multiple Choice") : 0) %> quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-orange-500 to-orange-600 rounded-lg flex items-center justify-center text-white"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-question-square" viewBox="0 0 16 16">
                        <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
                        <path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286m1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94"/>
                    </svg>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Question-Response</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Question-Response") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Question-Response") : 0) %> quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center text-white"
                >
                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-image" viewBox="0 0 16 16">
                        <path d="M6.002 5.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0"/>
                        <path d="M2.002 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v6.5l-3.777-1.947a.5.5 0 0 0-.577.093l-3.71 3.71-2.66-1.772a.5.5 0 0 0-.63.062L1.002 12V3a1 1 0 0 1 1-1z"/>
                    </svg>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Picture-Response</h3>
                <p class="text-xs text-gray-500 mt-1"><%= ((request.getAttribute("categoryCounts") != null && ((java.util.Map)request.getAttribute("categoryCounts")).get("Picture-Response") != null) ? ((java.util.Map)request.getAttribute("categoryCounts")).get("Picture-Response") : 0) %> quizzes</p>
            </div>
        </div>
    </div>

    <!-- Main Quiz Grid -->
    <div class="flex flex-col lg:flex-row gap-8">
        <!-- Quiz List -->
        <div class="flex-grow">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-900">All Quizzes</h2>
                <%
                    int quizCount = 0;
                    if (request.getAttribute("quizzes") != null) {
                        java.util.List quizzes = (java.util.List) request.getAttribute("quizzes");
                        quizCount = quizzes.size();
                    }
                %>
                <p class="text-gray-600">Showing <%= quizCount %> results</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
<% if (request.getAttribute("quizzes") != null) {
   java.util.List quizzes = (java.util.List) request.getAttribute("quizzes");
   for (Object obj : quizzes) {
      Classes.Quizzes.QuizManager.Quiz quiz = (Classes.Quizzes.QuizManager.Quiz) obj;
      String difficultyClass = "difficulty-medium";
      String difficultyLabel = "Medium";
      if (quiz.difficulty == 1) { difficultyClass = "difficulty-easy"; difficultyLabel = "Easy"; }
      else if (quiz.difficulty == 2) { difficultyClass = "difficulty-medium"; difficultyLabel = "Medium"; }
      else if (quiz.difficulty == 3) { difficultyClass = "difficulty-hard"; difficultyLabel = "Hard"; }
%>
    <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
        <div class="flex justify-between items-start mb-4">
            <div class="difficulty-badge <%= difficultyClass %>"><%= difficultyLabel %></div>
        </div>
        <h3 class="text-lg font-semibold text-gray-900 mb-2">
            <%= quiz.name %>
        </h3>
        <p class="text-gray-600 text-sm mb-4">
            <%= quiz.description %>
        </p>
        <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
            <div class="flex items-center">
                <div class="w-4 h-4 flex items-center justify-center mr-1">
                    <i class="ri-time-line"></i>
                </div>
                <span><%= quiz.duration %> min</span>
            </div>
            <div class="flex items-center">
                <div class="w-4 h-4 flex items-center justify-center mr-1">
                    <i class="ri-question-line"></i>
                </div>
                <span><%= (request.getAttribute("questionCounts") != null && ((java.util.Map)request.getAttribute("questionCounts")).get(quiz.id) != null) ? ((java.util.Map)request.getAttribute("questionCounts")).get(quiz.id) : 0 %> questions</span>
            </div>
            <div class="flex items-center">
                <div class="w-4 h-4 flex items-center justify-center mr-1">
                    <i class="ri-book-2-line"></i>
                </div>
                <span><%= quiz.category %></span>
            </div>
        </div>
        <button class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap">
            <a href="quiz-landing?id=<%= quiz.id %>">Start Quiz</a>
        </button>
    </div>
<%   }
} %>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="lg:w-80 space-y-6">
            <%-- Recently Attempted Box --%>
            <% java.util.List recentAttempts = (java.util.List) request.getAttribute("recentAttempts"); %>
            <% if (recentAttempts != null && !recentAttempts.isEmpty()) { %>
            <div class="bg-white rounded-2xl shadow p-6 mb-8 w-full max-w-xs mx-auto flex flex-col items-start" style="max-width:200px;">
                <div class="flex items-center mb-4">
                    <span class="inline-block text-xl text-blue-500 mr-2"><i class="ri-history-line"></i></span>
                    <span class="font-bold text-lg text-gray-900">Recently Attempted</span>
                </div>
                <ul class="w-full">
                    <% for (Object obj : recentAttempts) {
                        Classes.Quizzes.QuizManager.QuizAttempt attempt = (Classes.Quizzes.QuizManager.QuizAttempt) obj;
                        String quizName = "Quiz #" + attempt.quizId;
                        java.util.List quizzes = (java.util.List) request.getAttribute("quizzes");
                        for (Object qObj : quizzes) {
                            Classes.Quizzes.QuizManager.Quiz quiz = (Classes.Quizzes.QuizManager.Quiz) qObj;
                            if (quiz.id == attempt.quizId) { quizName = quiz.name; break; }
                        }
                        int percent = 0;
                        if (attempt.score > 0 && request.getAttribute("questionCounts") != null && ((java.util.Map)request.getAttribute("questionCounts")).get(attempt.quizId) != null) {
                            int total = ((java.util.Map)request.getAttribute("questionCounts")).get(attempt.quizId) instanceof Integer ? (Integer)((java.util.Map)request.getAttribute("questionCounts")).get(attempt.quizId) : 0;
                            if (total > 0) percent = (int)Math.round((attempt.score / total) * 100);
                        }
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
                    %>
                    <li class="flex items-center mb-4 last:mb-0 w-full">
                        <div class="flex-shrink-0 w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center mr-3">
                            <!-- Icon placeholder -->
                        </div>
                        <div class="flex-1">
                            <div class="font-semibold text-gray-900 leading-tight"><%= quizName %></div>
                            <div class="text-sm text-gray-500">Score: <span class="font-medium text-blue-700"><%= percent %>%</span> &bull; <%= timeAgo %></div>
                        </div>
                    </li>
                    <% } %>
                </ul>
            </div>
            <% } %>


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
<!-- Scripts -->
<script src="${pageContext.request.contextPath}/Scripts/Home.js"></script>
<script src="${pageContext.request.contextPath}/Scripts/Quizzes.js"></script>
</body>
</html>
