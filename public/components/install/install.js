// Puts the commands for the visitor's computer first, and adds a Copy button to each. Without JavaScript, both show.
const systems = document.querySelector('.install-systems');

if (systems) {
  const mine = /Windows/.test(navigator.userAgent) ? 'windows' : 'unix';
  systems.prepend(systems.querySelector(`[data-system="${mine}"]`));

  systems.querySelectorAll('pre').forEach((block) => {
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'install-copy';
    button.textContent = 'Copy';
    button.addEventListener('click', async () => {
      await navigator.clipboard.writeText(block.textContent.trim());
      button.textContent = 'Copied';
    });
    block.after(button);
  });
}
