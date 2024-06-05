// script.js
window.addEventListener('message', function(event) {
    if (event.data.action === 'open') {
        document.getElementById('app').style.display = 'block';
    }
});

function playVideo() {
    const url = document.getElementById('url').value;
    fetch(`https://${GetParentResourceName()}/play`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            screenId: 'main_screen', // example screen ID
            url: url
        })
    }).then(resp => resp.json()).then(resp => {
        if (resp === 'ok') {
            console.log('Video is playing');
        } else {
            console.log('Failed to play video');
        }
    });
}
