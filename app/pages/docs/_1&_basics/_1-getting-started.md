---
title: Getting Started
published: true
---

<{ :toc }>

## Installation

**Download a standalone binary** with Ruby bundled inside (about 120–180MB):

| OS | x86_64 | ARM64 |
|----|--------|-------|
| <i class="bi bi-apple"></i> macOS | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-macos-x86_64) | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-macos-arm64) |
| <i class="bi bi-tux"></i> Linux | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-linux-x86_64) | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-linux-arm64) |
| <i class="bi bi-tux"></i> Linux (musl/Alpine) | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-linux-musl-x86_64) | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-linux-musl-arm64) |
| <i class="bi bi-windows"></i> Windows | [Download](https://github.com/raindeer-rb/raindown/releases/latest/download/raindown-windows-x86_64.exe) | — |

On macOS and Linux, make it executable and move it onto your `PATH`:
```shell
chmod +x raindown-*
mv raindown-* /usr/local/bin/raindown
```

**Alpine:**
The musl binaries need `libgcc` and ncurses, which bare Alpine doesn't include (`apk add libgcc ncurses-libs`). The other Linux binaries use the system's ncurses, which most distros include.

**Ruby:**

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

Run `raindown init` in the root of your project to create a `.raindown` folder. It marks the project's root and holds its [config](/docs/config) and your own [nodes](/docs/nodes):

```shell
raindown init
# Created .raindown/config.yml
```

## Usage

**Then open your project:**
```shell
raindown
```

This opens the project in the terminal, and watches its Markdown files, writing back to each one as it's saved, like its table of contents and tables.

**To watch without the terminal UI:**
```shell
raindown watch
```

Start it in a folder like `~/dev` and it watches every project inside. To watch one file, run `raindown watch README.md`.

**To render a file to HTML:**
```shell
raindown README.md --html README.html
```

See the [CLI](/docs/cli) for more.

## Your first directive

Add a table of contents to any Markdown file:

```md
# Notes

<!-- toc: -->
<!-- :toc -->

## Setup
```

Save it and Raindown writes the table of contents into the Markdown between the two tags, so people and agents reading the file see it too. The tags are HTML comments, so on GitHub only the list shows:

```md
<!-- toc: -->
- [Notes](#notes)
  - [Setup](#setup)
<!-- :toc -->
```

For the HTML alone, without writing into the file, use `<{ :toc }>` by itself, in Deerheads. See [Table of contents](/docs/table-of-contents).

## VS Code extension

Highlight Raindown syntax with the [VS Code extension](/docs/extensions).
