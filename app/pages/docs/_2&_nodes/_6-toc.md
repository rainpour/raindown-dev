---
title: Table of Contents
menu: TOC
published: true
usecase: content
---

<{ :toc }>

`<{ :toc }>` renders a table of contents of the file's headings in the HTML, like the one on this page.

## Writing it into the file

A `<!-- toc: -->` block does that too, and also writes the table of contents into the Markdown below it as a list of links, updated whenever Raindown writes back to the file. That way people and agents reading the file see it as well, and on GitHub only the list shows:

```md
<!-- toc: -->
- [Notes](#notes)
  - [Setup](#setup)
<!-- :toc -->
```

The block needs `<!-- :toc -->` after it. A `<{ toc: }>` block, in Deerheads, only renders into the HTML, like `<{ :toc }>`, and writes nothing.

## In Raindown files

In a [Raindown file](/docs/file-types) it can be a bare `toc:` with the list straight below it, and `:toc` on its own is always the HTML table of contents:

```
toc:
- [Notes](#notes)
  - [Setup](#setup)
```

## Customising

`toc:` and `:toc` are a [node](/docs/components#overriding-core-nodes), so a project can change them with its own `TOC` node, like `class TOC < Raindown::TOC`.
