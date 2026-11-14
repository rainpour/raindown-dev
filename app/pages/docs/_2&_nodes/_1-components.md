---
title: Components
published: true
raindown: true
---

toc:
- [Custom Components](#custom-components)
  - [Ruby](#ruby)
    - [Overriding Core Nodes](#overriding-core-nodes)
  - [JavaScript](#javascript)
  - [Markdown](#markdown)
- [Props](#props)
- [Lifecycle](#lifecycle)
- [Performance](#performance)

> [!NOTE]
> A node is how it's built and a component is how it's rendered. They are data and logic that you want to include from another place into your page. Nodes that start with a capital letter like `Changelog:` are always components.

Components are your own directives, written in Ruby, JavaScript or plain Markdown, that write Markdown into the file with `rewrite`, and render HTML into the page with `render`.

How you write one says which it does. Bare or in comments, like `Changelog:` or `<!-- Changelog: -->`, it writes back: its `rewrite` writes into the file. In Deerheads, like `<{ Changelog: }>` … `<{ :Changelog }>` or a self-closing `<{ Changelog }>`, it's write-in: only its `render` is called, which gets the Markdown between its tags as `slot:`, and nothing is written into the file. A component with only `render`, like a `Layout`, can only be write-in, and one with only `rewrite` raises in Deerheads.

What a component writes back is Raindown's, and it's written again from its source each time the file is rendered. A component can take edits to it, like [`table:`](/docs/table) writing them to its CSV file, when its `rewrite` takes `written:`, the lines it wrote last time, to see what changed. It then needs its own `render` to be write-in, so rendering a page never writes to its source.

Put them in a `.raindown` folder beside your files, or in a folder above them, and Raindown loads them automatically.

## Custom Components

### Ruby

Ruby components inherit from [LowNode](https://github.com/low-rb/lownode):

```ruby
# .raindown/changelog.rb
class Changelog < LowNode
  def initialize(limit: 5)
    @releases = Release.all.first(limit)
  end

  # Written into the Markdown.
  def rewrite
    @releases.map { |release| "- **#{release.version}** #{release.summary}" }.join("\n")
  end

  # Rendered into the HTML, and all that renders in Deerheads. Without it, the HTML of the Markdown above is rendered.
  def render
    "<section class=\"changelog\">...</section>"
  end
end
```

`rewrite` and `render` can also take the keywords `document:` (the Markdown being rendered), `metadata:` and `bare:`, and get the ones they ask for. `render` can also take `slot:`, the HTML of the Markdown between its tags in Deerheads.

#### Overriding Core Nodes

[Table of contents](/docs/toc), [lists](/docs/list), [charts](/docs/chart) and [tables](/docs/table) are nodes too, and a project can replace them with its own Ruby `TOC`, `Files`, `Chart` or `Table` node, like `class Chart < Raindown::Chart`. Endpoints and schemas can't be replaced.

### JavaScript

A JavaScript component is a `.js` or `.mjs` file in the same `.raindown` folder that exports a class with `rewrite`, and optionally `render`:

```js
// .raindown/changelog.mjs
import { Release } from "../lib/release.mjs"

export class Changelog {
  constructor({ limit = 5 }) {
    this.releases = Release.all().slice(0, limit)
  }

  // Written into the Markdown. Can be async.
  rewrite({ document, metadata, bare }) {
    return this.releases.map((release) => `- **${release.version}** ${release.summary}`).join("\n")
  }

  // Rendered into the HTML, and all that renders in Deerheads. Without it, the HTML of the Markdown above is rendered.
  render({ html }) {
    return `<section class="changelog">...</section>`
  }
}
```

It's used like any component, like `Changelog: limit=3`. Its props come first in the constructor, then the value before them, if any. Its methods get the context as one object, where `metadata` is `{ root, files }`, with each file's front matter and path but not its content.

- A Ruby component of the same name is used instead.
- JavaScript components need [Node.js](https://nodejs.org) 22 or later on your `PATH`, which runs them in one process of their own, and only projects that have them need it.
- What they log goes to stderr.
- They can't subclass Raindown's own nodes, like `Chart`, so they can't replace `toc:`, `list:`, `chart:` or `table:`.

### Markdown

A Markdown file in `.raindown` named like a component, like `BookCard.md` or `BookCard.rd`, is a component with no code. Its props are its variables, and its front matter is their defaults:

`````md
---
rating: 0
---

**{title}** · {rating}/5
`````

Then `BookCard: title: The Dispossessed rating: 5` writes `**The Dispossessed** · 5/5` below it.

- A value before the props, like `'Dune'` in `BookCard: 'Dune'`, is `{value}`.
- [Control flow](/docs/control-flow), like `<{ if: }>` and `<{ for: }>`, works in it.
- Raindown reads the file each time it writes the component, so a change shows on the next render.
- A Ruby or JavaScript component of the same name is used instead.

## Props

Props can be quoted text, numbers, `true`, `false` or [variables](/docs/variables) like `author.name`, written `limit=3` or `limit: 3`. Bare or in comments, a word is text, like `folder: notes`, and a variable is in braces, like `{author.name}`, while in `<{ }>` a word is a variable. Like YAML, unquoted text after `name:` runs up to the next prop, so `title: Hello world limit: 3` has two, while after `name=` it's one word. Quote text with a word and colon inside, like `title: 'Read this: now'`, and words that read as values, like `'1.10'` or `'true'`. Quoted text means the same in every way a directive's written. A variable is the data it holds, so a list stays a list.

A value before the props, like `'data.csv'` in `chart: 'data.csv' format: 'columns'`, is passed to the component's `initialize`, or its constructor, as its argument.

## Lifecycle

Raindown keeps one instance of each component and its props while it runs, so `rewrite` and `render` can share what they work out, like the releases above.

A name only starts a component block when it's a loaded component with a `rewrite` method, so other text like `Note:` is left alone.

> [!WARNING]
> Components run your project's code whenever Raindown writes back to or renders the file.

## Performance

Components can be written in either Ruby or JavaScript for any feature, but one will be faster at a particular task. Hover over a language to see by how much:

<div class="performance">

| | CLI | Desktop app | Obsidian plugin |
| --- | --- | --- | --- |
| **Processing** | <span class="langs"><span class="lang" data-tooltip="1.25× faster than Ruby"><img src="/assets/javascript.svg" alt="JS"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="80% as fast as JS, or 3× as fast with while loops"><img src="/assets/ruby.svg" alt="Ruby"></span></span> | <span class="langs"><span class="lang" data-tooltip="12× faster than Ruby"><img src="/assets/javascript.svg" alt="JS"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="9% as fast as JS, or 34% with while loops"><img src="/assets/ruby.svg" alt="Ruby"></span></span> | <span class="langs"><span class="lang" data-tooltip="33× faster than Ruby"><img src="/assets/javascript.svg" alt="JS"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="3% as fast as JS (Ruby runs in WebAssembly)"><img src="/assets/ruby.svg" alt="Ruby"></span></span> |
| **Write-back** | <span class="langs"><span class="lang" data-tooltip="1.6× faster than JS"><img src="/assets/ruby.svg" alt="Ruby"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="64% as fast as Ruby"><img src="/assets/javascript.svg" alt="JS"></span></span> | <span class="langs"><span class="lang" data-tooltip="1.8× faster than JS"><img src="/assets/ruby.svg" alt="Ruby"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="57% as fast as Ruby"><img src="/assets/javascript.svg" alt="JS"></span></span> | <span class="langs tie"><span class="lang" data-tooltip="As fast as Ruby, within 4%"><img src="/assets/javascript.svg" alt="JS"></span><span class="equals" aria-label="as fast as">=</span><span class="lang" data-tooltip="As fast as JS, within 4%"><img src="/assets/ruby.svg" alt="Ruby"></span></span> |
| **Rendering** | <span class="langs"><span class="lang" data-tooltip="1.06× faster than JS"><img src="/assets/ruby.svg" alt="Ruby"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="94% as fast as Ruby"><img src="/assets/javascript.svg" alt="JS"></span></span> | - | <span class="langs"><span class="lang" data-tooltip="1.3× faster than JS"><img src="/assets/ruby.svg" alt="Ruby"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="78% as fast as Ruby"><img src="/assets/javascript.svg" alt="JS"></span></span> |
| **Rasterizing** | - | <span class="langs"><span class="lang" data-tooltip="Fastest: paints in the page, every frame if asked"><img src="/assets/javascript.svg" alt="JS"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="Each paint is a trip to Ruby and back, about every quarter second for a full-width area"><img src="/assets/ruby.svg" alt="Ruby"></span></span> | - |
| **Animation** | - | <span class="langs"><span class="lang" data-tooltip="Fastest: up to 60 frames a second"><img src="/assets/javascript.svg" alt="JS"> <span class="medal" aria-label="1st place">🥇</span></span><span class="lang" data-tooltip="About 4 frames a second for a full-width area"><img src="/assets/ruby.svg" alt="Ruby"></span></span> | - |

</div>

Times are for a note with 10 components, the middle of 10 runs. The desktop app shows Markdown rather than rendering HTML, so it has no rendering.

Choose the language that's fastest at the main task on the main platform your component is for. Each language can still do everything, and the gap is often small:
- Write-back and rendering take under 7 ms for 10 components in either language, everywhere.
- Processing, like counting and parsing in loops, is where the gap is big: JavaScript runs on V8 in the desktop app and Obsidian, while Ruby runs in WebAssembly in Obsidian.
- Ruby can still animate in the desktop app, just a few frames a second.

**Ruby:** Best at write-back and rendering in the CLI and desktop app
**JavaScript:** Best at processing and animation
