// Admin.js

document.addEventListener('DOMContentLoaded', function() {
    // Remove user
    document.querySelectorAll('.admin-remove-user').forEach(btn => {
        btn.onclick = function() {
            const userId = btn.getAttribute('data-user-id');
            if (confirm('Are you sure you want to remove this user?')) {
                fetch('admin?action=removeUser&userId=' + userId, { method: 'POST' })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) location.reload();
                        else alert('Failed to remove user.');
                    });
            }
        };
    });
    // Remove quiz
    document.querySelectorAll('.admin-remove-quiz').forEach(btn => {
        btn.onclick = function() {
            const quizId = btn.getAttribute('data-quiz-id');
            if (confirm('Are you sure you want to remove this quiz?')) {
                fetch('admin?action=removeQuiz&quizId=' + quizId, { method: 'POST' })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) location.reload();
                        else alert('Failed to remove quiz.');
                    });
            }
        };
    });
    // Promote user
    document.querySelectorAll('.admin-promote-user').forEach(btn => {
        btn.onclick = function() {
            const userId = btn.getAttribute('data-user-id');
            if (confirm('Promote this user to administrator?')) {
                fetch('admin?action=promoteUser&userId=' + userId, { method: 'POST' })
                    .then(res => res.json())
                    .then(data => {
                        if (data.success) location.reload();
                        else alert('Failed to promote user.');
                    });
            }
        };
    });
}); 