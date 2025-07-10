// Quiz Data
const quizData = {
    title: "Quantum Physics Fundamentals",
    timeLimit: 25 * 60, // 25 minutes in seconds
    questions: [
        {
            id: 1,
            question: "What is the fundamental principle behind quantum superposition?",
            options: [
                "Particles can exist in multiple states simultaneously until observed",
                "Particles move faster than the speed of light",
                "Energy is always conserved in quantum systems",
                "Matter and energy are interchangeable"
            ],
            correctAnswer: 0
        },
        {
            id: 2,
            question: "Who proposed the wave-particle duality of light?",
            options: [
                "Albert Einstein",
                "Niels Bohr",
                "Louis de Broglie",
                "Max Planck"
            ],
            correctAnswer: 2
        },
        {
            id: 3,
            question: "What does Heisenberg's Uncertainty Principle state?",
            options: [
                "The exact position and momentum of a particle cannot be simultaneously determined",
                "Quantum particles have no definite properties",
                "Energy levels in atoms are quantized",
                "Light behaves as both wave and particle"
            ],
            correctAnswer: 0
        },
        {
            id: 4,
            question: "What is quantum entanglement?",
            options: [
                "The process of measuring quantum states",
                "A phenomenon where particles become correlated and instantly affect each other regardless of distance",
                "The collapse of a wave function",
                "The emission of photons from excited atoms"
            ],
            correctAnswer: 1
        },
        {
            id: 5,
            question: "What is the Schrödinger equation used for?",
            options: [
                "Calculating the speed of quantum particles",
                "Describing how quantum systems evolve over time",
                "Measuring the energy of photons",
                "Determining the mass of subatomic particles"
            ],
            correctAnswer: 1
        },
        {
            id: 6,
            question: "What is a quantum tunneling effect?",
            options: [
                "Particles moving through solid barriers they classically shouldn't be able to pass",
                "The creation of particle-antiparticle pairs",
                "The absorption of light by matter",
                "The emission of radiation from black holes"
            ],
            correctAnswer: 0
        },
        {
            id: 7,
            question: "What does the term 'quantum decoherence' refer to?",
            options: [
                "The process by which quantum systems lose their quantum behavior due to interaction with the environment",
                "The splitting of light into different colors",
                "The conversion of matter into energy",
                "The measurement of quantum spin"
            ],
            correctAnswer: 0
        },
        {
            id: 8,
            question: "What is the significance of Planck's constant?",
            options: [
                "It determines the speed of light in vacuum",
                "It relates energy and frequency in quantum mechanics",
                "It measures the strength of gravitational force",
                "It defines the charge of an electron"
            ],
            correctAnswer: 1
        },
        {
            id: 9,
            question: "What is the photoelectric effect?",
            options: [
                "The bending of light around massive objects",
                "The emission of electrons when light hits a material",
                "The splitting of atoms into smaller particles",
                "The creation of electromagnetic waves"
            ],
            correctAnswer: 1
        },
        {
            id: 10,
            question: "What does the Copenhagen interpretation explain?",
            options: [
                "The behavior of particles at the speed of light",
                "The meaning of quantum mechanics and wave function collapse",
                "The structure of atomic nuclei",
                "The formation of chemical bonds"
            ],
            correctAnswer: 1
        },
        {
            id: 11,
            question: "What is quantum spin?",
            options: [
                "The actual rotation of particles around their axis",
                "An intrinsic form of angular momentum carried by elementary particles",
                "The orbital motion of electrons around the nucleus",
                "The vibration frequency of quantum fields"
            ],
            correctAnswer: 1
        },
        {
            id: 12,
            question: "What is the Pauli exclusion principle?",
            options: [
                "No two fermions can occupy the same quantum state simultaneously",
                "Energy is quantized in discrete levels",
                "Particles and antiparticles annihilate each other",
                "The uncertainty in position and momentum are related"
            ],
            correctAnswer: 0
        },
        {
            id: 13,
            question: "What is a quantum field?",
            options: [
                "A region of space where quantum effects are observed",
                "The fundamental entity from which particles arise as excitations",
                "The boundary between classical and quantum physics",
                "A mathematical tool for calculating probabilities"
            ],
            correctAnswer: 1
        },
        {
            id: 14,
            question: "What is quantum interference?",
            options: [
                "The collision between quantum particles",
                "The phenomenon where quantum amplitudes can add or cancel each other",
                "The measurement of quantum properties",
                "The interaction between matter and antimatter"
            ],
            correctAnswer: 1
        },
        {
            id: 15,
            question: "What is the quantum Zeno effect?",
            options: [
                "The slowing down of quantum evolution through frequent measurements",
                "The acceleration of particles to near light speed",
                "The creation of virtual particles in vacuum",
                "The emission of Hawking radiation from black holes"
            ],
            correctAnswer: 0
        },
        {
            id: 16,
            question: "What is Bell's theorem about?",
            options: [
                "The quantization of energy levels in atoms",
                "The impossibility of local hidden variable theories in quantum mechanics",
                "The wave-particle duality of matter",
                "The conservation of energy in quantum systems"
            ],
            correctAnswer: 1
        },
        {
            id: 17,
            question: "What is quantum chromodynamics?",
            options: [
                "The study of color perception in quantum systems",
                "The theory describing the strong nuclear force between quarks",
                "The interaction between light and matter",
                "The behavior of electrons in atoms"
            ],
            correctAnswer: 1
        },
        {
            id: 18,
            question: "What is a qubit?",
            options: [
                "A unit of classical information",
                "The basic unit of quantum information that can exist in superposition",
                "A type of quantum particle",
                "A measurement device for quantum states"
            ],
            correctAnswer: 1
        },
        {
            id: 19,
            question: "What is quantum error correction?",
            options: [
                "A method to prevent measurement errors in experiments",
                "Techniques to protect quantum information from decoherence and noise",
                "The correction of theoretical predictions",
                "The calibration of quantum measurement devices"
            ],
            correctAnswer: 1
        },
        {
            id: 20,
            question: "What is the many-worlds interpretation?",
            options: [
                "The idea that quantum measurements create parallel universes",
                "The theory that multiple dimensions exist in space",
                "The concept that particles exist in many locations simultaneously",
                "The belief that quantum mechanics applies to large objects"
            ],
            correctAnswer: 0
        },
        {
            id: 21,
            question: "What is quantum annealing?",
            options: [
                "The heating of quantum systems to high temperatures",
                "A quantum computing approach for solving optimization problems",
                "The cooling of particles to absolute zero",
                "The process of measuring quantum states"
            ],
            correctAnswer: 1
        },
        {
            id: 22,
            question: "What is the quantum Hall effect?",
            options: [
                "The deflection of charged particles in magnetic fields",
                "A quantum phenomenon where Hall conductivity is quantized",
                "The emission of light from quantum dots",
                "The tunneling of electrons through barriers"
            ],
            correctAnswer: 1
        },
        {
            id: 23,
            question: "What is quantum cryptography based on?",
            options: [
                "The complexity of mathematical algorithms",
                "The fundamental principles of quantum mechanics for secure communication",
                "The random nature of radioactive decay",
                "The speed of quantum computers"
            ],
            correctAnswer: 1
        },
        {
            id: 24,
            question: "What is a quantum phase transition?",
            options: [
                "The change from solid to liquid in quantum materials",
                "A transition between different quantum phases of matter at absolute zero",
                "The transformation of particles into antiparticles",
                "The emission of photons during state changes"
            ],
            correctAnswer: 1
        },
        {
            id: 25,
            question: "What is quantum coherence?",
            options: [
                "The ability of quantum systems to maintain definite phase relationships",
                "The synchronization of multiple quantum computers",
                "The alignment of particle spins in magnetic fields",
                "The consistent measurement results in experiments"
            ],
            correctAnswer: 0
        },
        {
            id: 26,
            question: "What is the quantum no-cloning theorem?",
            options: [
                "Quantum particles cannot be created or destroyed",
                "It is impossible to create perfect copies of arbitrary quantum states",
                "Quantum information travels faster than light",
                "Quantum systems cannot be measured without disturbance"
            ],
            correctAnswer: 1
        },
        {
            id: 27,
            question: "What is quantum supremacy?",
            options: [
                "The dominance of quantum physics over classical physics",
                "The point where quantum computers outperform classical computers for specific tasks",
                "The ability to control all quantum effects",
                "The complete understanding of quantum mechanics"
            ],
            correctAnswer: 1
        },
        {
            id: 28,
            question: "What is a quantum dot?",
            options: [
                "A tiny point in space-time",
                "A nanoscale semiconductor structure that confines electrons in all three dimensions",
                "A type of quantum measurement device",
                "A theoretical particle in quantum field theory"
            ],
            correctAnswer: 1
        },
        {
            id: 29,
            question: "What is quantum teleportation?",
            options: [
                "The instant transportation of matter across space",
                "The transfer of quantum information using entanglement and classical communication",
                "The movement of particles faster than light",
                "The creation of wormholes in spacetime"
            ],
            correctAnswer: 1
        },
        {
            id: 30,
            question: "What is the quantum measurement problem?",
            options: [
                "The difficulty in building precise quantum instruments",
                "The question of how and why wave function collapse occurs during measurement",
                "The inability to measure quantum properties accurately",
                "The cost of quantum measurement equipment"
            ],
            correctAnswer: 1
        }
    ]
};

