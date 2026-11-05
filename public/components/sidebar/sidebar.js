const details = document.querySelectorAll('aside#sidebar details');
const detailsMinWidth = window.matchMedia('(min-width: 768px)');

function toggleSummary(e) {
  if (e.matches) {
    details.forEach((element) => {
      element.setAttribute('open', '');
    })
  } else {
    details.forEach((element) => {
      element.removeAttribute('open');
    })
  }
}

detailsMinWidth.addEventListener('change', toggleSummary);
toggleSummary(detailsMinWidth);

// Marks the links in the header and the sidebar to the page you're on, like Docs on Getting Started. Pages are files,
// like "cli.html", served at "/docs/cli", so both are the same page.
const currentPath = location.pathname.replace(/\.html$/, '').replace(/(.)\/$/, '$1');
document.querySelectorAll('#main-menu a, #docsnav a').forEach((link) => {
  if (new URL(link.href).pathname === currentPath) link.setAttribute('aria-current', 'page');
});
