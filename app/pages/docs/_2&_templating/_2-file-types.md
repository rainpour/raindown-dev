---
title: File Types
published: true
---

<{ :toc }>

Raindown is a superset of Markdown. Give a file the `.rd` or `.raindown` extension and a content directive on its own line no longer needs delimiters:

```
# Notes

:toc
```

Bare directives, like ones in comments, read like prose, so an unquoted word is text, like `files: folder: notes`, and only a word in braces is a variable, like `chart: {stats}`.

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
