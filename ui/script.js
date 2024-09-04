document.addEventListener('DOMContentLoaded', () => {
    window.addEventListener('message', function (event) {
        if (event.data.type === "help-text") {
            const helpText = document.querySelector('.help-text');
            if (event.data.display) {
                helpText.style.opacity = 1;
                document.getElementById('help-text').textContent = event.data.text;
            } else {
                helpText.style.opacity = 0;
            }
        }

        if (event.data.type === "text-ui") {
            const textUI = document.querySelector('.text-ui');
            if (event.data.display) {
                textUI.style.opacity = 1;
                document.getElementById('text-ui-key').textContent = event.data.key;
                document.getElementById('text-ui-text').textContent = event.data.text;
            } else {
                textUI.style.opacity = 0;
            }
        }
    });
});
