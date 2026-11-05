---
title: Obsidian
published: true
---

<{ :toc }>

The [Obsidian plugin](https://github.com/rainpour/raindown-obsidian) writes back to your notes as you save them.

## Features

### Metadata

A note's properties are its [metadata](/docs/metadata), so `tags: [book, reading]` tags it with each item, and a vault's underscored folders, like `_1-inbox`, give its notes a folder and an order.

### Files and lists

[`files:`](/docs/files) writes a link to each note with a tag or in a folder, like `files: tags: 'book'`, and stays up to date as notes are added, renamed or removed. A [`list:`](/docs/list) block renders them with your own template in reading view.

### Tables

[`table:`](/docs/table) writes a CSV or TSV file in your vault into the note as a table. Edit a cell in the note and it's written back to the file, and changing the file updates the table.

### Charts

[`chart:`](/docs/chart) draws a CSV, TSV, JSON or YAML file in your vault, like reading progress or habits, as bars, columns, a line or a sparkline in block characters, written into the note as a code block.

### Table of contents

[`toc:`](/docs/toc) writes a linked list of the note's headings, which updates as you add and rename them.

### Components

A note in your vault's `.raindown` folder, like `BookCard.md`, is a [component](/docs/components#markdown) with no code, a template whose properties fill its `{variables}`, like `BookCard: title: Dune rating: 5`.

## Install

The plugin isn't in Obsidian's community plugins yet. Copy `main.js`, `manifest.json` and `styles.css` from the [source](https://github.com/rainpour/raindown-obsidian) into your vault's `.obsidian/plugins/raindown/` folder, then turn on **Raindown** in **Settings → Community plugins**.

## Settings

- **Raindown: Write back this note** - Writes back now, and says what happened
- **Raindown: Run the endpoints in this note** - Runs the [endpoints](/docs/endpoint) without a response. Endpoints never run on save
- **Raindown: Write back all notes** - Writes back every note with directives
- **Raindown: Download Raindown** - Downloads the latest standalone binary, or updates it
