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

// Friend Requests Dropdown
const friendBtn = document.getElementById('friendRequestsBtn');
const friendDropdown = document.getElementById('friendRequestsDropdown');
if (friendBtn && friendDropdown) {
    friendBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        friendDropdown.classList.toggle('hidden');
        // Load pending friend requests when dropdown is opened
        if (!friendDropdown.classList.contains('hidden')) {
            loadPendingFriendRequests();
        }
    });
    document.addEventListener('click', function(e) {
        if (!friendDropdown.classList.contains('hidden')) {
            friendDropdown.classList.add('hidden');
        }
    });
    friendDropdown.addEventListener('click', function(e) {
        e.stopPropagation();
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const addFriendBtn = document.getElementById('openAddFriendModal');
    const addFriendModal = document.getElementById('addFriendModal');
    const closeAddFriendModal = document.getElementById('closeAddFriendModal');
    const friendSearchInput = document.getElementById('friendSearchInput');
    const friendSearchResults = document.getElementById('friendSearchResults');

    if (addFriendBtn && addFriendModal && closeAddFriendModal) {
        addFriendBtn.addEventListener('click', function(e) {
            e.preventDefault();
            addFriendModal.classList.remove('hidden');
            if (friendSearchInput && friendSearchResults) {
                friendSearchInput.value = '';
                friendSearchResults.innerHTML = 'Type to search for users';
            }
        });
        closeAddFriendModal.addEventListener('click', function() {
            addFriendModal.classList.add('hidden');
        });
        addFriendModal.addEventListener('click', function(e) {
            if (e.target === addFriendModal) {
                addFriendModal.classList.add('hidden');
            }
        });
    }

    if (friendSearchInput) {
        let searchTimeout;
        friendSearchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            if (!query) {
                friendSearchResults.innerHTML = 'Type to search for users';
                return;
            }
            searchTimeout = setTimeout(() => {
                fetch(`FriendServlet?action=search&query=${encodeURIComponent(query)}`)
                    .then(res => res.json())
                    .then(data => {
                        if (!Array.isArray(data) || data.length === 0) {
                            friendSearchResults.innerHTML = '<span class="text-gray-400">no such user</span>';
                        } else {
                            friendSearchResults.innerHTML = '';
                            data.forEach(user => {
                                // Debug log
                                console.log('Rendering user:', user);
                                // Create the result element
                                const resultDiv = document.createElement('div');
                                resultDiv.className = 'flex items-center justify-between bg-gray-50 rounded px-3 py-2';

                                // Create the username span
                                const span = document.createElement('span');
                                span.className = 'text-gray-700 username-span';
                                span.textContent = user;

                                // Create the button
                                const button = document.createElement('button');
                                button.className = 'mr-3 px-3 py-1 text-xs bg-primary text-white rounded hover:bg-primary/80 transition-colors request-btn';
                                button.textContent = 'Add';
                                button.setAttribute('data-username', user);
                                button.onclick = (e) => {
                                    button.textContent = 'Sent';
                                    button.disabled = true;
                                    button.classList.remove('bg-primary', 'hover:bg-primary/80');
                                    button.classList.add('bg-gray-300', 'cursor-not-allowed');
                                    sendFriendRequest(user);
                                };

                                // Append button and span (button left, span right)
                                resultDiv.appendChild(span);
                                resultDiv.appendChild(button);

                                // Add to results
                                friendSearchResults.appendChild(resultDiv);
                            });
                        }
                    });
            }, 300);
        });
    }
});

function showNotification(title, message, iconClass) {
    const notification = document.getElementById('notification');
    if (!notification) return;
    // Update icon
    const icon = notification.querySelector('.notification-icon i');
    if (icon && iconClass) {
        icon.className = iconClass;
    }
    // Update title and message
    const titleElem = notification.querySelector('h4');
    const messageElem = notification.querySelector('p');
    if (titleElem) titleElem.textContent = title;
    if (messageElem) messageElem.textContent = message;
    // Show notification
    notification.classList.add('show');
    // Hide after 3 seconds
    setTimeout(() => {
        notification.classList.remove('show');
    }, 3000);
}

function sendFriendRequest(toUser) {
    fetch('FriendServlet', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `action=sendRequest&toUser=${encodeURIComponent(toUser)}`
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('Friend Request Sent', 'Your friend request was sent successfully!', 'ri-check-line ri-lg');
        } else {
            showNotification('Request Failed', 'Could not send friend request. Try again later.', 'ri-close-line ri-lg');
        }
    })
    .catch(error => {
        showNotification('Network Error', 'Could not connect to server. Try again later.', 'ri-close-line ri-lg');
    });
}

