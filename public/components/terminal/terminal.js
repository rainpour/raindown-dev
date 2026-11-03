// Shows one screen of the terminal UI at a time, the one whose tab is chosen.
document.querySelectorAll('.terminal-tabs').forEach((tabs) => {
  switchTabs([...tabs.querySelectorAll('[role="tab"]')], [...tabs.querySelectorAll('[role="tabpanel"]')]);
});