// State
let currentQuestion = 0;
let answers = new Array(quizData.questions.length).fill(null);
let timeRemaining = quizData.timeLimit;
let isSubmitted = false;
let showWarning = false;
let timerInterval = null;

function formatTime(seconds) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
}

function renderHeader() {
    const header = document.getElementById('quiz-header');
    if (!header) return;
    let timerClass = showWarning ? 'quiz-header-timer red' : 'quiz-header-timer blue';
    header.innerHTML = `
    <div class="quiz-header quiz-header-content">
      <div style="display:flex;align-items:center;gap:1rem;">
        <a href="index.html" class="btn btn-primary" style="padding:0.5rem 1rem;font-size:1rem;background:#f3f4f6;color:#64748b;"><i class="ri-arrow-left-line"></i></a>
        <div>
          <div class="quiz-header-title">${quizData.title}</div>
          <div class="quiz-header-meta">Question ${currentQuestion + 1} of ${quizData.questions.length}</div>
        </div>
      </div>
      <div class="${timerClass}">
        <i class="ri-time-line"></i>
        <span>${formatTime(timeRemaining)}</span>
        ${showWarning ? '<i class="ri-alert-line" style="color:#dc2626;"></i>' : ''}
      </div>
    </div>
  `;
}

function renderProgress() {
    const progress = document.getElementById('progress-indicator');
    if (!progress) return;
    const answeredCount = answers.filter(a => a !== null).length;
    const percent = (answeredCount / quizData.questions.length) * 100;
    progress.innerHTML = `
    <div class="progress-card">
      <div class="progress-title">Progress</div>
      <div class="progress-bar-container" style="position:relative;">
        <svg class="progress-bar-svg" viewBox="0 0 36 36">
          <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#e5e7eb" stroke-width="2"/>
          <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#3b82f6" stroke-width="2" stroke-dasharray="${percent}, 100"/>
        </svg>
        <div class="progress-bar-text" style="position:absolute;top:0;left:0;width:5rem;height:5rem;">${Math.round(percent)}%</div>
        <div style="margin-left:2rem;font-size:0.95rem;color:#64748b;">${answeredCount} of ${quizData.questions.length} answered</div>
      </div>
      <div class="progress-questions">
        ${quizData.questions.map((q, i) => {
        let btnClass = 'progress-question-btn ';
        if (i === currentQuestion) btnClass += 'current';
        else if (answers[i] !== null) btnClass += 'answered';
        else btnClass += 'unanswered';
        return `<button class="${btnClass}" onclick="jumpToQuestion(${i})">${answers[i] !== null && i !== currentQuestion ? '<i class=\'ri-check-line\'></i>' : i + 1}</button>`;
    }).join('')}
      </div>
      <div class="progress-legend">
        <div class="progress-legend-item"><span class="progress-legend-dot current"></span>Current</div>
        <div class="progress-legend-item"><span class="progress-legend-dot answered"></span>Answered</div>
        <div class="progress-legend-item"><span class="progress-legend-dot unanswered"></span>Unanswered</div>
      </div>
    </div>
  `;
}

