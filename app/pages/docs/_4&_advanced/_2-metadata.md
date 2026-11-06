---
title: Metadata
published: true
---

<{ :toc }>

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

The `path` is relative to the project, so the links `list:` writes work in the Markdown, like on GitHub.

Files are listed by `order`, and separate several folder tags with `&`, like `docs/_1&_basics/getting-started.md`.

## Filtering

Filter by any of a file's tags. In `<{ }>`, quote their values, since unquoted ones are variables:

```md
list: folder: 'basics'

list: tags: 'intro'
```

## Listing

[List](/docs/list) lists the Markdown files in your project by their metadata. The project is the folder with your [`.raindown`](/docs/components) folder, or else the folder of the file being rendered.

## Wikilinks

Like in [Obsidian](https://obsidian.md), `[[Reading list]]` links to the file named `Reading list.md`, wherever it is in the project, whatever its case:

- **`[[Reading list#To read]]`** links to a heading.
- **`[[Reading list|books]]`** changes the text.
- **`[[notes/Reading list]]`** picks one of two files with the same name.

They render as links, by the file's path like `list:`, while the file keeps them as you wrote them, so Obsidian still reads it. Ones that name no file, embeds like `![[photo.png]]`, and ones in code are left as they are.
