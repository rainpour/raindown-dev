# frozen_string_literal: true

# Screenshots of the terminal UI, one at a time, chosen by tabs named after them, like Dashboard.
# Without JavaScript, every screenshot shows, one after the other.
class TerminalTabs < LowNode
  def render(event:, screens:)
    <div class="terminal-tabs">
      <div class="tabs" role="tablist" aria-label="Terminal UI screens">
        <{ for: screen in: screens }>
          <button type="button" role="tab" id="tab-{screen.name}" aria-controls="screen-{screen.name}">{screen.label}</button>
        <{ :for }>
      </div>

      <{ for: screen in: screens }>
        <figure class="screen" role="tabpanel" id="screen-{screen.name}" aria-labelledby="tab-{screen.name}">
          <img src="/screens/{screen.name}.png" loading="lazy" alt="Raindown's terminal UI: {screen.caption}">
          <figcaption>{screen.caption}</figcaption>
        </figure>
      <{ :for }>
    </div>
  end
end
