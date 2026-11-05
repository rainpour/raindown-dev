---
title: Chart
published: true
usecase: content
---

<{ :toc }>


A `chart:` block draws its data as a chart in block characters, and writes it into the Markdown below it as a code block, redrawn whenever the file is rendered:

````md
<!-- chart: 'data/downloads.csv' -->
```
Jan  ██████████████████████▌                  1,240
Feb  ███████████████████████████████████▉     1,980
Mar  ████████████████████████████████████████ 2,210
Apr  ███████████████▊                           870
```
<!-- :chart -->
````

## Data

Its data can be a CSV, TSV, JSON or YAML file relative to the project, numbers like `chart: '3 5 -2 8'`, or a [variable](/docs/variables) in braces like `chart: {stats}`. A variable can hold either of those, or data of its own like a list of numbers or a hash of labels and values. A table's labels come from its first column and its values from the first column of numbers after it, or name them with `label:` and `value:`, like `value: 'sales'`.

## Formats

`format:` draws it as `'bars'`, `'columns'`, a `'line'` or a `'sparkline'` (`▂▄▁▇▅█▃`). Without it, labeled data draws as bars and numbers alone as a sparkline. Negative values go below the line, or left of it for bars:

```
chart: 'data/profit.csv' width: 30
```
```
Jan              │██████████▉          1,200
Feb         ▕████│                      -450
Mar              │███████▎               800
Apr  ████████████│                    -1,300
May              │██████████████████▏  2,000
```

A line is drawn in braille, where each character has dots 2 across and 4 down, and shows the labels that fit below it:

```
chart: 'data/profit.csv' format: 'line' height: 6
```
```
 2,000 ┤                                       ⡠⠊
       │ ⢄⡀                                  ⢀⠔⠁
       │  ⠈⠑⠢⢄           ⢀⡠⠔⠊⠑⠤⡀           ⢀⠔⠁
     0 ┼──────⠉⠒⠤⣀───⣀⠤⠒⠉⠁─────⠈⠢⢄────────⡠⠊─────
       │          ⠉⠒⠉             ⠑⠢⡀   ⡠⠊
-1,300 ┤                            ⠈⠒⢄⠔⠁
         Jan      Feb       Mar      Apr      May
```

## Minus

`minus:` names a column to chart against the values, like lines deleted against lines added. It goes left of the line for bars, below it for columns and sparklines, and as a second line below zero for a line:

```
chart: 'data/commits.csv' minus: 'deleted' width: 30
```
```
a8bb4fa  -44 ██│█████████▉                    +250
d6114e0  -11  ▐│▍                              +11
b12a47e   -4  ▕│▋                              +15
35cfe8c  -11  ▐│██▌                            +62
1f8ff0e   -5  ▕│████████████████████████████▎ +717
```

## Size

Bars and lines are 40 characters wide, and columns and lines 8 lines high, which `width:` and `height:` change.

## Live data

`tail:` keeps only the last rows, like `tail: 12` for the latest twelve months of a CSV file that grows. In `raindown`'s terminal UI, the Dashboard draws charts again every few seconds, so a chart with `tail:` follows a file that a script appends to, like a live monitor.

## Your own charts

`chart:` is a [node](/docs/components#overriding-core-nodes), so a project can draw charts its own way with a `Chart` node, like `class Chart < Raindown::Chart`. Raindown only watches the file being rendered, so after changing a chart's data, save the file to redraw it.

## Stats

A stat is one big number, like the number of open issues. Make one with a node that's a `Raindown::Stat`, which gives its `value` and `label`, and optionally how its `number` is written, like with a sign. Raindown draws the number in block digits above the label:

```ruby
# .raindown/issues.rb
class Issues < Raindown::Stat
  def value(metadata:) = Issue.open.count
  def label = 'open issues'
end
```

Then `<!-- Issues: -->` and `<!-- :Issues -->` in a file write it there. An opening tag needs its colon, even without props.

