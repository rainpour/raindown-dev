// Shows one screen of the terminal UI at a time, the one whose tab is chosen, by a click or the arrow keys.
document.querySelectorAll('.terminal-tabs').forEach((tabs) => {
  const buttons = [...tabs.querySelectorAll('[role="tab"]')];

  const choose = (chosen) => {
    buttons.forEach((button) => {
      const selected = button === chosen;
      button.setAttribute('aria-selected', selected);
      button.tabIndex = selected ? 0 : -1;
      document.getElementById(button.getAttribute('aria-controls')).hidden = !selected;
    });
  };

  buttons.forEach((button, index) => {
    button.addEventListener('click', () => choose(button));
    button.addEventListener('keydown', (event) => {
      const step = { ArrowRight: 1, ArrowLeft: -1 }[event.key];
      if (!step) return;

      const next = buttons[(index + step + buttons.length) % buttons.length];
      choose(next);
      next.focus();
    });
  });

  choose(buttons[0]);
});
