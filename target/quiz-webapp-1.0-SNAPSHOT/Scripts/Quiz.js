// Quiz.js

const quiz = window.quizData.quiz;
const questions = window.quizData.questions;
const totalQuestions = questions.length;
let currentQuestion = 0;
let answers = Array(totalQuestions).fill(null);
let timer = quiz.duration * 60; // seconds
let timerInterval = null;

function pad(n) { return n < 10 ? '0' + n : n; }

function renderTimer() {
    const timerValue = document.getElementById('timer-value');
    const min = Math.floor(timer / 60);
    const sec = timer % 60;
    timerValue.textContent = `${pad(min)}:${pad(sec)}`;
    const timerDiv = document.getElementById('quiz-timer');
    if (timer <= 60) {
        timerDiv.classList.remove('blue');
        timerDiv.classList.add('red');
    } else {
        timerDiv.classList.remove('red');
        timerDiv.classList.add('blue');
    }
}

function startTimer() {
    renderTimer();
    timerInterval = setInterval(() => {
        timer--;
        renderTimer();
        if (timer <= 0) {
            clearInterval(timerInterval);
            // Optionally: submitQuiz();
        }
    }, 1000);
}

function renderProgress() {
    // Progress text
    const answeredCount = answers.filter(a => a !== null).length;
    document.getElementById('progress-answered').textContent = `${answeredCount} of ${totalQuestions} answered`;
    // Progress bar
    const percent = Math.round((answeredCount / totalQuestions) * 100);
    document.getElementById('progress-bar-text').textContent = `${percent}%`;
    const circle = document.getElementById('progress-bar');
    const circumference = 2 * Math.PI * 36;
    circle.setAttribute('stroke-dasharray', circumference);
    circle.setAttribute('stroke-dashoffset', circumference * (1 - percent / 100));
    // Question nav
    const nav = document.getElementById('progress-questions');
    nav.innerHTML = '';
    for (let i = 0; i < totalQuestions; i++) {
        const btn = document.createElement('button');
        btn.className = 'progress-question-btn ' +
            (i === currentQuestion ? 'current' : answers[i] !== null ? 'answered' : 'unanswered');
        btn.textContent = i + 1;
        btn.onclick = () => {
            currentQuestion = i;
            renderAll();
        };
        nav.appendChild(btn);
    }
}

function renderQuestion() {
    const q = questions[currentQuestion];
    document.getElementById('question-number-badge').textContent = currentQuestion + 1;
    document.getElementById('question-number-label').textContent = `Question ${currentQuestion + 1}`;
    document.getElementById('question-title').textContent = q.question;
    const optionsList = document.getElementById('options-list');
    optionsList.innerHTML = '';
    if (q.type === 1) {
        // Multiple choice
        let opts = q.possibleAnswers.includes('\n') ? q.possibleAnswers.split('\n') : q.possibleAnswers.split(';');
        opts = opts.map(opt => opt.trim()).filter(opt => opt.length > 0);
        opts.forEach((opt, idx) => {
            const label = document.createElement('label');
            label.className = 'option-label' + (answers[currentQuestion] === idx ? ' selected' : '');
            const radio = document.createElement('input');
            radio.type = 'radio';
            radio.className = 'option-radio';
            radio.name = 'option';
            radio.checked = answers[currentQuestion] === idx;
            radio.onclick = () => {
                answers[currentQuestion] = idx;
                renderAll();
            };
            label.appendChild(radio);
            label.appendChild(document.createTextNode(opt));
            optionsList.appendChild(label);
        });
    } else {
        // Free text input
        const input = document.createElement('input');
        input.type = 'text';
        input.className = 'option-label';
        input.style.width = '100%';
        input.value = answers[currentQuestion] !== null ? answers[currentQuestion] : '';
        input.placeholder = 'Type your answer...';
        input.onkeydown = (e) => {
            if (e.key === 'Enter') {
                answers[currentQuestion] = input.value.trim();
                renderAll();
            }
        };
        optionsList.appendChild(input);
        const btn = document.createElement('button');
        btn.className = 'nav-btn next';
        btn.style.marginTop = '1rem';
        btn.textContent = 'Submit Answer';
        btn.onclick = () => {
            answers[currentQuestion] = input.value.trim();
            renderAll();
        };
        optionsList.appendChild(btn);
    }
}

function showSubmitButton(show) {
    let submitBtn = document.getElementById('submit-btn');
    if (!submitBtn) {
        submitBtn = document.createElement('button');
        submitBtn.className = 'nav-btn submit';
        submitBtn.id = 'submit-btn';
        submitBtn.innerHTML = '<i class="ri-check-line"></i> Submit Quiz';
        submitBtn.onclick = submitQuiz;
        document.querySelector('.navigation-controls').appendChild(submitBtn);
    }
    submitBtn.style.display = show ? '' : 'none';
}

function submitQuiz() {
    clearInterval(timerInterval);
    let correct = 0;
    for (let i = 0; i < questions.length; i++) {
        if (questions[i].type === 1) {
            if (answers[i] === questions[i].correctIndex) correct++;
        } else {
            // Free text: compare to correct answer string (case-insensitive, trimmed)
            const userAns = (answers[i] || '').trim().toLowerCase();
            const correctAns = (questions[i].answer || '').trim().toLowerCase();
            if (userAns && userAns === correctAns) correct++;
        }
    }
    const percent = Math.round((correct / questions.length) * 100);
    // Hide quiz UI, show result
    document.querySelector('.quiz-container').innerHTML = `
        <div id="quiz-result" style="text-align:center; padding:3rem 0;">
            <div class="quiz-result-icon" style="font-size:4rem; color:#22c55e; margin-bottom:1rem;"><i class="ri-checkbox-circle-line"></i></div>
            <div class="quiz-result-title" style="font-size:2rem; font-weight:600; margin-bottom:1rem;">Quiz Completed!</div>
            <div class="quiz-result-score" style="font-size:1.5rem; margin-bottom:0.5rem;">Score: ${correct} / ${questions.length}</div>
            <div class="quiz-result-percentage" style="font-size:1.25rem; color:#2563eb;">${percent}%</div>
            <button id="return-home-btn" class="nav-btn submit" style="margin-top:2rem; background:#22c55e; color:#fff; font-size:1.1rem;">Return Home</button>
        </div>
    `;
    document.getElementById('return-home-btn').onclick = function() {
        fetch('submit-quiz-attempt', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                quizId: quiz.id,
                score: correct,
                total: questions.length,
                percent: percent
            })
        }).then(() => {
            window.location.href = 'quizzes';
        });
    };
}

function renderNav() {
    document.getElementById('prev-btn').disabled = currentQuestion === 0;
    document.getElementById('next-btn').disabled = currentQuestion === totalQuestions - 1;
    showSubmitButton(currentQuestion === totalQuestions - 1);
}

document.getElementById('prev-btn').onclick = () => {
    if (currentQuestion > 0) {
        currentQuestion--;
        renderAll();
    }
};
document.getElementById('next-btn').onclick = () => {
    if (currentQuestion < totalQuestions - 1) {
        currentQuestion++;
        renderAll();
    }
};

function renderHeader() {
    document.getElementById('current-question-number').textContent = currentQuestion + 1;
}

function renderAll() {
    renderHeader();
    renderProgress();
    renderQuestion();
    renderNav();
}

window.onload = function() {
    renderAll();
    startTimer();
};
