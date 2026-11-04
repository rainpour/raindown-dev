---
title: Metadata
published: true
---

<{ :toc }>

[Files and lists](/docs/files-and-lists) list the Markdown files in your project by their metadata. The project is the folder with your [`.raindown`](/docs/components) folder, or else the folder of the file being rendered.

## Front matter

A file's front matter is its metadata, and a list like `tags: [ruby, intro]` tags it with each item:

```md
---
title: Getting started
tags: [ruby, intro]
---
```

## Folder tags

**The humble underscore:** Underscored folders in a file's path are metadata too. `docs/_basics/_1-getting-started.md` has:

```yaml
folder: basics
order: 1
path: docs/_basics/_1-getting-started.md
```

The `path` is relative to the project, so the links `files:` writes work in the Markdown, like on GitHub.

Files are listed by `order`, and separate several folder tags with `&`, like `docs/_1&_basics/getting-started.md`.

> [!TIP]
> This site's pages live in folders like `docs/_1&_basics`, which puts them in order and in their sidebar group.

## Filtering

Filter by any of a file's tags, with quoted values, since unquoted ones are front matter keys:

```md
files: folder: 'basics'

files: tags: 'intro'
```

## Files

A `files:` block writes a link to each file in a folder, by its title, into the Markdown, and renders them as a list in the HTML:

```md
<!-- files: folder: 'notes' -->
- [Getting started](docs/_notes/_1-getting-started.md)
- [Setup](docs/_notes/_2-setup.md)
<!-- :files -->
```

The files come from the [metadata](/docs/metadata) of your project's Markdown files.

`files:` is a [node](/docs/components#built-in-nodes) too, so a project can list files its own way with a `Files` node that overrides `replace` or adds `render`, like `class Files < Raindown::Files`, where `files(metadata:)` gives each file's front matter, `path` and `content`.

## Lists

To render the files with your own template instead, use a `list:` block. Its template repeats for each file, and only renders in the HTML:

```md
<{ list: page folder: 'notes' }>
## {page.title}
<{ :list }>
```

For example, this list of the templating pages is a `list:` block:

<{ list: page folder: 'templating' }>
- [{page.title}]({page.path})
<{ :list }>

## Wikilinks

Like in [Obsidian](https://obsidian.md), `[[Reading list]]` links to the file named `Reading list.md`, wherever it is in the project, whatever its case:

- **`[[Reading list#To read]]`** links to a heading.
- **`[[Reading list|books]]`** changes the text.
- **`[[notes/Reading list]]`** picks one of two files with the same name.

They render as links, by the file's path like `files:`, while the file keeps them as you wrote them, so Obsidian still reads it. Ones that name no file, embeds like `![[photo.png]]`, and ones in code are left as they are.
