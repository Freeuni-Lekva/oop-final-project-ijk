// Dropdown toggles
// Category and user dropdowns

document.addEventListener('DOMContentLoaded', function() {
    // Category dropdown toggle
    const categoryDropdown = document.getElementById('categoryDropdown');
    const categoryMenu = document.getElementById('categoryMenu');
    categoryDropdown.addEventListener('click', function(e) {
        e.stopPropagation();
        categoryMenu.classList.toggle('hidden');
        userMenu.classList.add('hidden');
    });
    // User dropdown toggle
    const userDropdown = document.getElementById('userDropdown');
    const userMenu = document.getElementById('userMenu');
    userDropdown.addEventListener('click', function(e) {
        e.stopPropagation();
        userMenu.classList.toggle('hidden');
        categoryMenu.classList.add('hidden');
    });
    // Close dropdowns when clicking elsewhere
    document.addEventListener('click', function() {
        categoryMenu.classList.add('hidden');
        userMenu.classList.add('hidden');
    });
});

// Quiz Tabs

document.addEventListener('DOMContentLoaded', function() {
    const tab1 = document.getElementById('tab1');
    const tab2 = document.getElementById('tab2');
    const questionResponse = document.getElementById('question-response');
    const fillBlank = document.getElementById('fill-blank');
    const multipleChoice = document.getElementById('multiple-choice');
    const pictureResponse = document.getElementById('picture-response');
    if (tab1 && tab2) {
        tab1.addEventListener('click', function() {
            tab1.classList.remove('bg-gray-100', 'text-gray-700');
            tab1.classList.add('bg-primary', 'text-white');
            tab2.classList.remove('bg-primary', 'text-white');
            tab2.classList.add('bg-gray-100', 'text-gray-700');
            questionResponse.classList.remove('hidden');
            fillBlank.classList.add('hidden');
            multipleChoice.classList.add('hidden');
            pictureResponse.classList.add('hidden');
        });
        tab2.addEventListener('click', function() {
            tab2.classList.remove('bg-gray-100', 'text-gray-700');
            tab2.classList.add('bg-primary', 'text-white');
            tab1.classList.remove('bg-primary', 'text-white');
            tab1.classList.add('bg-gray-100', 'text-gray-700');
            // Show all question types for demonstration
            questionResponse.classList.remove('hidden');
            fillBlank.classList.remove('hidden');
            multipleChoice.classList.remove('hidden');
            pictureResponse.classList.remove('hidden');
        });
    }
});

// Timer Script

document.addEventListener('DOMContentLoaded', function() {
    const timerElement = document.getElementById('timer');
    const pauseButton = document.getElementById('pauseButton');
    if (timerElement && pauseButton) {
        let seconds = 14 * 60 + 32; // 14:32 in seconds
        let timerInterval;
        let isPaused = false;
        function updateTimer() {
            const minutes = Math.floor(seconds / 60);
            const remainingSeconds = seconds % 60;
            timerElement.textContent = `${minutes}:${remainingSeconds < 10 ? '0' : ''}${remainingSeconds}`;
            if (seconds > 0) {
                seconds--;
            } else {
                clearInterval(timerInterval);
                timerElement.textContent = "Time's up!";
            }
        }
        timerInterval = setInterval(updateTimer, 1000);
        pauseButton.addEventListener('click', function() {
            if (isPaused) {
                timerInterval = setInterval(updateTimer, 1000);
                pauseButton.innerHTML = '<i class="ri-pause-line text-gray-700"></i>';
            } else {
                clearInterval(timerInterval);
                pauseButton.innerHTML = '<i class="ri-play-line text-gray-700"></i>';
            }
            isPaused = !isPaused;
        });
    }
});

// Notification Popup

document.addEventListener('DOMContentLoaded', function() {
    const notification = document.getElementById('notification');
    if (notification) {
        // Show notification after 5 seconds for demonstration
        setTimeout(function() {
            notification.classList.add('show');
            // Hide notification after 5 seconds
            setTimeout(function() {
                notification.classList.remove('show');
            }, 5000);
        }, 5000);
    }
});

// Leaderboard Tabs

document.addEventListener('DOMContentLoaded', function() {
    const tabButtons = document.querySelectorAll('.leaderboard-tab');
    tabButtons.forEach(button => {
        button.addEventListener('click', function() {
            tabButtons.forEach(btn => {
                btn.classList.remove('bg-primary', 'text-white');
                btn.classList.add('bg-gray-100', 'text-gray-600');
            });
            this.classList.remove('bg-gray-100', 'text-gray-600');
            this.classList.add('bg-primary', 'text-white');
        });
    });
});