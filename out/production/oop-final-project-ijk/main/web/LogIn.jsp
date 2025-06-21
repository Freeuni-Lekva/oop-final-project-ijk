<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Master - Login</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css">
    <style>
        :where([class^="ri-"])::before { content: "\f3c2"; }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
        }
        .input-field {
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }
        .input-field:focus {
            border-color: #0483cc;
            box-shadow: 0 0 0 3px rgba(4, 131, 204, 0.1);
        }
        .login-button {
            background: linear-gradient(135deg, #0483cc 0%, #121d92 100%);
            transition: all 0.3s ease;
        }
        .login-button:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(4, 131, 204, 0.2);
        }
        .signup-button {
            border: 1px solid #5b0c8b;
            transition: all 0.3s ease;
        }
        .signup-button:hover {
            background-color: rgba(91, 12, 139, 0.05);
        }
        .quiz-decoration {
            background: linear-gradient(135deg, rgba(4, 131, 204, 0.1) 0%, rgba(91, 12, 139, 0.1) 100%);
        }
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .gradient-border {
            position: relative;
            border-radius: 16px;
            overflow: hidden;
        }
        .gradient-border::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #0483cc, #5b0c8b, #121d92);
            z-index: -1;
            border-radius: 18px;
        }
    </style>
    <script>tailwind.config={theme:{extend:{colors:{primary:'#0483cc',secondary:'#5b0c8b'},borderRadius:{'none':'0px','sm':'4px',DEFAULT:'8px','md':'12px','lg':'16px','xl':'20px','2xl':'24px','3xl':'32px','full':'9999px','button':'8px'}}}}</script>
