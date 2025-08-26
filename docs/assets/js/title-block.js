
function headerOffset() {
// Set an offset if there is are fixed top navbar
const headerEl = window.document.querySelector("header.fixed-top");
if (headerEl) {
    return headerEl.clientHeight;
} else {
    return 0;
}
}

function footerOffset() {
const footerEl = window.document.querySelector("footer.footer");
if (footerEl) {
    return footerEl.clientHeight;
} else {
    return 0;
}
}

function dashboardOffset() {
const dashboardNavEl = window.document.getElementById(
    "quarto-dashboard-header"
);
if (dashboardNavEl !== null) {
    return dashboardNavEl.clientHeight;
} else {
    return 0;
}
}

window.onload = function get_body() {
    appHeight()
}

const appHeight = () => {
    var bodyOffset = headerOffset() + footerOffset() + dashboardOffset();
    const vh = window.innerHeight - bodyOffset; 
    document.documentElement.style.setProperty('--vh', `${vh}px`);
}

window.addEventListener('resize', appHeight)