function renderQuestion() {
    const q = quizData.questions[currentQuestion];
    const questionDiv = document.getElementById('question-display');
    if (!questionDiv) return;
    questionDiv.innerHTML = `
    <div class="question-card">
      <div class="question-number">
        <span class="question-number-badge">${currentQuestion + 1}</span>
        <span style="color:#64748b;font-size:0.95rem;">Question ${currentQuestion + 1}</span>
      </div>
      <div class="question-title">${q.question}</div>
      <div class="options-list">
        ${q.options.map((opt, i) => `
          <label class="option-label${answers[currentQuestion] === i ? ' selected' : ''}">
            <input type="radio" class="option-radio" name="answer" value="${i}" ${answers[currentQuestion] === i ? 'checked' : ''} onchange="selectAnswer(${i})">
            <span>${opt}</span>
          </label>
        `).join('')}
      </div>
    </div>
  `;
}

function renderNavigation() {
    const nav = document.getElementById('navigation-controls');
    if (!nav) return;
    const isFirst = currentQuestion === 0;
    const isLast = currentQuestion === quizData.questions.length - 1;
    const hasAnswer = answers[currentQuestion] !== null;
    const allAnswered = answers.filter(a => a !== null).length === quizData.questions.length;
    nav.innerHTML = `
    <div class="navigation-card">
      <div class="navigation-controls">
        <button class="nav-btn prev" onclick="prevQuestion()" ${isFirst ? 'disabled' : ''}>
          <i class="ri-arrow-left-line"></i> Previous
        </button>
        <div style="display:flex;gap:1rem;">
          ${!isLast ? `
            <button class="nav-btn next" onclick="nextQuestion()" ${!hasAnswer ? 'disabled' : ''}>
              Next <i class="ri-arrow-right-line"></i>
            </button>
          ` : `
            <button class="nav-btn submit" onclick="submitQuiz()" ${!allAnswered ? 'disabled' : ''}>
              <i class="ri-check-line"></i> Submit Quiz
            </button>
          `}
        </div>
      </div>
      ${!allAnswered && isLast ? `
        <div class="navigation-warning">
          <i class="ri-information-line"></i>
          Please answer all questions before submitting the quiz.
        </div>
      ` : ''}
    </div>
  `;
}

