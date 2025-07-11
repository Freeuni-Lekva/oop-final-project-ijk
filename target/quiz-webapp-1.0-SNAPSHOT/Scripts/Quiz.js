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
    // Render options
    const optionsList = document.getElementById('options-list');
    optionsList.innerHTML = '';
    // Assume possibleAnswers is a string separated by \n or ;
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
}

function renderNav() {
    document.getElementById('prev-btn').disabled = currentQuestion === 0;
    document.getElementById('next-btn').disabled = currentQuestion === totalQuestions - 1;
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
