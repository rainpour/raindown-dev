---
title: List
published: true
---

<{ :toc }>

`list:` lists the Markdown files in your project by their [metadata](/docs/metadata), like a folder or a tag, and they can be [filtered](/docs/metadata#filtering) by any of their tags.

## Content

<{ UseCase use_case='content' }>

```
list: folder: 'notes'
- [Getting started](docs/_notes/_1-getting-started.md)
- [Setup](docs/_notes/_2-setup.md)
```

## Template

<{ UseCase use_case='template' }>

A `<{ list: }>` block's template repeats like a loop, for each file it lists.

`<{ :list folder: 'nodes' }>` renders the same links as the *Content* example, but writes nothing into the file.

To render the files with your own template, add a variable like `page` after `list:`

```md
<{ list: page folder: 'nodes' }>
- [{page.title}]({page.path})
<{ :list }>
```

Which when used on this website produces:

<{ list: page folder: 'nodes' }>
- [{page.title}]({page.path})
<{ :list }>

## Sorting

Sort lists by their [metadata](/docs/metadata) with `order:`

```md
<{ list: page folder: 'nodes' order: :title }>
- [{page.title}]({page.path})
<{ :list }>
```

Which when used on this website produces:

<{ list: page folder: 'nodes' order: :title }>
- [{page.title}]({page.path})
<{ :list }>

## Overriding

`list:` is a [node](/docs/components#overriding-core-nodes) too, so a project can list files its own way with a `List` node that overrides `rewrite` or adds `render`, like `class List < Raindown::List`, where `files(metadata:)` gives each file's front matter, `path` and `content`, for its links and its template.
