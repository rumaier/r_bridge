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
});