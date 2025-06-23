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
            <img href="/home.jsp" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
            <nav class="hidden md:flex space-x-6">
                <a href="#" class="text-primary font-medium">Home</a>
                <a href="#" class="text-gray-600 hover:text-primary transition-colors">Quizzes</a>
                <a href="#" class="text-gray-600 hover:text-primary transition-colors">Leaderboard</a>
                <a href="#" class="text-gray-600 hover:text-primary transition-colors">Achievements</a>
            </nav>
        </div>
        <div class="flex items-center space-x-4">
            <div class="relative">
                <button id="categoryDropdown" class="flex items-center text-gray-700 hover:text-primary transition-colors">
                    <span>Categories</span>
                    <div class="w-5 h-5 flex items-center justify-center ml-1">
                        <i class="ri-arrow-down-s-line"></i>
                    </div>
                </button>
                <div id="categoryMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Science</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">History</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Geography</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Literature</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Mathematics</a>
                </div>
            </div>
            <div class="h-6 w-px bg-gray-200"></div>
            <div class="relative">
                <button id="userDropdown" class="flex items-center space-x-2">
                    <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                        <i class="ri-user-line"></i>
                    </div>
                    <span class="hidden md:inline text-sm font-medium text-gray-700">
                        <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %>
                    </span>
                    <div class="w-5 h-5 flex items-center justify-center">
                        <i class="ri-arrow-down-s-line text-gray-400"></i>
                    </div>
                </button>
                <div id="userMenu" class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden">
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Profile</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">My Quizzes</a>
                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Settings</a>
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
                    <i class="ri-lightbulb-line ri-xl"></i>
                </div>
                <h3 class="text-xl font-semibold mb-2">Knowledge Quiz</h3>
                <p class="text-white/80 mb-4">Test your general knowledge across various topics</p>
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
                    <button class="text-sm text-primary hover:text-primary/80 transition-colors">This Week</button>
                </div>
                <div class="space-y-4">
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Daily Goals</span>
                            <span class="text-sm text-gray-500">8/10 completed</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 80%"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Quiz Accuracy</span>
                            <span class="text-sm text-gray-500">85%</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 85%"></div>
                        </div>
                    </div>
                    <div>
                        <div class="flex justify-between items-center mb-2">
                            <span class="text-sm font-medium text-gray-700">Weekly Challenge</span>
                            <span class="text-sm text-gray-500">4/7 days</span>
                        </div>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 57%"></div>
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
                    <button class="text-sm text-primary hover:text-primary/80 transition-colors">View All</button>
                </div>
                <div class="space-y-4">
                    <div class="flex items-center">
                        <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary mr-3">
                            <i class="ri-trophy-line"></i>
                        </div>
                        <div class="flex-grow">
                            <p class="text-sm font-medium text-gray-900">Completed Science Quiz</p>
                            <p class="text-xs text-gray-500">Score: 95% • 2 hours ago</p>
                        </div>
                        <div class="text-sm font-medium text-primary">+150 XP</div>
                    </div>
                    <div class="flex items-center">
                        <div class="w-10 h-10 rounded-full bg-secondary/10 flex items-center justify-center text-secondary mr-3">
                            <i class="ri-medal-line"></i>
                        </div>
                        <div class="flex-grow">
                            <p class="text-sm font-medium text-gray-900">New Achievement Unlocked</p>
                            <p class="text-xs text-gray-500">Speed Demon • 5 hours ago</p>
                        </div>
                        <div class="text-sm font-medium text-secondary">+200 XP</div>
                    </div>
                    <div class="flex items-center">
                        <div class="w-10 h-10 rounded-full bg-accent/10 flex items-center justify-center text-accent mr-3">
                            <i class="ri-flag-line"></i>
                        </div>
                        <div class="flex-grow">
                            <p class="text-sm font-medium text-gray-900">Daily Challenge Completed</p>
                            <p class="text-xs text-gray-500">Perfect Score • Yesterday</p>
                        </div>
                        <div class="text-sm font-medium text-accent">+100 XP</div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Achievements Section -->
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
                    <div class="achievement-badge bg-gradient-to-br from-primary to-primary/80 mb-2">
                        <i class="ri-rocket-line ri-lg"></i>
                    </div>
                    <span class="text-sm font-medium text-gray-700">Fast Learner</span>
                    <span class="text-xs text-gray-500">Complete 5 quizzes</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-secondary to-secondary/80 mb-2">
                        <i class="ri-fire-line ri-lg"></i>
                        <div class="badge-notification">1</div>
                    </div>
                    <span class="text-sm font-medium text-gray-700">On Fire</span>
                    <span class="text-xs text-gray-500">3-day streak</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-accent to-accent/80 mb-2">
                        <i class="ri-brain-line ri-lg"></i>
                    </div>
                    <span class="text-sm font-medium text-gray-700">Genius</span>
                    <span class="text-xs text-gray-500">Score 100% on 10 quizzes</span>
                </div>
                <div class="flex flex-col items-center">
                    <div class="achievement-badge bg-gradient-to-br from-primary/80 to-secondary/80 mb-2">
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
                <div class="flex space-x-2">
                    <button class="px-3 py-1 text-sm font-medium rounded-full bg-primary text-white">Weekly</button>
                    <button class="px-3 py-1 text-sm font-medium rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200">Monthly</button>
                    <button class="px-3 py-1 text-sm font-medium rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200">All Time</button>
                </div>
            </div>
            <div class="overflow-hidden">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Top 3 Players -->
                    <div class="flex items-center justify-between space-x-4">
                        <div class="flex-1 flex items-center space-x-4">
                            <div class="relative">
                                <div class="w-16 h-16 rounded-full bg-gradient-to-br from-[#FFD700] to-[#FFA500] flex items-center justify-center text-white text-xl font-bold">1</div>
                                <div class="absolute -bottom-1 -right-1 w-6 h-6 bg-primary rounded-full flex items-center justify-center text-white">
                                    <i class="ri-crown-fill ri-sm"></i>
                                </div>
                            </div>
                            <div>
                                <h3 class="font-semibold text-gray-900">Sarah Anderson</h3>
                                <p class="text-sm text-gray-500">98,750 points</p>
                                <div class="flex items-center mt-1">
                                    <div class="text-xs font-medium text-primary">+1,250 this week</div>
                                    <div class="w-4 h-4 flex items-center justify-center text-primary ml-1">
                                        <i class="ri-arrow-up-line ri-sm"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-24 h-2 bg-gray-100 rounded-full overflow-hidden">
                            <div class="h-full bg-[#FFD700] rounded-full" style="width: 98%"></div>
                        </div>
                    </div>
                    <div class="flex items-center justify-between space-x-4">
                        <div class="flex-1 flex items-center space-x-4">
                            <div class="w-16 h-16 rounded-full bg-gradient-to-br from-[#C0C0C0] to-[#A0A0A0] flex items-center justify-center text-white text-xl font-bold">2</div>
                            <div>
                                <h3 class="font-semibold text-gray-900">Michael Chen</h3>
                                <p class="text-sm text-gray-500">95,200 points</p>
                                <div class="flex items-center mt-1">
                                    <div class="text-xs font-medium text-primary">+980 this week</div>
                                    <div class="w-4 h-4 flex items-center justify-center text-primary ml-1">
                                        <i class="ri-arrow-up-line ri-sm"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-24 h-2 bg-gray-100 rounded-full overflow-hidden">
                            <div class="h-full bg-[#C0C0C0] rounded-full" style="width: 95%"></div>
                        </div>
                    </div>
                    <div class="flex items-center justify-between space-x-4">
                        <div class="flex-1 flex items-center space-x-4">
                            <div class="w-16 h-16 rounded-full bg-gradient-to-br from-[#CD7F32] to-[#B87333] flex items-center justify-center text-white text-xl font-bold">3</div>
                            <div>
                                <h3 class="font-semibold text-gray-900">Emma Thompson</h3>
                                <p class="text-sm text-gray-500">92,800 points</p>
                                <div class="flex items-center mt-1">
                                    <div class="text-xs font-medium text-primary">+850 this week</div>
                                    <div class="w-4 h-4 flex items-center justify-center text-primary ml-1">
                                        <i class="ri-arrow-up-line ri-sm"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="w-24 h-2 bg-gray-100 rounded-full overflow-hidden">
                            <div class="h-full bg-[#CD7F32] rounded-full" style="width: 92%"></div>
                        </div>
                    </div>
                </div>
                <!-- Other Players -->
                <div class="mt-6 space-y-4">
                    <div class="flex items-center justify-between py-3 border-t border-gray-100">
                        <div class="flex items-center space-x-4">
                            <div class="w-8 h-8 flex items-center justify-center text-gray-500 font-medium">4</div>
                            <div>
                                <h3 class="font-medium text-gray-900">David Wilson</h3>
                                <p class="text-sm text-gray-500">89,400 points</p>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm text-gray-500">+720 pts</span>
                            <div class="w-16 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                                <div class="h-full bg-gray-300 rounded-full" style="width: 89%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center justify-between py-3 border-t border-gray-100">
                        <div class="flex items-center space-x-4">
                            <div class="w-8 h-8 flex items-center justify-center text-gray-500 font-medium">5</div>
                            <div>
                                <h3 class="font-medium text-gray-900">Sophia Garcia</h3>
                                <p class="text-sm text-gray-500">87,150 points</p>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm text-gray-500">+650 pts</span>
                            <div class="w-16 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                                <div class="h-full bg-gray-300 rounded-full" style="width: 87%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="flex items-center justify-between py-3 border-t border-gray-100">
                        <div class="flex items-center space-x-4">
                            <div class="w-8 h-8 flex items-center justify-center text-primary font-medium">12</div>
                            <div class="relative">
                                <h3 class="font-medium text-gray-900">You</h3>
                                <p class="text-sm text-gray-500">76,300 points</p>
                                <div class="absolute -top-3 -right-3 w-5 h-5 bg-primary/10 rounded-full flex items-center justify-center">
                                    <i class="ri-arrow-up-line text-primary ri-sm"></i>
                                </div>
                            </div>
                        </div>
                        <div class="flex items-center space-x-2">
                            <span class="text-sm text-gray-500">+480 pts</span>
                            <div class="w-16 h-1.5 bg-gray-100 rounded-full overflow-hidden">
                                <div class="h-full bg-primary rounded-full" style="width: 76%"></div>
                            </div>
                        </div>
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
<!-- Scripts -->
<script src="Scripts/Home.js"></script>
</body>
</html>