document.addEventListener('DOMContentLoaded', function() {

    // --- Helper function for toggling password visibility ---
    function setupPasswordToggle(toggleButtonId, passwordInputId) {
        const toggleButton = document.getElementById(toggleButtonId);
        const passwordInput = document.getElementById(passwordInputId);

        if (toggleButton && passwordInput) {
            toggleButton.addEventListener('click', function() {
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);

                const icon = toggleButton.querySelector('i');
                if (type === 'password') {
                    icon.classList.remove('ri-eye-off-line');
                    icon.classList.add('ri-eye-line');
                } else {
                    icon.classList.remove('ri-eye-line');
                    icon.classList.add('ri-eye-off-line');
                }
            });
        }
    }

    // Setup toggles for both password fields
    setupPasswordToggle('togglePassword', 'password');
    setupPasswordToggle('toggleConfirmPassword', 'confirmPassword');


    // --- Custom Checkbox Handler for Terms Agreement ---
    const checkbox = document.getElementById('terms');
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