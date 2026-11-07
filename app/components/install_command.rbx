# frozen_string_literal: true

# The command that installs Raindown, on tabs for each system, starting on the visitor's, with a button to copy it.
# Use it once on a page, like <{ InstallCommand }>. It loads what it needs, so a page needs nothing else. Its slot goes
# below the tabs, and what's in a <div data-for="macos">, "linux" or "windows" shows with that system's tab.
class InstallCommand < LowNode
  UNIX = 'curl -fsSL https://raindown.dev/install.sh | sh'
  WINDOWS = 'irm https://raindown.dev/install.ps1 | iex'

  def initialize
    @unix = UNIX
    @windows = WINDOWS
  end

  def render
    <div class="install-command">
      <link rel="stylesheet" href="/components/code-tabs/code-tabs.css">
      <link rel="stylesheet" href="/components/install-command/install-command.css">
      <script src="/components/tabs/tabs.js" defer></script>
      <script src="/components/install-command/install-command.js" defer></script>
      <script src="/components/code-tabs/code-tabs.js" defer></script>

      <div class="code-tabs">
        <{ :slot }>

        <pre data-system="macos" data-label="macOS"><code class="language-sh">{@unix}</code></pre>
        <pre data-system="linux" data-label="Linux"><code class="language-sh">{@unix}</code></pre>
        <pre data-system="windows" data-label="Windows"><code class="language-powershell">{@windows}</code></pre>
      </div>
    </div>
  end
end
