---
title: List
published: true
usecase: content
---

`list:` lists the Markdown files in your project by their [metadata](/docs/metadata), like a folder or a tag, and they can be [filtered](/docs/metadata#filtering) by any of their tags. Bare or in comments, it writes a link to each file, by its title, into the Markdown, and renders them as a list in the HTML:

```
list: folder: 'notes'
- [Getting started](docs/_notes/_1-getting-started.md)
- [Setup](docs/_notes/_2-setup.md)
```

`<{ :list folder: 'notes' }>` renders the same links, writing nothing into the file.

## Your own template

To render the files with your own template, name each file before the props, like `page`, in a `<{ list: }>` block. Its template repeats for each file, and only renders in the HTML:

```md
<{ list: page folder: 'notes' }>
## {page.title}
<{ :list }>
```

For example, this list of the node pages is a `list:` block:

<{ list: page folder: 'nodes' }>
- [{page.title}]({page.path})
<{ :list }>

## Sorting

Files are listed by their `order`, from their [metadata](/docs/metadata), or by any other metadata with `order:`, like `<{ list: page folder: 'notes' order: :created_at }>`, with files without it last.

## Overriding

`list:` is a [node](/docs/components#overriding-core-nodes) too, so a project can list files its own way with a `List` node that overrides `rewrite` or adds `render`, like `class List < Raindown::List`, where `files(metadata:)` gives each file's front matter, `path` and `content`, for its links and its template.
