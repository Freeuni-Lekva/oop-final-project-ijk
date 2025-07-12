document.addEventListener('DOMContentLoaded', function() {
    let questionCounter = 0;
    
    // Add Question Button
    const addQuestionBtn = document.getElementById('addQuestionBtn');
    const questionsContainer = document.getElementById('questionsContainer');
    
    addQuestionBtn.addEventListener('click', function() {
        addQuestion();
    });
    
    function addQuestion() {
        questionCounter++;
        const questionDiv = document.createElement('div');
        questionDiv.className = 'bg-gray-50 rounded-lg p-6 border border-gray-200';
        questionDiv.innerHTML = `
            <div class="flex justify-between items-center mb-4">
                <h3 class="text-lg font-medium text-gray-900">Question ${questionCounter}</h3>
                <button type="button" class="text-red-500 hover:text-red-700 transition-colors" onclick="removeQuestion(this)">
                    <i class="ri-delete-bin-line"></i>
                </button>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-4">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Question Type *</label>
                    <select class="question-type w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" onchange="handleQuestionTypeChange(this)">
                        <option value="">Select question type</option>
                        <option value="1">Multiple Choice</option>
                        <option value="2">True/False</option>
                        <option value="3">Free Text</option>
                        <option value="4">Fill in the Blank</option>
                        <option value="5">Matching</option>
                        <option value="6">Image Question</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Question Text *</label>
                    <textarea class="question-text w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" rows="2" placeholder="Enter your question"></textarea>
                </div>
            </div>
            
            <div class="question-options space-y-3" style="display: none;">
                <div class="flex items-center space-x-2">
                    <input type="radio" name="correct${questionCounter}" value="1" class="text-primary">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 1">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="radio" name="correct${questionCounter}" value="2" class="text-primary">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 2">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="radio" name="correct${questionCounter}" value="3" class="text-primary">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 3">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="radio" name="correct${questionCounter}" value="4" class="text-primary">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 4">
                </div>
                <button type="button" class="text-sm text-primary hover:text-primary/80 transition-colors" onclick="addOption(this)">
                    <i class="ri-add-line mr-1"></i>Add Option
                </button>
            </div>
            
            <div class="correct-answer mt-4" style="display: none;">
                <label class="block text-sm font-medium text-gray-700 mb-2">Correct Answer *</label>
                <input type="text" class="correct-answer-input w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Enter correct answer">
            </div>
            
            <div class="image-upload mt-4" style="display: none;">
                <label class="block text-sm font-medium text-gray-700 mb-2">Question Image</label>
                <input type="file" class="image-input w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" accept="image/*">
                <p class="text-xs text-gray-500 mt-1">Upload an image for your question (optional)</p>
            </div>
        `;
        
        questionsContainer.appendChild(questionDiv);
    }
    
    // Handle question type changes
    window.handleQuestionTypeChange = function(selectElement) {
        const questionDiv = selectElement.closest('.bg-gray-50');
        const questionOptions = questionDiv.querySelector('.question-options');
        const correctAnswer = questionDiv.querySelector('.correct-answer');
        const imageUpload = questionDiv.querySelector('.image-upload');
        const questionType = selectElement.value;
        
        // Hide all sections first
        questionOptions.style.display = 'none';
        correctAnswer.style.display = 'none';
        imageUpload.style.display = 'none';
        
        // Show relevant sections based on question type
        if (questionType === '1') { // Multiple Choice
            questionOptions.style.display = 'block';
        } else if (questionType === '2') { // True/False
            questionOptions.style.display = 'block';
            // Set predefined options for True/False
            const optionInputs = questionOptions.querySelectorAll('.option-text');
            optionInputs[0].value = 'True';
            optionInputs[1].value = 'False';
            optionInputs[2].style.display = 'none';
            optionInputs[3].style.display = 'none';
        } else if (questionType === '3' || questionType === '4') { // Free Text or Fill in the Blank
            correctAnswer.style.display = 'block';
        } else if (questionType === '6') { // Image Question
            questionOptions.style.display = 'block';
            imageUpload.style.display = 'block';
        }
    };
    
    // Add option button
    window.addOption = function(button) {
        const questionOptions = button.parentElement;
        const optionCount = questionOptions.querySelectorAll('.flex.items-center.space-x-2').length;
        
        if (optionCount < 6) {
            const newOption = document.createElement('div');
            newOption.className = 'flex items-center space-x-2';
            newOption.innerHTML = `
                <input type="radio" name="correct${questionCounter}" value="${optionCount + 1}" class="text-primary">
                <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option ${optionCount + 1}">
            `;
            
            button.parentNode.insertBefore(newOption, button);
        }
    };
    
    // Remove question
    window.removeQuestion = function(button) {
        const questionDiv = button.closest('.bg-gray-50');
        questionDiv.remove();
        updateQuestionNumbers();
    };
    
    // Update question numbers after removal
    function updateQuestionNumbers() {
        const questions = questionsContainer.querySelectorAll('.bg-gray-50');
        questions.forEach((question, index) => {
            const questionTitle = question.querySelector('h3');
            questionTitle.textContent = `Question ${index + 1}`;
        });
    }
    
    // Form validation
    const createQuizForm = document.getElementById('createQuizForm');
    createQuizForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        if (!validateForm()) {
            return;
        }
        
        // Submit form
        this.submit();
    });
    
    function validateForm() {
        const quizTitle = document.getElementById('quizTitle').value.trim();
        const quizCategory = document.getElementById('quizCategory').value;
        const quizDifficulty = document.getElementById('quizDifficulty').value;
        const questions = questionsContainer.querySelectorAll('.bg-gray-50');
        
        if (!quizTitle) {
            alert('Please enter a quiz title.');
            return false;
        }
        
        if (!quizCategory) {
            alert('Please select a category.');
            return false;
        }
        
        if (!quizDifficulty) {
            alert('Please select a difficulty level.');
            return false;
        }
        
        if (questions.length < 1) {
            alert('Please add at least one question.');
            return false;
        }
        
        // Validate each question
        for (let i = 0; i < questions.length; i++) {
            const question = questions[i];
            const questionType = question.querySelector('.question-type').value;
            const questionText = question.querySelector('.question-text').value.trim();
            
            if (!questionType) {
                alert(`Please select a question type for question ${i + 1}.`);
                return false;
            }
            
            if (!questionText) {
                alert(`Please enter question text for question ${i + 1}.`);
                return false;
            }
            
            // Validate based on question type
            if (questionType === '1' || questionType === '2') { // Multiple Choice or True/False
                const options = question.querySelectorAll('.option-text');
                const correctAnswer = question.querySelector('input[type="radio"]:checked');
                
                let validOptions = 0;
                options.forEach(option => {
                    if (option.value.trim()) validOptions++;
                });
                
                if (validOptions < 2) {
                    alert(`Please provide at least 2 options for question ${i + 1}.`);
                    return false;
                }
                
                if (!correctAnswer) {
                    alert(`Please select a correct answer for question ${i + 1}.`);
                    return false;
                }
            } else if (questionType === '3' || questionType === '4') { // Free Text or Fill in the Blank
                const correctAnswer = question.querySelector('.correct-answer-input').value.trim();
                if (!correctAnswer) {
                    alert(`Please provide a correct answer for question ${i + 1}.`);
                    return false;
                }
            }
        }
        
        return true;
    }
    
    // Preview button
    const previewBtn = document.getElementById('previewBtn');
    previewBtn.addEventListener('click', function() {
        if (validateForm()) {
            // Show preview modal or redirect to preview page
            alert('Preview functionality will be implemented in the next phase.');
        }
    });
    
    // Add initial question
    addQuestion();
});
