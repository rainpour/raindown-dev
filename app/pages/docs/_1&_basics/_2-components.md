---
title: Components
published: true
---

<{ :toc }>

> [!NOTE]
> A node is how a directive is built and a component is how it's rendered. Nodes that start with a capital letter, like `Changelog:`, are components. Nodes like `if:` are templating.

Components are your own directives, written in Ruby or JavaScript, that write Markdown into the file with `replace`, and render HTML into the page with `render`.

Put them in a `.raindown` folder beside your files, or in a folder above them, and Raindown loads them automatically.

## Ruby components

Ruby components are [LowNodes](https://github.com/low-rb/lownode), loaded with [Dirload](https://github.com/low-rb/dirload):

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

  # Rendered into the HTML. Without it, the HTML of the Markdown above is rendered.
  def render
    "<section class=\"changelog\">...</section>"
  end
end
```

`replace` and `render` can also take the keywords `document:` (the Markdown being rendered), `metadata:` and `bare:`, and get the ones they ask for.

## JavaScript components

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

  // Rendered into the HTML. Without it, the HTML of the Markdown above is rendered.
  render({ html }) {
    return `<section class="changelog">...</section>`
  }
}
```

It's used like any component, like `<!-- Changelog: limit=3 -->`. Its props come first in the constructor, then the value before them, if any. Its methods get the context as one object, where `metadata` is `{ root, files }`, with each file's front matter and path but not its content.

- A Ruby component of the same name is used instead.
- JavaScript components need [Node.js](https://nodejs.org) 22 or later on your `PATH`, which runs them in one process of their own, and only projects that have them need it.
- What they log goes to stderr.
- They can't subclass Raindown's own nodes, like `Chart`, so they can't replace `toc:`, `files:` or `chart:`.

## Component blocks

A component block names the component and its props, and Raindown writes the component's Markdown into it whenever the file is rendered:

```md
<!-- Changelog: limit=3 -->
- **1.2.0** Bare directives close themselves
- **1.1.0** Track fetched dates
<!-- :Changelog -->
```

In a [Raindown file](/docs/raindown-files) it can also use bare syntax, with the Markdown straight below it up to the next blank line (a bare block can't write blank lines):

```
Changelog: limit=3
- **1.2.0** Bare directives close themselves
- **1.1.0** Track fetched dates
```

A self-closing `<{ :Changelog }>`, or a bare `:Changelog`, renders the component into the HTML without writing it into the file, as does a `<{ Changelog: }>` block.

## Props

Props can be quoted text, numbers, `true`, `false` or [variables](/docs/variables) like `author.name`, written `limit=3` or `limit: 3`. A variable is the data it holds, so a list stays a list.

A value before the props, like `'data.csv'` in `chart: 'data.csv' format: 'columns'`, is passed to the component's `initialize`, or its constructor, as its argument.

## Lifecycle

Raindown keeps one instance of each component and its props while it runs, so `replace` and `render` can share what they work out, like the releases above.

A name only starts a component block when it's a loaded component with a `replace` method, so other text like `Note:` is left alone.

> [!WARNING]
> Components run your project's code whenever Raindown writes back to or renders the file.

## Built-in nodes

[Table of contents](/docs/table-of-contents) and [files](/docs/files-and-lists) are nodes too, and a project can replace them with its own Ruby `TOC` or `Files` node.
