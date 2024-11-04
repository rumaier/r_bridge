window.addEventListener('message', function (event) {
    if (event.data.type === "help-text") {
        let helpText = document.querySelector('.help-text');
        if (event.data.display) {
            helpText.style.opacity = 1;
            helpText.textContent = event.data.text;
        } else {
            helpText.style.opacity = 0;
        }
    }

    if (event.data.type === "text-ui") {
        let textUI = document.querySelector('.text-ui');
        let key = document.querySelector('.text-ui button');
        let text = document.querySelector('.text-ui p');
        if (event.data.display) {
            key.textContent = event.data.key;
            text.textContent = event.data.text;
            textUI.style.opacity = 1;
        } else {
            textUI.style.opacity = 0;
        }
    }
});