</head>
<body class="min-h-screen bg-white">
<div class="min-h-screen flex">
    <div class="hidden lg:flex lg:w-1/2 bg-gradient-to-br from-[#0483cc] via-[#5b0c8b] to-[#121d92] relative overflow-hidden">
        <div class="absolute inset-0 bg-white/10 backdrop-blur-sm"></div>
        <div class="relative w-full flex flex-col items-center justify-center text-white p-12">
            <h1 class="font-['Pacifico'] text-6xl mb-6">logo</h1>
            <p class="text-2xl font-medium mb-4">Welcome to Quiz Master</p>
            <p class="text-lg text-center text-white/80 max-w-md">Challenge yourself with our engaging quizzes and test your knowledge across various topics.</p>
            <div class="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-black/20 to-transparent"></div>
        </div>
    </div>
    <div class="w-full lg:w-1/2 flex items-center justify-center p-8 lg:p-12">
        <div class="w-full max-w-md">
            <!-- Decorative elements -->
            <div class="absolute -top-16 -left-16 w-32 h-32 rounded-full quiz-decoration opacity-30 blur-xl"></div>
            <div class="absolute -bottom-16 -right-16 w-32 h-32 rounded-full quiz-decoration opacity-30 blur-xl"></div>
            <!-- Login container -->
            <div class="w-full">
                <div class="relative z-10">
                    <!-- Logo and header -->
                    <div class="text-center mb-8">
                        <h1 class="font-['Pacifico'] text-4xl text-primary mb-2">logo</h1>
                        <p class="text-[#121d92] font-medium">Test Your Knowledge</p>
                    </div>
                    <!-- Login form -->
                    <form>
                        <div class="space-y-5">
                            <!-- Email input -->
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400">
                                        <i class="ri-mail-line"></i>
                                    </div>
                                    <input type="email" id="email" class="input-field w-full pl-10 pr-4 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Enter your email" required>
                                </div>
                            </div>
                            <!-- Password input -->
                            <div>
                                <div class="flex justify-between mb-1">
                                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                                    <a href="#" class="text-sm text-primary hover:text-primary/80 transition-colors">Forgot Password?</a>
                                </div>
                                <div class="relative">
                                    <div class="absolute inset-y-0 left-0 w-10 h-full flex items-center justify-center text-gray-400">
                                        <i class="ri-lock-line"></i>
                                    </div>
                                    <input type="password" id="password" class="input-field w-full pl-10 pr-10 py-3 rounded-button text-gray-800 focus:outline-none" placeholder="Enter your password" required>
                                    <button type="button" id="togglePassword" class="absolute inset-y-0 right-0 w-10 h-full flex items-center justify-center text-gray-400">
                                        <i class="ri-eye-line"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- Remember me checkbox -->
                            <div class="flex items-center">
                                <div class="relative flex items-center">
                                    <input type="checkbox" id="remember" class="sr-only">
                                    <div class="w-5 h-5 border border-gray-300 rounded flex items-center justify-center cursor-pointer" id="customCheckbox">
                                        <div class="w-3 h-3 bg-primary rounded hidden" id="checkboxIndicator"></div>
                                    </div>
                                    <label for="remember" class="ml-2 text-sm text-gray-600 cursor-pointer">Remember me</label>
                                </div>
                            </div>
                            <!-- Login button -->
                            <button type="submit" class="login-button w-full py-3 text-white font-medium rounded-button whitespace-nowrap !rounded-button">
                                Log In
                            </button>
                            <!-- Divider -->
                            <div class="relative flex items-center justify-center my-4">
                                <div class="border-t border-gray-200 w-full"></div>
                                <div class="absolute bg-white px-4 text-sm text-gray-500">OR</div>
                            </div>
                            <!-- Create account button -->
                            <button type="button" class="signup-button w-full py-3 text-[#5b0c8b] font-medium rounded-button whitespace-nowrap !rounded-button">
                                Create New Account
                            </button>
                        </div>
                    </form>
                    <!-- Social login options -->
                    <div class="mt-6">
                        <p class="text-center text-sm text-gray-600 mb-3">Continue with</p>
                        <div class="flex justify-center space-x-4">
                            <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors">
                                <i class="ri-google-fill text-[#EA4335]"></i>
                            </button>
                            <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors">
                                <i class="ri-facebook-fill text-[#1877F2]"></i>
                            </button>
                            <button class="w-10 h-10 flex items-center justify-center rounded-full border border-gray-200 hover:bg-gray-50 transition-colors">
                                <i class="ri-apple-fill"></i>
                            </button>
                        </div>
                    </div>
                    <!-- Footer -->
                    <div class="mt-8 text-center text-xs text-gray-500">
                        <p>By continuing, you agree to our <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a></p>
                        <p class="mt-2 text-[#121d92]">© 2025 Quiz Master. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
        <script id="passwordToggle">
            document.addEventListener('DOMContentLoaded', function() {
                const togglePasswordButton = document.getElementById('togglePassword');
                const passwordInput = document.getElementById('password');
                togglePasswordButton.addEventListener('click', function() {
                    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordInput.setAttribute('type', type);
// Toggle icon
                    const icon = togglePasswordButton.querySelector('i');
                    if (type === 'password') {
                        icon.classList.remove('ri-eye-off-line');
                        icon.classList.add('ri-eye-line');
                    } else {
                        icon.classList.remove('ri-eye-line');
                        icon.classList.add('ri-eye-off-line');
                    }
                });
            });
        </script>
        <script id="customCheckboxHandler">
            document.addEventListener('DOMContentLoaded', function() {
                const checkbox = document.getElementById('remember');
                const customCheckbox = document.getElementById('customCheckbox');
                const indicator = document.getElementById('checkboxIndicator');
                customCheckbox.addEventListener('click', function() {
                    checkbox.checked = !checkbox.checked;
                    updateCheckboxState();
                });
                checkbox.addEventListener('change', updateCheckboxState);
                function updateCheckboxState() {
                    if (checkbox.checked) {
                        indicator.classList.remove('hidden');
                        customCheckbox.classList.add('border-primary');
                        customCheckbox.classList.remove('border-gray-300');
                    } else {
                        indicator.classList.add('hidden');
                        customCheckbox.classList.remove('border-primary');
                        customCheckbox.classList.add('border-gray-300');
                    }
                }
            });
        </script>
</body>
</html>