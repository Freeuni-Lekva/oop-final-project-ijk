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
            <img href="/home.jsp" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
            <nav class="hidden md:flex space-x-6">
                <a href="./Home.jsp" class="text-primary font-medium">Home</a>
                <a href="./Quizzes.jsp" class="text-gray-600 hover:text-primary transition-colors">Quizzes</a>
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
                    <option>Sports</option>
                    <option>Entertainment</option>
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
            Popular Categories
        </h2>
        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-primary to-primary/80 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-flask-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Science</h3>
                <p class="text-xs text-gray-500 mt-1">324 quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-secondary to-secondary/80 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-ancient-gate-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">History</h3>
                <p class="text-xs text-gray-500 mt-1">287 quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-accent to-accent/80 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-earth-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Geography</h3>
                <p class="text-xs text-gray-500 mt-1">195 quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-green-500 to-green-600 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-book-open-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Literature</h3>
                <p class="text-xs text-gray-500 mt-1">156 quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-orange-500 to-orange-600 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-calculator-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Mathematics</h3>
                <p class="text-xs text-gray-500 mt-1">142 quizzes</p>
            </div>
            <div
                    class="category-card bg-white rounded-lg p-4 text-center shadow-sm"
            >
                <div
                        class="w-12 h-12 mx-auto mb-3 bg-gradient-to-br from-purple-500 to-purple-600 rounded-lg flex items-center justify-center text-white"
                >
                    <i class="ri-basketball-line ri-lg"></i>
                </div>
                <h3 class="font-semibold text-gray-900 text-sm">Sports</h3>
                <p class="text-xs text-gray-500 mt-1">98 quizzes</p>
            </div>
        </div>
    </div>

    <!-- Main Quiz Grid -->
    <div class="flex flex-col lg:flex-row gap-8">
        <!-- Quiz List -->
        <div class="flex-grow">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-bold text-gray-900">All Quizzes</h2>
                <p class="text-gray-600">Showing 1,247 results</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                <!-- Quiz Card 1 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-medium">Medium</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-line ri-sm"></i>
                            </div>
                            <span>4.2</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        World Capitals Challenge
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Test your knowledge of world capitals with this comprehensive
                        geography quiz covering all continents.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>15 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>25 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>1,234 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>

                <!-- Quiz Card 2 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-hard">Hard</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                            </div>
                            <span>4.8</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        Advanced Physics Concepts
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Dive deep into quantum mechanics, relativity, and advanced
                        physics principles in this challenging quiz.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>30 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>40 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>567 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>

                <!-- Quiz Card 3 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-easy">Easy</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-line ri-sm"></i>
                            </div>
                            <span>4.1</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        Movie Trivia Fun
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Test your knowledge of popular movies, actors, and film history
                        with this entertaining quiz.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>10 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>20 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>2,891 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>

                <!-- Quiz Card 4 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-medium">Medium</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-line ri-sm"></i>
                            </div>
                            <span>4.3</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        Ancient Civilizations
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Explore the fascinating world of ancient civilizations from
                        Egypt to Rome and beyond.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>20 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>30 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>876 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>

                <!-- Quiz Card 5 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-easy">Easy</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                            </div>
                            <span>4.7</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        Basic Math Skills
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Refresh your fundamental math skills with this comprehensive
                        basic mathematics quiz.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>12 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>15 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>3,456 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>

                <!-- Quiz Card 6 -->
                <div class="quiz-card bg-white rounded-lg p-6 shadow-sm">
                    <div class="flex justify-between items-start mb-4">
                        <div class="difficulty-badge difficulty-hard">Hard</div>
                        <div class="flex items-center text-sm text-gray-500">
                            <div class="rating-stars flex mr-1">
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-fill ri-sm"></i>
                                <i class="ri-star-line ri-sm"></i>
                            </div>
                            <span>4.4</span>
                        </div>
                    </div>
                    <h3 class="text-lg font-semibold text-gray-900 mb-2">
                        Shakespeare Masterpieces
                    </h3>
                    <p class="text-gray-600 text-sm mb-4">
                        Challenge your knowledge of William Shakespeare's greatest works
                        and literary contributions.
                    </p>
                    <div
                            class="flex items-center justify-between text-sm text-gray-500 mb-4"
                    >
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-time-line"></i>
                            </div>
                            <span>25 min</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-question-line"></i>
                            </div>
                            <span>35 questions</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 flex items-center justify-center mr-1">
                                <i class="ri-user-line"></i>
                            </div>
                            <span>432 taken</span>
                        </div>
                    </div>
                    <button
                            class="w-full bg-primary text-white py-2 px-4 rounded-button font-medium hover:bg-primary/90 transition-colors whitespace-nowrap"
                    >
                        Start Quiz
                    </button>
                </div>
            </div>

            <!-- Pagination -->
            <div class="flex justify-center items-center space-x-2 mt-8">
                <button
                        class="px-3 py-2 border border-gray-300 rounded-button text-gray-600 hover:bg-gray-50 transition-colors"
                >
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-arrow-left-line"></i>
                    </div>
                </button>
                <button
                        class="px-3 py-2 bg-primary text-white rounded-button font-medium"
                >
                    1
                </button>
                <button
                        class="px-3 py-2 border border-gray-300 rounded-button text-gray-600 hover:bg-gray-50 transition-colors"
                >
                    2
                </button>
                <button
                        class="px-3 py-2 border border-gray-300 rounded-button text-gray-600 hover:bg-gray-50 transition-colors"
                >
                    3
                </button>
                <span class="px-3 py-2 text-gray-500">...</span>
                <button
                        class="px-3 py-2 border border-gray-300 rounded-button text-gray-600 hover:bg-gray-50 transition-colors"
                >
                    42
                </button>
                <button
                        class="px-3 py-2 border border-gray-300 rounded-button text-gray-600 hover:bg-gray-50 transition-colors"
                >
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-arrow-right-line"></i>
                    </div>
                </button>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="lg:w-80 space-y-6">
            <!-- Recently Attempted -->
            <div class="bg-white rounded-lg shadow-sm p-6">
                <h3
                        class="text-lg font-semibold text-gray-900 mb-4 flex items-center"
                >
                    <div
                            class="w-5 h-5 flex items-center justify-center text-primary mr-2"
                    >
                        <i class="ri-history-line"></i>
                    </div>
                    Recently Attempted
                </h3>
                <div class="space-y-3">
                    <div class="flex items-center space-x-3">
                        <div
                                class="w-10 h-10 bg-primary/10 rounded-lg flex items-center justify-center text-primary"
                        >
                            <i class="ri-flask-line"></i>
                        </div>
                        <div class="flex-grow">
                            <h4 class="font-medium text-gray-900 text-sm">
                                Chemistry Basics
                            </h4>
                            <p class="text-xs text-gray-500">Score: 85% • 2 days ago</p>
                        </div>
                    </div>
                    <div class="flex items-center space-x-3">
                        <div
                                class="w-10 h-10 bg-secondary/10 rounded-lg flex items-center justify-center text-secondary"
                        >
                            <i class="ri-ancient-gate-line"></i>
                        </div>
                        <div class="flex-grow">
                            <h4 class="font-medium text-gray-900 text-sm">
                                World War II
                            </h4>
                            <p class="text-xs text-gray-500">Score: 92% • 1 week ago</p>
                        </div>
                    </div>
                    <div class="flex items-center space-x-3">
                        <div
                                class="w-10 h-10 bg-accent/10 rounded-lg flex items-center justify-center text-accent"
                        >
                            <i class="ri-earth-line"></i>
                        </div>
                        <div class="flex-grow">
                            <h4 class="font-medium text-gray-900 text-sm">
                                European Countries
                            </h4>
                            <p class="text-xs text-gray-500">Score: 78% • 1 week ago</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recommended Quizzes -->
            <div class="bg-white rounded-lg shadow-sm p-6">
                <h3
                        class="text-lg font-semibold text-gray-900 mb-4 flex items-center"
                >
                    <div
                            class="w-5 h-5 flex items-center justify-center text-primary mr-2"
                    >
                        <i class="ri-thumb-up-line"></i>
                    </div>
                    Recommended for You
                </h3>
                <div class="space-y-4">
                    <div class="border border-gray-100 rounded-lg p-3">
                        <h4 class="font-medium text-gray-900 text-sm mb-1">
                            Ocean Life Discovery
                        </h4>
                        <p class="text-xs text-gray-500 mb-2">
                            Based on your science quiz performance
                        </p>
                        <div
                                class="flex items-center justify-between text-xs text-gray-500"
                        >
                            <span>Medium • 18 min</span>
                            <div class="difficulty-badge difficulty-medium">Medium</div>
                        </div>
                    </div>
                    <div class="border border-gray-100 rounded-lg p-3">
                        <h4 class="font-medium text-gray-900 text-sm mb-1">
                            Renaissance Art
                        </h4>
                        <p class="text-xs text-gray-500 mb-2">
                            Popular in History category
                        </p>
                        <div
                                class="flex items-center justify-between text-xs text-gray-500"
                        >
                            <span>Hard • 22 min</span>
                            <div class="difficulty-badge difficulty-hard">Hard</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Popular This Week -->
            <div class="bg-white rounded-lg shadow-sm p-6">
                <h3
                        class="text-lg font-semibold text-gray-900 mb-4 flex items-center"
                >
                    <div
                            class="w-5 h-5 flex items-center justify-center text-primary mr-2"
                    >
                        <i class="ri-fire-line"></i>
                    </div>
                    Popular This Week
                </h3>
                <div class="space-y-3">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-primary">1</span>
                            <span class="text-sm text-gray-900"
                            >World Capitals Challenge</span
                            >
                        </div>
                        <span class="text-xs text-gray-500">1.2k plays</span>
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-primary">2</span>
                            <span class="text-sm text-gray-900">Movie Trivia Fun</span>
                        </div>
                        <span class="text-xs text-gray-500">987 plays</span>
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-primary">3</span>
                            <span class="text-sm text-gray-900">Basic Math Skills</span>
                        </div>
                        <span class="text-xs text-gray-500">856 plays</span>
                    </div>
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                            <span class="text-sm font-medium text-primary">4</span>
                            <span class="text-sm text-gray-900"
                            >Ancient Civilizations</span
                            >
                        </div>
                        <span class="text-xs text-gray-500">743 plays</span>
                    </div>
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
<!-- Scripts -->
<script src="${pageContext.request.contextPath}/Scripts/Home.js"></script>
<script src="${pageContext.request.contextPath}/Scripts/Quizzes.js"></script>
</body>
</html>
