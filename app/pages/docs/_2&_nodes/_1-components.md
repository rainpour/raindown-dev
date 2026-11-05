---
title: Components
published: true
---

<{ :toc }>

> [!NOTE]
> A node is how it's built and a component is how it's rendered. They are data and logic that you want to include from another place into your page. Nodes that start with a capital letter like `Changelog:` are always components.

Components are your own directives, written in Ruby, JavaScript or plain Markdown, that write Markdown into the file with `replace`, and render HTML into the page with `render`.

How you write one says which it does. Bare or in comments, like `Changelog:` or `<!-- Changelog: -->`, it writes back: its `replace` writes into the file. In Deerheads, like `<{ Changelog: }>` … `<{ :Changelog }>` or `<{ :Changelog }>`, it's written in: only its `render` is called, which gets the Markdown between its tags as `slot:`, and nothing is written into the file. A component with only `render`, like a `Layout`, can only be written in, and one with only `replace` raises in Deerheads.

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
  def replace
    @releases.map { |release| "- **#{release.version}** #{release.summary}" }.join("\n")
  end

  # Rendered into the HTML, and all that renders in Deerheads. Without it, the HTML of the Markdown above is rendered.
  def render
    "<section class=\"changelog\">...</section>"
  end
end
```

`replace` and `render` can also take the keywords `document:` (the Markdown being rendered), `metadata:` and `bare:`, and get the ones they ask for. `render` can also take `slot:`, the HTML of the Markdown between its tags in Deerheads.

#### Overriding Core Nodes

[Table of contents](/docs/toc), [files](/docs/files), [charts](/docs/chart) and [tables](/docs/table) are nodes too, and a project can replace them with its own Ruby `TOC`, `Files`, `Chart` or `Table` node, like `class Chart < Raindown::Chart`. Endpoints and schemas can't be replaced.

### JavaScript

A JavaScript component is a `.js` or `.mjs` file in the same `.raindown` folder that exports a class with `replace`, and optionally `render`:

```js
// .raindown/changelog.mjs
import { Release } from "../lib/release.mjs"

export class Changelog {
  constructor({ limit = 5 }) {
    this.releases = Release.all().slice(0, limit)
  }

  // Written into the Markdown. Can be async.
  replace({ document, metadata, bare }) {
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
- They can't subclass Raindown's own nodes, like `Chart`, so they can't replace `toc:`, `files:`, `chart:` or `table:`.

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

Raindown keeps one instance of each component and its props while it runs, so `replace` and `render` can share what they work out, like the releases above.

A name only starts a component block when it's a loaded component with a `replace` method, so other text like `Note:` is left alone.

> [!WARNING]
> Components run your project's code whenever Raindown writes back to or renders the file.
