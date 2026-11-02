# frozen_string_literal: true

class Layout < LowNode
  DESCRIPTION = 'Markdown that keeps itself up to date, so your docs, READMEs and agent files never go stale.'

  # The 404 page has no path so it isn't given a canonical URL.
  def initialize(path: nil)
    @description = DESCRIPTION
    @url = "https://raindown.dev#{path}" if path
  end

  def render(event:, section:, title:)
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="description" content="{@description}">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@2.1.1/css/pico.min.css">
        <link rel="stylesheet" href="/style.css">
        <link rel="stylesheet" href="/components/home.css">
        <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>🌧️</text></svg>">

        <!-- TODO: Precompile. -->
        <link rel="stylesheet" href="/components/alerts.css">
        <link rel="stylesheet" href="/components/cards.css">
        <link rel="stylesheet" href="/components/footer.css">
        <link rel="stylesheet" href="/components/sidebar/sidebar.css">
        <script src="/components/sidebar/sidebar.js" defer></script>
        <link rel="stylesheet" href="/components/toc/toc.css">
        <script src="/components/toc/toc.js" defer></script>
        <script src="/components/backdrop/backdrop.js" defer></script>

        <!-- Code is highlighted in the browser, since Raindown leaves it unhighlighted (see .raindown/config.yml). -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/themes/prism-tomorrow.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/line-numbers/prism-line-numbers.min.css">
        <link rel="stylesheet" href="/components/syntax/syntax.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/prism.min.js" data-manual defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/components/prism-markdown.min.js" defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/line-numbers/prism-line-numbers.min.js" defer></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/prism/1.29.0/plugins/autoloader/prism-autoloader.min.js" defer></script>
        <script src="/components/syntax/syntax.js" defer></script>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=DM+Mono:ital,wght@0,300;0,400;0,500;1,300;1,400;1,500&family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.2/font/bootstrap-icons.css" rel="stylesheet">

        <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">

        <meta property="og:image" content="https://raindown.dev/assets/cover.jpg" />
        <meta property="og:title" content="Raindown - {title}" />
        <meta property="og:description" content="{@description}" />
        <{ if: @url }>
          <link rel="canonical" href="{@url}">
          <meta property="og:url" content="{@url}" />
        <{ :if }>
        <meta property="og:type" content="website" />
        <title>{"Raindown"} - {title}</title>
      </head>
      <body class="{section}">
        <div id="background"><canvas class="backdrop" aria-hidden="true"></canvas></div>

        <header>
          <div class="container">
            <a id="logo" href="/">{"Raindown"}</a>
            <nav id="main-menu">
              <ul>
                <li><a href="/docs/getting-started"><i class="bi bi-book"></i>{"Docs"}</a></li>
                <li><a href="https://github.com/rainpour/raindown"><i class="bi bi-github"></i> {"Source"}</a></li>
              </ul>
            </nav>
          </div>
        </header>
        
        <main class="container">
          <{ :slot }>
        </main>

        <footer>
          <div class="container">
            <ul>
              <li><a href="/docs/getting-started"><i class="bi bi-download"></i>{"Downloads"}</a></li>
              <li><a href="https://github.com/rainpour/raindown"><i class="bi bi-github"></i>{"GitHub"}</a></li>
            </ul>
          </div>
        </footer>
      </body>
    </html>
  end
end
