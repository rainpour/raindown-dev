---
title: Table of Contents
menu: TOC
published: true
usecase: content
---

<{ :toc }>

`<{ :toc }>` renders a table of contents of the file's headings in the HTML, like the one on this page.

## Writing it into the file

A `toc:` block does that too, and also writes the table of contents into the Markdown below it as a list of links, updated whenever Raindown writes back to the file, so people and agents reading the file see it as well:

```
toc:
- [Notes](#notes)
  - [Setup](#setup)
```

Bare, in a [Raindown file](/docs/file-types) (`.rd`), a Markdown file with `raindown: true` front matter, or with `--bare`, it holds the list up to the next blank line. A `<{ toc: }>` block, in Deerheads, only renders into the HTML, like `<{ :toc }>`, and writes nothing.

## In comments

In HTML comments, with `<!-- :toc -->` after the list, it works in any Markdown file, and on GitHub only the list shows:

```md
<!-- toc: -->
- [Notes](#notes)
  - [Setup](#setup)
<!-- :toc -->
```

## Customising

`toc:` and `:toc` are a [node](/docs/components#overriding-core-nodes), so a project can change them with its own `TOC` node, like `class TOC < Raindown::TOC`.
