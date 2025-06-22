<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 6/22/2025
  Time: 3:33 AM
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

    <!-- External CSS and Font/Icon CDNs -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/Register.css">
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
            <img src="./images/Logo1.png" alt="Logo" style="width: 110px">
            <p class="text-2xl font-medium mb-4">Join Quiz Master</p>
            <p class="text-lg text-center text-white/80 max-w-md">Create your account to start your journey of knowledge exploration and challenge yourself with exciting quizzes.</p>
            <div class="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-black/20 to-transparent"></div>
        </div>
    </div>

    <!-- Right Form Panel -->
    <div class="w-full lg:w-1/2 flex items-center justify-center p-8 lg:p-12">
        <div class="w-full max-w-md">
            <div class="w-full">
                <div class="relative z-10">
                    <div class="text-center mb-8">
                        <img src="./images/Logo.png" alt="Logo" style="width: 110px; display: initial">
                        <p class="text-[#121d92] font-medium">Create Your Account</p>
                    </div>
                    
                    <form action="register" method="post"> <%-- Point this to your future registration servlet --%>
                        <div class="space-y-5">
                            
                            <!-- Username input -->
                            <div>
                                <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-user-line"></i></div>
                                    <input type="text" id="username" name="username" class="input-field w-full pl-10 pr-4 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Choose a username" required>
                                </div>
                            </div>
                            
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-mail-line"></i></div>
                                    <input type="email" id="email" name="email" class="input-field w-full pl-10 pr-4 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Enter your email" required>
                                </div>
                            </div>

                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-lock-line"></i></div>
                                    <input type="password" id="password" name="password" class="input-field w-full pl-10 pr-10 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Create a password" required>
                                    <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-eye-line"></i></button>
                                </div>
                                <p class="mt-1 text-xs text-gray-500">Must be at least 8 characters long</p>
                            </div>

                            <div>
                                <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-lock-line"></i></div>
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="input-field w-full pl-10 pr-10 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Confirm your password" required>
                                    <button type="button" id="toggleConfirmPassword" class="absolute inset-y-0 right-0 w-10 h-full flex items-center justify-center text-gray-400"><i class="ri-eye-line"></i></button>
                                </div>
                            </div>

                            <div class="flex items-center">
                                <div class="relative flex items-center">
                                    <input type="checkbox" id="terms" name="terms" class="sr-only" required>
                                    <div class="w-5 h-5 border border-gray-300 rounded flex items-center justify-center cursor-pointer" id="customCheckbox"><div class="w-3 h-3 bg-primary rounded hidden" id="checkboxIndicator"></div></div>
                                    <label for="terms" class="ml-2 text-sm text-gray-600 cursor-pointer">I agree to the <a href="#" class="text-primary hover:text-primary/80">Terms</a> and <a href="#" class="text-primary hover:text-primary/80">Privacy Policy</a></label>
                                </div>
                            </div>

                            <button type="submit" class="login-button w-full py-3 text-white font-medium rounded-button whitespace-nowrap !rounded-button">Create Account</button>
                            
                            <div class="relative flex items-center justify-center my-4">
                                <div class="border-t border-gray-200 w-full"></div>
                                <div class="absolute bg-white px-4 text-sm text-gray-500">OR</div>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/LogIn.jsp" class="signup-button w-full py-3 text-[#5b0c8b] font-medium rounded-button whitespace-nowrap !rounded-button flex items-center justify-center" style="text-decoration: none;">Already have an account? Log In</a>
                        </div>
                    </form>
                    
                    <div class="mt-8 text-center text-xs text-gray-500">
                        <p>By continuing, you agree to our <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a></p>
                        <p class="mt-2 text-[#121d92]">© 2025 Quiz Master. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/Scripts/Register.js"></script>
</body>
</html>
