---
title: CLI
published: true
---

<{ :toc }>

## Installation

### Binary

Download a standalone binary:

| OS                                            | x86_64                                                                                                | ARM64                                                                                               |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| <i class="bi bi-apple"></i> macOS             | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-macos-x86_64)       | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-macos-arm64)      |
| <i class="bi bi-tux"></i> Linux               | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-linux-x86_64)       | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-linux-arm64)      |
| <i class="bi bi-tux"></i> Linux (musl/Alpine) | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-linux-musl-x86_64)  | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-linux-musl-arm64) |
| <i class="bi bi-windows"></i> Windows         | [Download](https://github.com/rainpour/raindown/releases/latest/download/raindown-windows-x86_64.exe) | —                                                                                                   |

On macOS and Linux, make it executable and move it onto your `PATH`:
```shell
chmod +x raindown-*
mv raindown-* /usr/local/bin/raindown
```

**Alpine:**
The musl binaries need `libgcc` and ncurses, which bare Alpine doesn't include:
```
apk add libgcc ncurses-libs
```

### Gem

If you have Ruby installed on your system then you can just run:
```shell
gem install raindown
```

The gem compiles the curses gem, for the [terminal UI](/docs/cli#terminal-ui), so on Linux install ncurses' headers first, like `apt install libncurses-dev` or `apk add ncurses-dev`.

## Updating

Download the binary again from the table above and replace the old one.

If you installed the gem via Ruby then do:
```shell
gem update raindown
```

## Setup

Run `raindown init` in the root of your project to create a `.raindown` folder. It marks the project's root and holds its [config](/docs/config) and your own [components](/docs/components):

```shell
raindown init
# Created .raindown/config.yml
```

## Usage

The `raindown` executable opens a project in the [terminal UI](#terminal-ui), and watches its Markdown files and writes back to them as they're saved, like their tables of contents, tables and endpoint responses. `raindown watch` does the watching without the terminal UI.

```shell
# Browse a project's files and their outlines in the terminal, watching them as they're saved:
raindown
raindown README.md

# Watch every project with a .raindown folder in the current directory, or in another one, without the terminal UI:
raindown watch
raindown watch ~/dev

# Watch one file:
raindown watch README.md

# Render to HTML once, to stdout or to a file:
raindown README.md --html
raindown README.md --html site/index.html

# Render Markdown from stdin without touching the file (for editor previews):
cat draft.rd | raindown draft.rd --stdin
```

With `--stdin`, the file only decides whether bare directives are allowed (by its extension), so it doesn't need to exist yet, and the table of contents and tables aren't written back to it.

## Your first directive

Add a table of contents to a [Raindown file](/docs/file-types), like `notes.rd`:

```
# Notes

toc:

## Setup
```

Save it and Raindown writes the table of contents below `toc:`, so people and agents reading the file see it too:

```
toc:
- [Notes](#notes)
  - [Setup](#setup)
```

In a `.md` file, add `raindown: true` to its front matter, or write it in HTML comments, `<!-- toc: -->` and `<!-- :toc -->`, which GitHub hides. For the HTML alone, without writing into the file, use `<{ :toc }>` by itself, in Deerheads. See [Table of contents](/docs/toc).

## Commands

| Command                 | Description                                                                                                              |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `raindown [PATH]`       | Browse a project's files and outlines in the [terminal UI](#terminal-ui), watching them (default: the current directory) |
| `raindown watch [PATH]` | Watch a file, or the projects in a directory, without the terminal UI (default: the current directory)                   |
| `raindown init [DIR]`   | Create a `.raindown` folder for the project's [config](/docs/config) and [components](/docs/components)                  |
| `raindown server`       | Keep Raindown loaded for an editor, answering JSON requests on stdin, as the [editor server](#editor-server)             |

## Options

| Option            | Description                                                                                            |
| ----------------- | ------------------------------------------------------------------------------------------------------ |
| `--html [OUTPUT]` | Render the file to HTML once, writing to `OUTPUT`, or to stdout without one or with `-`                |
| `--stdin`         | Render Markdown from stdin once, without writing back to the file. Add `--html OUTPUT` to write a file |
| `--bare`          | Allow [bare directives](/docs/file-types) like `toc:` in Markdown files                                |
| `-x`, `--execute` | Run [endpoint](/docs/endpoint) curl snippets that have no output yet. Only use it on files you trust   |
| `--env NAME`      | Fill endpoint snippets from the `NAME` [environment](/docs/endpoint#environments)                      |
| `-h`, `--help`    | Show the usage                                                                                         |
| `-v`, `--version` | Show the version                                                                                       |

Set `RAINDOWN_DEBUG=1` to show where an error happened.

## Watching projects

Watching a directory watches each project in it, a folder with a `.raindown` folder, and the Markdown files below it, skipping hidden folders and ones like `node_modules` and `build`. So you can start `raindown watch` once in a folder like `~/dev` and it watches every Raindown project inside.

Each project's components load in a process of their own, so two projects can have components of the same name, and saving one of a project's components reloads them. Files are written back as they're saved, not all at once when watching starts.

Watching only writes back to the Markdown. To render HTML, use `--html`.

## Writing back

Unless it reads from stdin, Raindown writes back to the file it watches or renders: content directives that are bare or in HTML comments, like `toc:` and `<!-- files: -->`, fill in their Markdown, endpoints write their responses, and tables are aligned. Directives in `<{ }>` only render, so they write nothing.

## Editor server

Editors keep Raindown loaded with `raindown server`, so a render doesn't start Ruby again each time: the first takes about a second, and the ones after it a few milliseconds. It says it's ready, then answers one JSON request a line on stdin, in order, on stdout:

```
{"ready":true,"version":"0.10.0"}
{"id":1,"path":"/notes/a.md","markdown":"# A\n\n<!-- toc: -->\n<!-- :toc -->\n","rewrite":true}
{"id":1,"output":"# A\n\n<!-- toc: -->\n- [A](#a)\n<!-- :toc -->\n","warnings":[]}
```

With `"rewrite": true`, it answers like `--stdin --rewrite`, with `"execute": true` like `-x`, and otherwise with HTML, like `--stdin`. `"bare": true` is like `--bare`. An error is answered as `{"id":1,"error":"raindown: /notes/a.md: ..."}`. Each project renders in a process of its own, which starts again when a file in its `.raindown` folder changes, so its components, config and schemas are never stale. On Windows, which can't fork, start the server again after changing them.

## Terminal UI

`raindown` shows a project's Markdown files beside an outline of the open file's headings and directives. It watches every file in the folder, like `raindown watch`, and writes back to each Markdown file as it's saved:

```
 raindown  examples  raindown.rd
 markdown.md   │ # Raindown Example
 raindown.rd   │   toc:                               [+7]
               │   ## Charts
               │     chart: 'data/downloads.csv'      [+7]
               │   ## Endpoints
               │     endpoint:                  [+6] [Run]
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

The mouse works too: click a row to select it, and click a button like `[Run]` or `[+7]` to press it. The outline updates when the file changes, like when you save it in your editor, or when a `raindown watch` in another terminal writes back to it.

### Dashboard

The terminal UI opens on the Dashboard, at the top of the files, or press `d`. It shows every [chart](/docs/chart) and stat in the project, each in a card under its file and heading, drawn again from their data every few seconds, so editing a CSV file updates its chart without a save. Enter, or clicking a card's title, opens the chart's file on its directive.

Below the files is every [endpoint](/docs/endpoint) in the project, by its request, like `GET httpbin.org/uuid`. Enter or a click opens one with its response, and `x`, or clicking **Run**, runs it.

On a folder of projects, like `raindown ~/dev`, projects inside it are marked 🌧 in the files, with their own charts. Click the path in the header, or press `p`, to narrow the files and the Dashboard to one project.
