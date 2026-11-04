---
title: Extensions
menu: Extensions
published: true
---

<{ :toc }>

## VS Code

The [VS Code extension](https://github.com/rainpour/raindown/tree/main/vscode) highlights syntax and previews Raindown files with the [editor server](/docs/cli#editor-server), or `--stdin` with a Raindown from before it, rendering as you type. In Markdown files it highlights `<{ }>` directives and renders them in the built-in Markdown preview.

|                         | Markdown                      | Raindown                                   |
| ----------------------- | ----------------------------- | ------------------------------------------ |
| File extensions         | `.md`, `.markdown`            | `.rd`, `.raindown`                         |
| Highlights `<{ :toc }>` | ✓                             | ✓                                          |
| Highlights `:toc`       |                               | ✓                                          |
| Preview                 | The built-in Markdown preview | **Raindown: Open Preview** (`Cmd+Shift+V`) |

Directives in code and comments aren't highlighted, matching what Raindown renders.

The previews render the unsaved text with `raindown server`, or `raindown FILE --stdin` with a Raindown from before it, so they update as you type and never change the file. The table of contents and table alignment are written to the file by `raindown FILE`, and endpoints only run there with `-x`.

### Install

The extension isn't on the VS Code Marketplace yet. Package it from the [source](https://github.com/rainpour/raindown/tree/main/vscode) and install it:

```shell
git clone https://github.com/rainpour/raindown.git
cd raindown/vscode
npx @vscode/vsce package
code --install-extension raindown-*.vsix
```

### Requirements

The `raindown` executable, from the [standalone binary](/docs/getting-started#installation) or via `gem install raindown`. If `raindown` isn't on your `PATH` then set `raindown.path` to the full path of the executable.

### Settings

| Setting                    | Default    | Description                                                |
| -------------------------- | ---------- | ---------------------------------------------------------- |
| `raindown.path`            | `raindown` | The file path to the raindown executable                   |
| `raindown.markdownPreview` | `true`     | Highlight Raindown syntax in the built-in Markdown preview |

> [!TIP]
> Turn off `markdownPreview` to keep the plain preview, which also keeps its scroll sync.

## Obsidian

The [Obsidian plugin](https://github.com/rainpour/raindown-obsidian) writes back to your notes as you save them, like `raindown watch`: tables of contents, file lists, [components](/docs/components) and charts. What it writes is plain Markdown in the note, so it reads the same on GitHub, on your phone and in any other editor.

Once you stop typing, it gives the note to the [editor server](/docs/cli#editor-server), or `raindown NOTE --stdin --rewrite` with a Raindown from before it, which answers with the note as Raindown would write it back, and applies that only if the note hasn't changed since, so nothing you type is lost. Errors, like a directive that's half typed, show in the status bar, and directives are highlighted as you type. Bare directives, like `toc:`, need `raindown: true` in a note's front matter, unless the plugin's **Bare directives in every note** setting is on.

- **Raindown: Write back this note** writes back now, and says what happened.
- **Raindown: Run the endpoints in this note** runs the [endpoints](/docs/endpoints) without a response. Endpoints never run on save.
- **Raindown: Write back all notes** writes back every note with directives.
- **Raindown: Download Raindown** downloads the latest standalone binary, or updates it.

Adding, renaming or removing a note writes back the notes with lists, like `files:`, so they don't go stale. In the editor, directive names complete after `<!--` or `<{`, from Raindown's own and your project's nodes, and the line of an error is underlined. Reading view shows `<{ }>` directives as Raindown renders them.

### Install

The plugin isn't in Obsidian's community plugins yet. Copy `main.js`, `manifest.json` and `styles.css` from the [source](https://github.com/rainpour/raindown-obsidian) into your vault's `.obsidian/plugins/raindown/` folder, then turn on **Raindown** in **Settings → Community plugins**.

### Requirements

The `raindown` executable. The first time the plugin can't find it, it looks on your shell's `PATH`, which Obsidian opened from the Dock doesn't have, and if it's not there either, offers to download the [standalone binary](/docs/getting-started#installation) from GitHub, checked against the release's checksums, to `~/.local/bin/raindown`, or `%LOCALAPPDATA%\Programs\raindown` on Windows, outside your vault so it isn't synced. It's only downloaded if you say so. Once a day at most, a binary it downloaded is checked against the latest release, and it asks before updating it. Turning an update down skips that release.

It can also come from `gem install raindown`, or set the plugin's **Raindown command** to its full path. It's desktop only.