function updateFriendRequestDot(show) {
    let dot = document.getElementById('friendRequestDot');
    if (show) {
        if (!dot) {
            const btn = document.getElementById('friendRequestsBtn');
            dot = document.createElement('span');
            dot.id = 'friendRequestDot';
            dot.style.position = 'absolute';
            dot.style.top = '6px';
            dot.style.right = '6px';
            dot.style.width = '12px';
            dot.style.height = '12px';
            dot.style.background = '#e53e3e';
            dot.style.borderRadius = '50%';
            dot.style.border = '2px solid #fff';
            dot.style.zIndex = '10';
            btn.appendChild(dot);
        }
    } else {
        if (dot) dot.remove();
    }
}

function loadPendingFriendRequests() {
    const list = document.getElementById('friendRequestsList');
    if (!list) return;
    fetch('FriendServlet?action=getPendingRequests')
        .then(res => res.json())
        .then(data => {
            updateFriendRequestDot(Array.isArray(data) && data.length > 0);
            if (!Array.isArray(data) || data.length === 0) {
                list.innerHTML = '<div class="text-center text-gray-400">no new friend requests</div>';
            } else {
                list.innerHTML = '';
                data.forEach(usernameFrom => {
                    const wrapper = document.createElement('div');
                    wrapper.className = 'flex items-center justify-between mb-2';
                    const name = document.createElement('span');
                    name.className = 'text-gray-800 font-medium';
                    name.textContent = usernameFrom;
                    const actions = document.createElement('div');
                    actions.className = 'flex flex-row items-center';
                    // Accept SVG button
                    const acceptBtn = document.createElement('button');
                    acceptBtn.innerHTML = `<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-person-fill-add\" viewBox=\"0 0 16 16\"><path d=\"M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0\"/><path d=\"M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4\"/></svg>`;
                    acceptBtn.className = 'px-2 py-1 rounded text-xs font-semibold bg-green-500 text-white hover:bg-green-600 transition-colors mr-2 flex items-center justify-center';
                    acceptBtn.title = 'Accept';
                    acceptBtn.onclick = () => handleFriendRequest(usernameFrom, true, wrapper);
                    // Decline SVG button
                    const declineBtn = document.createElement('button');
                    declineBtn.innerHTML = `<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"16\" height=\"16\" fill=\"currentColor\" class=\"bi bi-person-fill-dash\" viewBox=\"0 0 16 16\"><path d=\"M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0\"/><path d=\"M2 13c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4\"/></svg>`;
                    declineBtn.className = 'px-2 py-1 rounded text-xs font-semibold bg-red-500 text-white hover:bg-red-600 transition-colors flex items-center justify-center';
                    declineBtn.title = 'Decline';
                    declineBtn.onclick = () => handleFriendRequest(usernameFrom, false, wrapper);
                    actions.appendChild(acceptBtn);
                    actions.appendChild(declineBtn);
                    wrapper.appendChild(name);
                    wrapper.appendChild(actions);
                    list.appendChild(wrapper);
                });
            }
        });
}

function handleFriendRequest(fromUser, accept, wrapper) {
    fetch('FriendServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: accept ? `action=acceptRequest&fromUser=${encodeURIComponent(fromUser)}` : `action=declineRequest&fromUser=${encodeURIComponent(fromUser)}`
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            showNotification(
                accept ? 'Friend Request Accepted' : 'Friend Request Declined',
                accept ? 'You are now friends!' : 'Friend request declined.',
                accept ? 'ri-user-add-line ri-lg' : 'ri-close-line ri-lg'
            );
            wrapper.remove();
        } else {
            showNotification('Error', 'Could not process request.', 'ri-close-line ri-lg');
        }
    })
    .catch(() => {
        showNotification('Network Error', 'Could not connect to server.', 'ri-close-line ri-lg');
    });
}

document.addEventListener('DOMContentLoaded', function() {
    const openFriendsModal = document.getElementById('openFriendsModal');
    const friendsModal = document.getElementById('friendsModal');
    const closeFriendsModal = document.getElementById('closeFriendsModal');
    const friendsList = document.getElementById('friendsList');

    if (openFriendsModal && friendsModal && closeFriendsModal && friendsList) {
        openFriendsModal.addEventListener('click', function(e) {
            e.preventDefault();
            friendsModal.classList.remove('hidden');
            friendsList.innerHTML = 'Loading...';
            fetch('FriendServlet?action=getFriends')
                .then(res => res.json())
                .then(data => {
                    if (!Array.isArray(data) || data.length === 0) {
                        friendsList.innerHTML = '<div class="text-gray-400">You have no friends yet.</div>';
                    } else {
                        friendsList.innerHTML = '';
                        data.forEach(friend => {
                            const div = document.createElement('div');
                            div.className = 'py-2 px-4 bg-gray-100 rounded mb-2';
                            div.textContent = friend;
                            friendsList.appendChild(div);
                        });
                    }
                })
                .catch(() => {
                    friendsList.innerHTML = '<div class="text-red-500">Failed to load friends.</div>';
                });
        });
        closeFriendsModal.addEventListener('click', function() {
            friendsModal.classList.add('hidden');
        });
        friendsModal.addEventListener('click', function(e) {
            if (e.target === friendsModal) {
                friendsModal.classList.add('hidden');
            }
        });
    }
});
