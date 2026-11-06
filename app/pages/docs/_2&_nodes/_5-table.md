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

## Totals

With `total: true`, a bold row below the table sums each column whose cells are all numbers or blank, to the most decimal places any of them has. The first column reads Total, unless it's numbers too:

````md
table: 'data/sales.csv' total: true
<!-- table 2 rows · 40ec83 -->
| item      | units | price    |
| --------- | ----- | -------- |
| Tea       | 3     | 1.5      |
| Cake      | 2     | 2.25     |
| **Total** | **5** | **3.75** |
````

table: 'data/sales.csv'
<!-- table 3 rows · a55f32 -->
| item | units | price |
| ---- | ----- | ----- |
| Tea  | 3     | 1.5   |
| Cake | 2     | 2.25  |
|      | 5     |       |

The total is worked out again whenever the table's written, and never written to the file. Edit the rows above it, or add rows below it, and it sums them.

## Formulas

Formula cells in the file, like `=SUM(B)` by its column's letter or `=sum(Price)` by its header, show their values in the table, summing the numbers in the column below its header, like a spreadsheet, and leaving out other formulas. Case doesn't matter, in `SUM` or the column, so `=Sum(b)` and `=sum(PRICE)` work too. A formula naming a column that doesn't exist shows as it's written, like other formulas, so you can keep typing it. When the table's edits are written back, a formula cell still showing its value keeps its formula, so type a new formula or value into one to replace it. To edit its formula instead, delete the spaces around its value, so it's no longer lined up with its column, and the formula shows in its place, like `=SUM(B)`. It keeps showing until you change it, ignoring spaces, and then it's written to the file and shows its value again. Adding or deleting rows above a formula cell moves it, so check it's still a formula afterwards.

## Cells

A `|` in a cell is written as `\|`, and a line break in one as a space, as a table's cells are one line. Raindown lines up the table's columns when it writes the file back, so don't worry about aligning them. When the table's rows are written back, the file is written as CSV or TSV again, quoting only the cells that need it.

`table:` is a [node](/docs/components), so a project can write tables its own way with a `Table` node, like `class Table < Raindown::Table`.
