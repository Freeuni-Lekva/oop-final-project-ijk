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
                    <select class="question-type w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" onchange="handleQuestionTypeChange(this)" name="questionType[]">
                        <option value="">Select question type</option>
                        <option value="1">Multiple Choice</option>
                        <option value="2">Question-Response</option>
                        <option value="3">Fill in the Blank</option>
                        <option value="4">Picture-Response</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Question Text *</label>
                    <textarea class="question-text w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" rows="2" placeholder="Enter your question" name="questionText[]"></textarea>
                </div>
            </div>
            
            <div class="question-options space-y-3" style="display: none;">
                <div class="flex items-center space-x-2">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 1" name="optionText[]">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 2" name="optionText[]">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 3" name="optionText[]">
                </div>
                <div class="flex items-center space-x-2">
                    <input type="text" class="option-text flex-1 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Option 4" name="optionText[]">
                </div>
            </div>
            
            <div class="mt-4 correct-answer-block">
                <label class="block text-sm font-medium text-gray-700 mb-2">Correct Answer *</label>
                <input type="text" class="correct-answer-input w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent" placeholder="Enter correct answer" name="correctAnswer[]">
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
        const correctAnswerBlock = questionDiv.querySelector('.correct-answer-block');
        const imageUpload = questionDiv.querySelector('.image-upload');
        const questionType = selectElement.value;
        
        // Hide all sections first
        questionOptions.style.display = 'none';
        correctAnswerBlock.style.display = 'none';
        imageUpload.style.display = 'none';
        
        // Show relevant sections based on question type
        if (questionType === '1') { // Multiple Choice
            questionOptions.style.display = 'block';
            correctAnswerBlock.style.display = 'block';
            // Reset option inputs for multiple choice
            const optionInputs = questionOptions.querySelectorAll('.option-text');
            optionInputs.forEach((input, index) => {
                input.value = '';
                input.placeholder = `Option ${index + 1}`;
                input.style.display = 'block';
            });
        } else if (questionType === '2' || questionType === '3') { // Question-Response or Fill in the Blank
            correctAnswerBlock.style.display = 'block';
        } else if (questionType === '4') { // Picture-Response
            correctAnswerBlock.style.display = 'block';
            imageUpload.style.display = 'block';
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
        const quizDuration = document.getElementById('quizDuration').value;
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
        
        if (!quizDuration || quizDuration < 1 || quizDuration > 120) {
            alert('Please enter a valid duration between 1 and 120 minutes.');
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
            const correctAnswerInput = question.querySelector('.correct-answer-input');
            
            if (!questionType) {
                alert(`Please select a question type for question ${i + 1}.`);
                return false;
            }
            
            if (!questionText) {
                alert(`Please enter question text for question ${i + 1}.`);
                return false;
            }
            
            // Validate based on question type
            if (questionType === '1') { // Multiple Choice
                const options = question.querySelectorAll('.option-text');
                let validOptions = 0;
                options.forEach(option => {
                    if (option.value.trim()) validOptions++;
                });
                if (validOptions < 2) {
                    alert(`Please provide at least 2 options for question ${i + 1}.`);
                    return false;
                }
                if (!correctAnswerInput.value.trim()) {
                    alert(`Please provide a correct answer for question ${i + 1}.`);
                    return false;
                }
            } else if (questionType === '2' || questionType === '3' || questionType === '4') { // Other types
                if (!correctAnswerInput.value.trim()) {
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
