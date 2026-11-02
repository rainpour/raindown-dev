---
title: Raindown Files
published: true
---

<{ :toc }>

Raindown is a superset of Markdown. Give a file the `.rd` or `.raindown` extension and a content directive on its own line no longer needs delimiters:

```
# Notes

:toc
```

## Bare directives

Bare directives write their output back into the file, and show in bold in the HTML. They have no end tags, so a bare block, like `toc:`, holds the Markdown straight below it, up to the next blank line:

```
toc:
- [Notes](#notes)
```

When its output needs blank lines, put it in HTML comments with an end tag instead, `<!-- toc: -->` and `<!-- :toc -->`, which works in `.md` and `.rd`, and hides it in the HTML.

Template directives, like `if:` and `for:`, are never bare, and always sit in `<{ }>`:

```
<{ if: draft }>
This is a draft.

It has two paragraphs.
<{ :if }>
```

Directives in prose or code are left as text.

## Markdown files

Markdown files can opt in to bare directives too, with `raindown: true` in their front matter:

```md
---
raindown: true
---

# Notes

:toc
```

Or, for every Markdown file Raindown reads, with the `--bare` flag:

```shell
raindown README.md --bare
```

## Syntax highlighting

The [VS Code extension](/docs/extensions) highlights bare directives in `.rd` files, and `<{ }>` directives in Markdown files. Its preview renders bare directives in Markdown files with `raindown: true`, but doesn't highlight them yet.
