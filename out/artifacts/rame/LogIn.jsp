<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Master - Classes.Login</title>

    <!-- External CSS and Font/Icon CDNs -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/LogIn.css">
    <script src="https://cdn.tailwindcss.com/3.4.1"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.min.css">

    <!-- Tailwind Config -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#0483cc',
                        secondary: '#5b0c8b'
                    },
                    borderRadius: {
                        'none': '0px', 'sm': '4px', DEFAULT: '8px', 'md': '12px', 'lg': '16px',
                        'xl': '20px', '2xl': '24px', '3xl': '32px', 'full': '9999px', 'button': '8px'
                    }
                }
            }
        }
    </script>
</head>
<body class="min-h-screen bg-white">
<div class="min-h-screen flex">
    <!-- Left Decorative Panel -->
    <div class="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-[#0483cc] via-[#5b0c8b] to-[#121d92] relative overflow-hidden">
        <div class="absolute inset-0 bg-white/10 backdrop-blur-sm"></div>
        <div class="relative w-full flex flex-col items-center justify-center text-white p-12">
            <h1 class="font-['Pacifico'] text-6xl mb-6">logo</h1>
            <p class="text-2xl font-medium mb-4">Welcome to Quiz Master</p>
            <p class="text-lg text-center text-white/80 max-w-md">Challenge yourself with our engaging quizzes and test your knowledge across various topics.</p>
            <div class="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-black/20 to-transparent"></div>
        </div>
    </div>

    <!-- Right Form Panel -->
    <div class="w-full lg:w-1/2 flex items-center justify-center p-8 lg:p-12">
        <div class="w-full max-w-md">
            <div class="relative z-10">
                <div class="text-center mb-8">
                    <h1 class="font-['Pacifico'] text-4xl text-primary mb-2">logo</h1>
                    <p class="text-[#121d92] font-medium">Test Your Knowledge</p>
                </div>

                <%-- Check for different login error parameters and display the correct message --%>
                <% String error = request.getParameter("error");
                   if (error != null) { %>
                    <div style="color: #D8000C; background-color: #FFD2D2; padding: 10px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-weight: 500;">
                        <% if ("user_not_found".equals(error)) { %>
                            That username does not exist. Please try again.
                        <% } else if ("incorrect_password".equals(error)) { %>
                            The password you entered is incorrect.
                        <% } else { %>
                            An error occurred. Please try again later.
                        <% } %>
                    </div>
                <% } %>

                <!-- Classes.Login form -->
                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="space-y-5">
                        <div>
                            <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400">
                                    <i class="ri-user-line"></i>
                                </div>
                                <input type="text" id="username" name="username" class="input-field w-full pl-10 pr-4 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Enter your username" required>
                            </div>
                        </div>

                        <div>
                            <div class="flex justify-between mb-1">
                                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                                <a href="#" class="text-sm text-primary hover:text-primary/80 transition-colors">Forgot Password?</a>
                            </div>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400">
                                    <i class="ri-lock-line"></i>
                                </div>
                                <input type="password" id="password" name="password" class="input-field w-full pl-10 pr-10 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Enter your password" required>
                                <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 w-10 h-full flex items-center justify-center text-gray-400">
                                    <i class="ri-eye-line"></i>
                                </button>
                            </div>
                        </div>

                        <div class="flex items-center">
                            <div class="relative flex items-center">
                                <input type="checkbox" id="remember" name="remember" class="sr-only">
                                <div class="w-5 h-5 border border-gray-300 rounded flex items-center justify-center cursor-pointer" id="customCheckbox">
                                    <div class="w-3 h-3 bg-primary rounded hidden" id="checkboxIndicator"></div>
                                </div>
                                <label for="remember" class="ml-2 text-sm text-gray-600 cursor-pointer">Remember me</label>
                            </div>
                        </div>

                        <button type="submit" class="login-button w-full py-3 text-white font-medium rounded-button whitespace-nowrap !rounded-button">Log In</button>
                        
                        <div class="relative flex items-center justify-center my-4">
                            <div class="border-t border-gray-200 w-full"></div>
                            <div class="absolute bg-white px-4 text-sm text-gray-500">OR</div>
                        </div>

                        <a href="register.jsp" class="signup-button w-full block text-center py-3 text-[#5b0c8b] font-medium rounded-button whitespace-nowrap !rounded-button" style="text-decoration: none;">Create New Account</a>
                    </div>
                </form>

                <div class="mt-6">
                    <p class="text-center text-sm text-gray-600 mb-3">Continue with</p>
                    <div class="flex justify-center space-x-4">
                         <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors"><i class="ri-google-fill text-[#EA4335]"></i></button>
                         <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors"><i class="ri-facebook-fill text-[#1877F2]"></i></button>
                         <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors"><i class="ri-apple-fill"></i></button>
                    </div>
                </div>

                <div class="mt-8 text-center text-xs text-gray-500">
                    <p>By continuing, you agree to our <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a></p>
                    <p class="mt-2 text-[#121d92]">© 2025 Quiz Master. All rights reserved.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/Scripts/LogIn.js"></script>
</body>
</html>