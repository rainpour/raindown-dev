// Puts the command for the visitor's computer first, for code-tabs to start on, and adds a Copy button to each. It
// loads before code-tabs, and starts on macOS when it can't tell. Without JavaScript, every command shows.
const SYSTEMS = { Windows: 'windows', Linux: 'linux', X11: 'linux', CrOS: 'linux' };
const visitorSystem = Object.keys(SYSTEMS).find((name) => navigator.userAgent.includes(name));

document.querySelectorAll('.install-command').forEach((command) => {
  const tabs = command.querySelector('.code-tabs');
  const mine = tabs.querySelector(`pre[data-system="${SYSTEMS[visitorSystem]}"]`);
  if (mine) tabs.querySelector('pre[data-system]').before(mine);

  tabs.querySelectorAll('pre[data-system]').forEach((block) => {
    const button = document.createElement('button');
    button.type = 'button';
    button.className = 'install-copy';
    button.textContent = 'Copy';
    button.addEventListener('click', async () => {
      await navigator.clipboard.writeText(block.querySelector('code').textContent.trim());
      button.textContent = 'Copied';
    });
    block.append(button);
  });
});
