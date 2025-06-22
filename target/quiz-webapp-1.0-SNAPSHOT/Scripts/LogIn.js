// Scripts for LogIn.jsp will be placed here.

document.addEventListener('DOMContentLoaded', function() {
    
    // --- Password Visibility Toggle ---
    const togglePasswordButton = document.getElementById('togglePassword');
    const passwordInput = document.getElementById('password');

    if (togglePasswordButton && passwordInput) {
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
    }

    // --- Custom Checkbox Handler ---
    const checkbox = document.getElementById('remember');
    const customCheckbox = document.getElementById('customCheckbox');
    const indicator = document.getElementById('checkboxIndicator');

    if (checkbox && customCheckbox && indicator) {
        const updateCheckboxState = () => {
            if (checkbox.checked) {
                indicator.classList.remove('hidden');
                customCheckbox.classList.add('border-primary');
                customCheckbox.classList.remove('border-gray-300');
            } else {
                indicator.classList.add('hidden');
                customCheckbox.classList.remove('border-primary');
                customCheckbox.classList.add('border-gray-300');
            }
        };
        
        customCheckbox.addEventListener('click', function() {
            checkbox.checked = !checkbox.checked;
            updateCheckboxState();
        });
        
        checkbox.addEventListener('change', updateCheckboxState);
    }
}); 