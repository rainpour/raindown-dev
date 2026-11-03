// Shows one panel at a time, the one whose tab is chosen, by a click or the arrow keys, starting with the first.
// Used by the terminal UI's screens and by code blocks in other languages, which load it first.
function switchTabs(buttons, panels) {
  const choose = (chosen) => {
    buttons.forEach((button, index) => {
      const selected = button === chosen;
      button.setAttribute('aria-selected', selected);
      button.tabIndex = selected ? 0 : -1;
      panels[index].hidden = !selected;
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
}