function renderResult() {
    const resultDiv = document.getElementById('quiz-result');
    if (!resultDiv) return;
    const correct = answers.reduce((count, ans, i) => ans === quizData.questions[i].correctAnswer ? count + 1 : count, 0);
    const percent = ((correct / quizData.questions.length) * 100).toFixed(1);
    resultDiv.innerHTML = `
    <div class="quiz-result-icon"><i class="ri-check-line"></i></div>
    <div class="quiz-result-title">Quiz Completed!</div>
    <div class="quiz-result-score">You scored ${correct} out of ${quizData.questions.length}</div>
    <div class="quiz-result-percentage">${percent}%</div>
    <a href="index.html" class="quiz-result-btn"><i class="ri-arrow-left-line"></i> Return to Home</a>
  `;
    resultDiv.style.display = '';
    document.getElementById('progress-indicator').style.display = 'none';
    document.getElementById('question-display').style.display = 'none';
    document.getElementById('navigation-controls').style.display = 'none';
    document.getElementById('quiz-header').style.display = 'none';
}

function selectAnswer(i) {
    answers[currentQuestion] = i;
    renderProgress();
    renderQuestion();
    renderNavigation();
}
window.selectAnswer = selectAnswer;

function nextQuestion() {
    if (currentQuestion < quizData.questions.length - 1) {
        currentQuestion++;
        renderAll();
    }
}
window.nextQuestion = nextQuestion;

function prevQuestion() {
    if (currentQuestion > 0) {
        currentQuestion--;
        renderAll();
    }
}
window.prevQuestion = prevQuestion;

function jumpToQuestion(i) {
    currentQuestion = i;
    renderAll();
}
window.jumpToQuestion = jumpToQuestion;

function submitQuiz() {
    isSubmitted = true;
    clearInterval(timerInterval);
    renderResult();
}
window.submitQuiz = submitQuiz;

function renderAll() {
    if (isSubmitted) {
        renderResult();
        return;
    }
    renderHeader();
    renderProgress();
    renderQuestion();
    renderNavigation();
    document.getElementById('quiz-result').style.display = 'none';
    document.getElementById('progress-indicator').style.display = '';
    document.getElementById('question-display').style.display = '';
    document.getElementById('navigation-controls').style.display = '';
    document.getElementById('quiz-header').style.display = '';
}

function startTimer() {
    timerInterval = setInterval(() => {
        if (isSubmitted) {
            clearInterval(timerInterval);
            return;
        }
        timeRemaining--;
        if (timeRemaining <= 0) {
            timeRemaining = 0;
            isSubmitted = true;
            renderResult();
            clearInterval(timerInterval);
            return;
        }
        if (timeRemaining <= 300 && !showWarning) {
            showWarning = true;
        }
        renderHeader();
    }, 1000);
}

// Initialize
renderAll();
startTimer(); 