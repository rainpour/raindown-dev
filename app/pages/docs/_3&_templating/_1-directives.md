---
title: Directives
published: true
---

<{ :toc }>

Directives are the syntax that defines the node you would like to use, and how it interacts with the page.

**There are 3 kinds of directives:**
- Bare (like `toc:`)
- HTML Comment (like `<!-- toc: -->`)
- Deerheads (like `<{ toc: }>`)

**There are 3 kinds of nodes:**
- Component (like `Changelog:`)
- Core (like `endpoint:`)
- Templating (like `if:`)

While there are technically 9 combinations of ways you could use the above concepts, in practice there are 2 main use cases; Content and Templating.

**Content** is where you want to output stuff to a page like a `Changelog:` or an `endpoint:` result. For these you can use any of the 3 kinds of directives, but will usually use Bare syntax and HTML comments for writing content back into a Markdown file.

**Templating** is where you want to decide *if* stuff should be output to the page. Templating directives like `if:` work well with Deerheads directives: `<{ if: }>`. This combination is for your traditional HTML generation needs.

## Comparison

| Written as                                              | Writes into the file                                         | Shows in the HTML                                       | Typical use                                                 |
| ------------------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------- | ----------------------------------------------------------- |
| **Bare** `toc:`                                         | <span class="pill yes">Yes</span>, up to the next blank line | <span class="pill shown">Bold</span>                    | `.rd` files, where you want to see where content comes from |
| **HTML Comment** `<!-- toc: -->` … `<!-- :toc -->`      | <span class="pill yes">Yes</span>, up to its end tag         | <span class="pill hidden">Hidden</span>, also on GitHub | Plain `.md` that should read cleanly anywhere               |
| **Deerheads** `<{ toc: }>` … `<{ :toc }>`, `<{ Card }>` | <span class="pill no">Never</span>                           | <span class="pill hidden">Hidden</span>                 | Templates, layouts and render-only components               |
| **Variable** `{title}` or `<{ title }>`                 | <span class="pill no">Never</span>                           | The value, escaped or raw                               | [Variables](/docs/variables)                                |
| **Translation** `{:app_name}`                           | <span class="pill no">Never</span>                           | The translation                                         | Translations                                                |

### The colon

A colon after the name opens a block, like `toc:`, `<!-- toc: -->` or `<{ Card: }>`, and a colon before the name closes the block, which could be an end tag, like `<!-- :toc -->` or `<{ :Card }>`, or a self-closing tag, like a bare `:toc` or `<{ :toc }>`. A capitalized node can be self-closing without a colon, like `<{ Card }>`, while `<{ title }>` without one is a variable.

> [!NOTE]
> All directive types can output HTML or Markdown that is rendered to HTML, it's up to you to enable it per component. See [Components](/docs/components).

## Directives

### Bare

<{ UseCase use_case='content' }>

Bare directives write their output back into the file, and their headings are bold in exported HTML. They have no end tags, so a bare block like `toc:` controls the Markdown directly below it:

```
toc:
- [Notes](#notes)
```

> [!TIP]
> Bare directives work in [Raindown files](/docs/file-types) (`.rd`) and in Markdown files (`.md`) with `raindown: true` front matter or `--bare` via the CLI.

#### Variables

Variables look like `{variable}`

#### Closing tags

A block of content belongs to the bare directive until the first blank line. Bare syntax does not use or need closing tags.

### HTML Comment

<{ UseCase use_case='content' }>

#### Variables

Variables look like `{variable}`

#### Closing tags

When its output needs blank lines, put it in HTML comments with an end tag instead, `<!-- toc: -->` and `<!-- :toc -->`, which works in `.md` and `.rd`, and hides it in the HTML.

### Template

<{ UseCase use_case='template' }>

Great for control flow nodes like `if:` and `for:` that need closing tags and only care about HTML output. A node in Deerheads is write-in: Raindown only calls its `render`, never its `rewrite`, and the Markdown between its tags is its input, as `slot:`. You would typically use Deerheads inside a [custom component](/docs/components#custom-components) or for [Static Site Generation](/docs/static).

#### Variables

Variables look like `variable`, unlike Bare syntax and HTML comments, Deerheads syntax treats words without quotes as variables.  
Variables with `{variable}` syntax can still be used in the Markdown file but not inside the Deerheads (`<{ }>`).  

Consider that `{variable}`'s are HTML escaped, whereas variables inside Deerheads are not. This allows for complex data such as arrays and hashes and even other nodes to used as props to a node... but it requires more security considerations and these complex data types are usually only accessible inside a [component](/docs/components) itself, not on a Markdown page. This is advanced usage for programmers.

#### Closing tags

```
<{ if: draft }>
This is a draft.

It has two paragraphs.
<{ :if }>
```

Directives in prose or code are left as text in GitHub previews, but hidden in the generated HTML.

Shape how the Markdown around them renders, like Liquid or Jinja: [variables](/docs/variables) like `{title}`, [loops](/docs/control-flow#loops) with `for:` and [conditions](/docs/control-flow#conditions) with `if:`. A [`list:`](/docs/list) block's template repeats like a loop, for each file it lists.

You write their output as a template, and they decide whether it appears and how many times, filling in values like `{title}`. They're always written in `<{ }>`, never bare, and they're invisible in the HTML, since the input is a template, and showing them would break the tables and lists they often sit in.

### Self-closing tags

Put a colon at the start of a directive to make it self-closing. Self-closing tags don't output any Markdown into the file, and will only output HTML when rendering the file as HTML. A directive with no block, like `<{ :toc }>`, closes itself.

## Nodes

### Core

Core nodes are similar to Components, in that they produce output on the page. Some can even be overridden by a component: a `TOC`, `List`, `Chart` or `Table` node in `.raindown`, like `class Chart < Raindown::Chart`, replaces `toc:`, `files:`, `chart:` or `table:`. The main difference is that core nodes are library features that tap into advanced workflows, like sanitising curl requests or showing every chart and stat on the terminal UI's [Dashboard](/docs/cli#dashboard).
