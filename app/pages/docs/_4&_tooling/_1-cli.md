---
title: CLI
published: true
---

<{ :toc }>

The gem ships a `raindown` executable that opens a project in the [terminal UI](#terminal-ui), and watches its Markdown files and writes back to them as they're saved, like their tables of contents, tables and endpoint responses. `raindown watch` does the watching without the terminal UI.

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

## Commands

| Command                 | Description                                                                                                              |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `raindown [PATH]`       | Browse a project's files and outlines in the [terminal UI](#terminal-ui), watching them (default: the current directory) |
| `raindown watch [PATH]` | Watch a file, or the projects in a directory, without the terminal UI (default: the current directory)                   |
| `raindown init [DIR]`   | Create a `.raindown` folder for the project's [config](/docs/config) and [components](/docs/components)                  |

## Options

| Option            | Description                                                                                            |
| ----------------- | ------------------------------------------------------------------------------------------------------ |
| `--html [OUTPUT]` | Render the file to HTML once, writing to `OUTPUT`, or to stdout without one or with `-`                |
| `--stdin`         | Render Markdown from stdin once, without writing back to the file. Add `--html OUTPUT` to write a file |
| `--bare`          | Allow [bare directives](/docs/raindown-files) like `toc:` in Markdown files                            |
| `-x`, `--execute` | Run [endpoint](/docs/endpoints) curl snippets that have no output yet. Only use it on files you trust  |
| `--env NAME`      | Fill endpoint snippets from the `NAME` [environment](/docs/endpoints#environments)                     |
| `-h`, `--help`    | Show the usage                                                                                         |
| `-v`, `--version` | Show the version                                                                                       |

Set `RAINDOWN_DEBUG=1` to show where an error happened.

## Watching projects

Watching a directory watches each project in it, a folder with a `.raindown` folder, and the Markdown files below it, skipping hidden folders and ones like `node_modules` and `build`. So you can start `raindown watch` once in a folder like `~/dev` and it watches every Raindown project inside.

Each project's components load in a process of their own, so two projects can have components of the same name, and saving one of a project's components reloads them. Files are written back as they're saved, not all at once when watching starts.

Watching only writes back to the Markdown. To render HTML, use `--html`.

## Writing back

Unless it reads from stdin, Raindown writes back to the file it watches or renders: content directives that are bare or in HTML comments, like `toc:` and `<!-- files: -->`, fill in their Markdown, endpoints write their responses, and tables are aligned. Directives in `<{ }>` only render, so they write nothing.

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
