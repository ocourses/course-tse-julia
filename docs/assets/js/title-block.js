var body_padding_top;

window.onload = function get_body() {
    var body = document.body;
    body_padding_top = parseInt(window.getComputedStyle(body).getPropertyValue('padding-top'), 10);
    appHeight()
}

const appHeight = () => {
    const vh = window.innerHeight - body_padding_top;
    document.documentElement.style.setProperty('--vh', `${vh}px`);
}

window.addEventListener('resize', appHeight)