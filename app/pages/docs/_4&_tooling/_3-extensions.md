---
title: Extensions
menu: Extensions
published: true
---

<{ :toc }>

## VS Code

The [VS Code extension](https://github.com/rainpour/raindown/tree/main/vscode) highlights syntax and previews Raindown files with `--stdin`, rendering as you type. In Markdown files it highlights `<{ }>` directives and renders them in the built-in Markdown preview.

|                         | Markdown                      | Raindown                                   |
| ----------------------- | ----------------------------- | ------------------------------------------ |
| File extensions         | `.md`, `.markdown`            | `.rd`, `.raindown`                         |
| Highlights `<{ :toc }>` | ✓                             | ✓                                          |
| Highlights `:toc`       |                               | ✓                                          |
| Preview                 | The built-in Markdown preview | **Raindown: Open Preview** (`Cmd+Shift+V`) |

Directives in code and comments aren't highlighted, matching what Raindown renders.

The previews render the unsaved text with `raindown FILE --stdin`, so they update as you type and never change the file. The table of contents and table alignment are written to the file by `raindown FILE`, and endpoints only run there with `-x`.

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

The [Obsidian plugin](https://github.com/rainpour/raindown/tree/main/obsidian) writes back to your notes as you save them, like `raindown watch`: tables of contents, file lists, [components](/docs/components) and charts. What it writes is plain Markdown in the note, so it reads the same on GitHub, on your phone and in any other editor.

Once you stop typing, it gives the note to `raindown NOTE --stdin --rewrite`, which prints the note as Raindown would write it back, and applies that only if the note hasn't changed since, so nothing you type is lost. Errors, like a directive that's half typed, show in the status bar.

- **Raindown: Write back this note** writes back now, and says what happened.
- **Raindown: Run the endpoints in this note** runs the [endpoints](/docs/endpoints) without a response. Endpoints never run on save.

### Install

The plugin isn't in Obsidian's community plugins yet. Copy `main.js` and `manifest.json` from the [source](https://github.com/rainpour/raindown/tree/main/obsidian) into your vault's `.obsidian/plugins/raindown/` folder, then turn on **Raindown** in **Settings → Community plugins**.

### Requirements

The `raindown` executable, from the [standalone binary](/docs/getting-started#installation) or via `gem install raindown`. Obsidian often doesn't see your shell's `PATH`, so set the plugin's **Raindown command** to its full path, like `~/.local/bin/raindown`, if Obsidian can't find it. It's desktop only.
