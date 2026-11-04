// Shows one code block of a ".code-tabs" at a time, chosen by tabs named after their languages, like Ruby and JavaScript.
// Without JavaScript, every code block shows, one after the other.
const LANGUAGES = { ruby: 'Ruby', js: 'JavaScript', md: 'Markdown' };

document.querySelectorAll('.code-tabs').forEach((codeTabs) => {
  const blocks = [...codeTabs.querySelectorAll('pre')];
  const tablist = document.createElement('div');
  tablist.className = 'tabs';
  tablist.setAttribute('role', 'tablist');
  codeTabs.prepend(tablist);

  const buttons = blocks.map((block) => {
    const language = block.querySelector('code').className.replace('language-', '');
    const button = document.createElement('button');
    button.type = 'button';
    button.setAttribute('role', 'tab');
    button.textContent = LANGUAGES[language] || language;
    block.setAttribute('role', 'tabpanel');
    tablist.append(button);
    return button;
  });

  switchTabs(buttons, blocks);
});
