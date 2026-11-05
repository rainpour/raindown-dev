---
title: Files
published: true
usecase: content
---

A `files:` block writes a link to each file in a folder, by its title, into the Markdown, and renders them as a list in the HTML:

```md
<!-- files: folder: 'notes' -->
- [Getting started](docs/_notes/_1-getting-started.md)
- [Setup](docs/_notes/_2-setup.md)
<!-- :files -->
```

The files come from the [metadata](/docs/metadata) of your project's Markdown files, and can be [filtered](/docs/metadata#filtering) by any of their tags.

`files:` is a [node](/docs/components#built-in-nodes) too, so a project can list files its own way with a `Files` node that overrides `replace` or adds `render`, like `class Files < Raindown::Files`, where `files(metadata:)` gives each file's front matter, `path` and `content`.
