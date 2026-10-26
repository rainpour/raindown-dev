---
title: CLI
published: true
---

<{ :toc }>

The gem ships a `raindown` executable that watches Markdown files and writes back to them as they're saved, like their tables of contents, tables and endpoint responses.

```shell
# Watch every project with a .raindown folder in the current directory, or in another one:
raindown
raindown ~/dev

# Watch one file:
raindown README.md

# Render to HTML once, to stdout or to a file:
raindown README.md --html
raindown README.md --html site/index.html

# Render Markdown from stdin without touching the file (for editor previews):
cat draft.rd | raindown draft.rd --stdin

# Browse a project's files and their outlines in the terminal:
raindown tui
raindown tui README.md
```

With `--stdin`, the file only decides whether bare directives are allowed (by its extension), so it doesn't need to exist yet, and the table of contents and tables aren't written back to it.

## Commands

| Command               | Description                                                                                   |
| --------------------- | --------------------------------------------------------------------------------------------- |
| `raindown [PATH]`     | Watch a file, or the projects in a directory (default: the current directory)                 |
| `raindown init [DIR]` | Create a `.raindown` folder for the project's [config](/docs/config) and [nodes](/docs/nodes) |
| `raindown tui [PATH]` | Browse a project's files and outlines in the [terminal UI](#terminal-ui)                      |

## Options

| Option            | Description                                                                                            |
| ----------------- | ------------------------------------------------------------------------------------------------------ |
| `--html [OUTPUT]` | Render the file to HTML once, writing to `OUTPUT` or else printing to stdout                           |
| `--stdin`         | Render Markdown from stdin once, without writing back to the file. Add `--html OUTPUT` to write a file |
| `--bare`          | Allow [bare directives](/docs/raindown-files) like `:toc` in Markdown files                            |
| `-x`, `--execute` | Run [endpoint](/docs/endpoints) curl snippets that have no output yet                                  |
| `-h`, `--help`    | Show the usage                                                                                         |
| `-v`, `--version` | Show the version                                                                                       |

Set `RAINDOWN_DEBUG=1` to show where an error happened.

## Watching projects

Watching a directory watches each project in it, a folder with a `.raindown` folder, and the Markdown files below it, skipping hidden folders and ones like `node_modules` and `build`. So you can start `raindown` once in a folder like `~/dev` and it watches every Raindown project inside.

Each project's nodes load in a process of their own, so two projects can have nodes of the same name, and saving one of a project's nodes reloads them. Files are written back as they're saved, not all at once when watching starts.

Watching only writes back to the Markdown. To render HTML, use `--html`.

## Writing back

Unless it reads from stdin, Raindown writes back to the file it watches or renders: content directives like `toc:` and `files:` fill in their Markdown, endpoints write their responses, and tables are aligned.

## Terminal UI

`raindown tui` shows a project's Markdown files beside an outline of the open file's headings and directives:

```
 raindown  examples  raindown.rd
 markdown.md   │ # Raindown Example
 raindown.rd   │   toc:                               [+7]
               │   ## Charts
               │     chart: 'data/downloads.csv'      [+7]
               │   ## Endpoints
               │     endpoint: :x               [+6] [Run]
 Tab Pane  Enter Open  x Run  e Edit  w Write back  r Reload  q Quit
```

| Key                | Does                                                                                          |
| ------------------ | --------------------------------------------------------------------------------------------- |
| `↑` `↓` or `k` `j` | Move                                                                                          |
| `Tab`, `←` `→`     | Switch between the files and the outline                                                      |
| `Enter`            | Open a file, fold a folder or heading, or show what a directive wrote back                    |
| `Space`            | Like `Enter`, but without opening files or the editor                                         |
| `x`                | Run the selected endpoint, replacing its response                                             |
| `e`                | Open the file in your `$EDITOR` at the selected line, then write back to it when you close it |
| `w`                | Write back to the file                                                                        |
| `r`                | Reload the files                                                                              |
| `q`                | Quit                                                                                          |

The mouse works too: click a row to select it, and click a button like `[Run]` or `[+7]` to press it. The outline updates when the file changes, like when you save it in your editor, or when a `raindown` watcher in another terminal writes back to it.
