# frozen_string_literal: true

class HomeNode < LowNode
  observe '/'

  def initialize(event:)
    @title = 'A Markdown superset for AI, APIs, Docs... and humans'
    @cards = Raindeer.pages.list(folder: 'cards')
    @cloud = RainCloud.new.html
    @examples = Examples.all
    @alternatives = Examples.all(Examples::ALTERNATIVES)
    @syntax = Examples.syntax
    @screens = Screens.all
  end

  def render(event:)
    <{ Layout: title=@title section='section-home' path='/' }>
      <div id="raindown" role="img" aria-label="Raindown">
        <{ @cloud }>
      </div>

      <div id="overview">
        <p>
          {"A Markdown superset for AI, APIs, Docs... and humans."}
          {"Markdown that keeps itself up to date, so your docs, READMEs and agent files never go stale."}
        </p>
        <p><strong>{"Stay sane out there."}</strong></p>

        <span class="actions">
          <a href="/docs/getting-started" role="button"><i class="bi bi-download"></i>{"Getting Started"}</a>
        </span>

        <{ Version }>
      </div>

      <div id="cards" class="grid">
        <{ for: card in: @cards }>
          <{ Card card=card }>
        <{ :for }>
      </div>

      <section id="examples">
        <h2>{"Examples"}</h2>

        <p class="lead">
          {"Use Raindown in Markdown with"} <code>raindown: true</code> {"front matter."}<br />
          {"Or rename the file to use the"} <code>.rd</code> {"file extension."}
        </p>

        <div class="pages">
          <{ for: example in: @examples }>
            <{ ExamplePage example=example }>
          <{ :for }>
        </div>

        <h2>{"Alternate Syntax"}</h2>

        <p class="lead">
          {"Wrap directives in HTML comments to hide them."}<br />
          {"Or use Deerheads to only output to HTML (no write-back)."}
        </p>

        <div class="pages">
          <{ for: example in: @alternatives }>
            <{ ExamplePage example=example }>
          <{ :for }>
        </div>

        <div class="syntax">
          <{ @syntax }>
        </div>
      </section>

      <section id="terminal">
        <h2>{"Terminal UI"}</h2>

        <p class="lead">
          {"Run"} <code>raindown</code> {"to browse a project, and watch it write back as you save."}
        </p>

        <{ TerminalTabs screens=@screens }>
      </section>

      <section id="objective">
        <p class="kicker"><i class="bi bi-incognito"></i>{"Secret objective"}</p>
        <p>{"To make programming fun again... AI is here but we can write the guard rails and specs and schemas and get to code again... okay it's a templating language but we're so close! The tapping of the keys, the joy of syntax, the connections between files, it's all there, maybe we can live again?"}</p>
      </section>

      <link rel="stylesheet" href="/components/examples/examples.css">
      <link rel="stylesheet" href="/components/terminal/terminal.css">
      <script src="/components/terminal/terminal.js" defer></script>
    <{ :Layout }>
  end
end
