---
title: Obsidian
published: true
---

<{ :toc }>

The [Obsidian plugin](https://github.com/rainpour/raindown-obsidian) writes back to your notes as you save them, like `raindown watch`: tables of contents, file lists, [components](/docs/components) and charts. What it writes is plain Markdown in the note, so it reads the same on GitHub, on your phone and in any other editor.

Once you stop typing, it gives the note to the [editor server](/docs/cli#editor-server), or `raindown NOTE --stdin --rewrite` with a Raindown from before it, which answers with the note as Raindown would write it back, and applies that only if the note hasn't changed since, so nothing you type is lost. Errors, like a directive that's half typed, show in the status bar, and directives are highlighted as you type. Bare directives, like `toc:`, need `raindown: true` in a note's front matter, unless the plugin's **Bare directives in every note** setting is on.

- **Raindown: Write back this note** writes back now, and says what happened.
- **Raindown: Run the endpoints in this note** runs the [endpoints](/docs/endpoint) without a response. Endpoints never run on save.
- **Raindown: Write back all notes** writes back every note with directives.
- **Raindown: Download Raindown** downloads the latest standalone binary, or updates it.

Adding, renaming or removing a note writes back the notes with lists, like `files:`, so they don't go stale. In the editor, directive names complete after `<!--` or `<{`, from Raindown's own and your project's nodes, and the line of an error is underlined. Reading view shows `<{ }>` directives as Raindown renders them.

## Install

The plugin isn't in Obsidian's community plugins yet. Copy `main.js`, `manifest.json` and `styles.css` from the [source](https://github.com/rainpour/raindown-obsidian) into your vault's `.obsidian/plugins/raindown/` folder, then turn on **Raindown** in **Settings → Community plugins**.

## Requirements

The `raindown` executable. The first time the plugin can't find it, it looks on your shell's `PATH`, which Obsidian opened from the Dock doesn't have, and if it's not there either, offers to download the [standalone binary](/docs/cli#installation) from GitHub, checked against the release's checksums, to `~/.local/bin/raindown`, or `%LOCALAPPDATA%\Programs\raindown` on Windows, outside your vault so it isn't synced. It's only downloaded if you say so. Once a day at most, a binary it downloaded is checked against the latest release, and it asks before updating it. Turning an update down skips that release.

It can also come from `gem install raindown`, or set the plugin's **Raindown command** to its full path. It's desktop only.
