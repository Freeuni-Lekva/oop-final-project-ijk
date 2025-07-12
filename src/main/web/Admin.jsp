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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin.css?v=1">
</head>
<body>
<!-- Header -->
<header class="bg-white shadow-sm">
    <div class="container mx-auto px-4 py-4 flex items-center justify-between">
        <div class="flex items-center">
            <img href="home" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
            <nav class="hidden md:flex space-x-6">
                <a href="home" class="text-gray-600 hover:text-primary transition-colors">Home</a>
                <a href="quizzes" class="text-gray-600 hover:text-primary transition-colors">Quizzes</a>
                <a href="leaderboard" class="text-gray-600 hover:text-primary transition-colors">Leaderboard</a>
                <a href="createquiz" class="text-gray-600 hover:text-primary transition-colors">Create Quiz</a>
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
            <span class="text-gray-900 font-medium">Admin Page</span>
        </nav>
    </div>
</div>

<main class="flex-grow container mx-auto px-4 py-8">
    <div class="max-w-6xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-900 mb-8">Admin Dashboard</h1>
        <div class="admin-stats">
            <div class="admin-stat-box">
                <h3><%= request.getAttribute("userCount") != null ? request.getAttribute("userCount") : 0 %></h3>
                <p>Users</p>
            </div>
            <div class="admin-stat-box">
                <h3><%= request.getAttribute("quizAttemptsCount") != null ? request.getAttribute("quizAttemptsCount") : 0 %></h3>
                <p>Quizzes Taken</p>
            </div>
        </div>
        <div class="admin-section">
            <h2>Remove User Accounts</h2>
            <table class="admin-table">
                <thead>
                <tr><th>ID</th><th>Username</th><th>Email</th><th>Admin</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <% java.util.List users = (java.util.List) request.getAttribute("adminUsers");
                    if (users != null) for (Object obj : users) {
                        Classes.Admin.AdminManager.User user = (Classes.Admin.AdminManager.User) obj; %>
                <tr>
                    <td><%= user.id %></td>
                    <td><%= user.username %></td>
                    <td><%= user.email %></td>
                    <td><%= user.administrator ? "Yes" : "No" %></td>
                    <td>
                        <button class="admin-btn admin-remove-user admin-danger" data-user-id="<%= user.id %>" <%= user.administrator ? "disabled" : "" %>>Remove</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div class="admin-section">
            <h2>Remove Quizzes</h2>
            <table class="admin-table">
                <thead>
                <tr><th>ID</th><th>Name</th><th>Category</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <% java.util.List adminQuizzesList = (java.util.List) request.getAttribute("adminQuizzes");
                    if (adminQuizzesList != null) for (Object obj : adminQuizzesList) {
                        Classes.Admin.AdminManager.Quiz quiz = (Classes.Admin.AdminManager.Quiz) obj; %>
                <tr>
                    <td><%= quiz.id %></td>
                    <td><%= quiz.name %></td>
                    <td><%= quiz.category %></td>
                    <td>
                        <button class="admin-btn admin-remove-quiz admin-danger" data-quiz-id="<%= quiz.id %>">Remove</button>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <div class="admin-section">
            <h2>Promote Users to Admin</h2>
            <table class="admin-table">
                <thead>
                <tr><th>ID</th><th>Username</th><th>Email</th><th>Admin</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <% if (users != null) for (Object obj : users) {
                    Classes.Admin.AdminManager.User user = (Classes.Admin.AdminManager.User) obj;
                    if (!user.administrator) { %>
                <tr>
                    <td><%= user.id %></td>
                    <td><%= user.username %></td>
                    <td><%= user.email %></td>
                    <td>No</td>
                    <td>
                        <button class="admin-btn admin-promote-user" data-user-id="<%= user.id %>">Promote</button>
                    </td>
                </tr>
                <% } } %>
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- Footer -->
<footer class="bg-white border-t border-gray-200 mt-12">
    <div class="container mx-auto px-4 py-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <img href="home" src="./images/Logo1.png" alt="Logo" style="height: 38px; margin-right: 20px">
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
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Multiple Choice</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Question-Response</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Fill in the Blank</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Picture-Response</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Speed Challange</a></li>
                </ul>
            </div>
            <div>
                    <h3 class="font-semibold text-gray-900 mb-3">Authors</h3>
                <ul class="space-y-2">
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Irakli Mirotadze</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Nikoloz Nikuradze</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Giorgi Chkhikvadze</a></li>
                    <li><a href="#" class="text-sm text-gray-600 hover:text-primary transition-colors">Nikoloz Maltsevi</a></li>
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
            <p class="text-sm text-gray-600">© 2025 Quizition. All rights reserved.</p>
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
<script src="${pageContext.request.contextPath}/Scripts/Admin.js"></script>
</body>
</html>
