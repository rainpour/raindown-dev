---
title: Table
published: true
usecase: content
---

<{ :toc }>

A `table:` directive writes a CSV or TSV file, relative to the project, as a Markdown table, after a comment of how many rows it has and a hash of them:

````md
table: 'data/team.csv'
<!-- table 2 rows · 3f2a9c -->
| name | role     |
| ---- | -------- |
| Ada  | engineer |
| Lin  | design   |
````

The file's first row is the table's header. Bare, in a [Raindown file](/docs/file-types) (`.rd`), a Markdown file with `raindown: true` front matter, or with `--bare`, it ends at the next blank line, like other bare blocks.

## Editing the table

Edit the table, like changing a cell, adding a row or deleting one, and Raindown writes its rows back to the file when it renders. Edit the file and the table's written again. So the table in your docs and the data behind it stay the same, whichever one you change.

The hash in the comment is of the rows as they were when the table and the file last matched, so Raindown can tell which one changed since:

- **Only the file changed**: the table is written again from it.
- **Only the table changed**: its rows are written to the file.
- **Both changed**: neither is written, and the comment reads `<!-- table conflict · 3f2a9c -->` until they match again.

## Conflicts

When both changed, Raindown warns and leaves both as they are, so neither edit is lost. To settle it:

- **Keep the file's rows** by deleting the comment, or emptying the table, and the table's written again from the file.
- **Keep the table's rows** by making the file match it, or the other way round. Once they match, the comment has a new hash.

Emptying the table never empties the file.

## Cells

A `|` in a cell is written as `\|`, and a line break in one as a space, as a table's cells are one line. Raindown lines up the table's columns when it writes the file back, so don't worry about aligning them. When the table's rows are written back, the file is written as CSV or TSV again, quoting only the cells that need it.

`table:` is a [node](/docs/components), so a project can write tables its own way with a `Table` node, like `class Table < Raindown::Table`.
