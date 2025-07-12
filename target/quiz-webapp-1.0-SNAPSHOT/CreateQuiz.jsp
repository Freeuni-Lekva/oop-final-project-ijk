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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/CreateQuiz.css?v=1">
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
        <a href="createquiz" class="text-primary font-medium">Create Quiz</a>
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
      <span class="text-gray-900 font-medium">Create Quiz</span>
    </nav>
  </div>
</div>

<!-- Main Content -->
<main class="container mx-auto px-4 py-8">
  <div class="max-w-4xl mx-auto">
    <!-- Header -->
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-900 mb-2">Create Your Own Quiz</h1>
      <p class="text-gray-600">Share your knowledge by creating engaging quizzes for the community.</p>
    </div>

    <!-- Quiz Creation Form -->
    <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
      <form id="createQuizForm" action="createquiz" method="post">
        <!-- Basic Quiz Information -->
        <div class="mb-8">
          <h2 class="text-xl font-semibold text-gray-900 mb-4">Quiz Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="quizTitle" class="block text-sm font-medium text-gray-700 mb-2">Quiz Title *</label>
              <input type="text" id="quizTitle" name="quizTitle" required 
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                     placeholder="Enter quiz title">
            </div>
            <div>
              <label for="quizCategory" class="block text-sm font-medium text-gray-700 mb-2">Category *</label>
              <select id="quizCategory" name="quizCategory" required 
                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                <option value="">Select a category</option>
                <option value="Science & Technology">Speed Challange</option>
                <option value="History & Geography">Question-Response</option>
                <option value="Arts & Literature">Fill in the Blank</option>
                <option value="Sports & Entertainment">Multiple Choice</option>
                <option value="General Knowledge">Picture-Response</option>
              </select>
            </div>
            <div>
              <label for="quizDifficulty" class="block text-sm font-medium text-gray-700 mb-2">Difficulty Level *</label>
              <select id="quizDifficulty" name="quizDifficulty" required 
                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent">
                <option value="">Select difficulty</option>
                <option value="easy">Easy</option>
                <option value="medium">Medium</option>
                <option value="hard">Hard</option>
              </select>
            </div>
            <div>
              <label for="quizDuration" class="block text-sm font-medium text-gray-700 mb-2">Duration (minutes) *</label>
              <input type="number" id="quizDuration" name="quizDuration" min="1" max="120" required 
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                     placeholder="Enter duration in minutes">
            </div>
            <div>
              <label for="quizDescription" class="block text-sm font-medium text-gray-700 mb-2">Description</label>
              <textarea id="quizDescription" name="quizDescription" rows="3"
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent"
                        placeholder="Describe your quiz (optional)"></textarea>
            </div>
          </div>
          
          <!-- Quiz Settings -->
          <div class="mt-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Quiz Settings</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg border border-gray-200">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Random Questions</label>
                  <p class="text-xs text-gray-500">Shuffle question order for each attempt</p>
                </div>
                <div class="flex items-center">
                  <input type="checkbox" id="randomQuestions" name="randomQuestions" value="on" 
                         class="w-4 h-4 text-primary bg-gray-100 border-gray-300 rounded focus:ring-primary focus:ring-2">
                </div>
              </div>
              
              <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg border border-gray-200">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">One Page Mode</label>
                  <p class="text-xs text-gray-500">Show all questions on a single page</p>
                </div>
                <div class="flex items-center">
                  <input type="checkbox" id="onePageMode" name="onePageMode" value="on" 
                         class="w-4 h-4 text-primary bg-gray-100 border-gray-300 rounded focus:ring-primary focus:ring-2">
                </div>
              </div>
              
              <div class="flex items-center justify-between p-4 bg-gray-50 rounded-lg border border-gray-200">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Immediate Correction</label>
                  <p class="text-xs text-gray-500">Show correct answers immediately after each question</p>
                </div>
                <div class="flex items-center">
                  <input type="checkbox" id="immediateCorrection" name="immediateCorrection" value="on" 
                         class="w-4 h-4 text-primary bg-gray-100 border-gray-300 rounded focus:ring-primary focus:ring-2">
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Questions Section -->
        <div class="mb-8">
          <div class="flex justify-between items-center mb-4">
            <h2 class="text-xl font-semibold text-gray-900">Questions</h2>
            <button type="button" id="addQuestionBtn" 
                    class="px-4 py-2 bg-primary text-white rounded-md hover:bg-primary/90 transition-colors">
              <i class="ri-add-line mr-2"></i>Add Question
            </button>
          </div>
          
          <div id="questionsContainer" class="space-y-6">
            <!-- Questions will be dynamically added here -->
          </div>
        </div>

        <!-- Submit Section -->
        <div class="flex justify-end space-x-4 pt-6 border-t border-gray-200">
          <button type="button" id="previewBtn" 
                  class="px-6 py-2 border border-gray-300 text-gray-700 rounded-md hover:bg-gray-50 transition-colors">
            Preview Quiz
          </button>
          <button type="submit" id="submitBtn" 
                  class="px-6 py-2 bg-primary text-white rounded-md hover:bg-primary/90 transition-colors">
            Create Quiz
          </button>
        </div>
      </form>
    </div>

    <!-- Quiz Creation Guidelines -->
    <div class="mt-8 bg-blue-50 rounded-lg p-6">
      <h3 class="text-lg font-semibold text-blue-900 mb-3">Quiz Creation Guidelines</h3>
      <ul class="space-y-2 text-sm text-blue-800">
        <li class="flex items-start">
          <i class="ri-check-line mr-2 mt-0.5 text-blue-600"></i>
          Keep questions clear and concise
        </li>
        <li class="flex items-start">
          <i class="ri-check-line mr-2 mt-0.5 text-blue-600"></i>
          Provide 2-4 answer choices for multiple choice questions
        </li>
        <li class="flex items-start">
          <i class="ri-check-line mr-2 mt-0.5 text-blue-600"></i>
          Include at least 5 questions per quiz
        </li>
        <li class="flex items-start">
          <i class="ri-check-line mr-2 mt-0.5 text-blue-600"></i>
          Ensure all questions have correct answers
        </li>
        <li class="flex items-start">
          <i class="ri-check-line mr-2 mt-0.5 text-blue-600"></i>
          Use appropriate difficulty levels
        </li>
      </ul>
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
<script src="${pageContext.request.contextPath}/Scripts/CreateQuiz.js"></script>
</body>
</html>