---
title: Directives
published: true
---

<{ :toc }>

A directive defines the node you would like to use, and how it interacts with the page.

**There are 3 kinds of directives:**
- Bare (like `toc:`)
- HTML Comment (like `<!-- toc: -->`)
- Deerheads (like `<{ toc: }>`)

**There are 3 kinds of nodes:**
- Component (like `Changelog:`)
- Core (like `endpoint:`)
- Templating (like `if:`)

**There are 2 ways to use them:**

- **Content** - Where you want to output stuff to a page like a `Changelog:` or an `endpoint:` result. For these you use Bare syntax and HTML comments for writing content back into a Markdown file.
- **Templating** - Where you want to decide *if* and how many times stuff should be output to the page. Templating directives like `if:` work with Deerheads: `<{ if: }>`.

## Comparison

| Syntax                                                           | Write-back                         | HTML output                             |
| ---------------------------------------------------------------- | ---------------------------------- | --------------------------------------- |
| **Bare** `toc:`                                                  | <span class="pill yes">Yes</span>  | <sp an class="pill shown">Bold</span>   |
| **Comment** ```<!-- toc: -->``` ```<!-- :toc -->```              | <span class="pill yes">Yes</span>  | <span class="pill hidden">Hidden</span> |
| **Deerheads** ```<{ toc: }>``` ```<{ :toc }>``` ```<{ Card }>``` | <span class="pill no">Never</span> | <span class="pill hidden">Hidden</span> |

> [!NOTE]
> All directive types can output HTML or Markdown that is rendered to HTML, it's up to you to enable it per component. See [Components](/docs/components).


## Colon syntax

A colon after the name opens a block, like `toc:`, `<!-- toc: -->` or `<{ Card: }>`.  A colon before the name closes the block, which could be an end tag, like `<!-- :toc -->` or `<{ :Card }>`, or a self-closing tag, like a bare `:toc` or `<{ :toc }>`.

A capitalized node can be self-closing without a colon, like `<{ Card }>`, while `<{ title }>` without one is a variable.

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

You write their output as a template, and they decide whether it appears and how many times, filling in values like `{title}`. They're always written in `<{ }>`, never bare, and they're invisible in the HTML, since the input is a template.

Great for control flow nodes like `if:` and `for:` that need closing tags and only care about HTML output. A Deerheads directive is write-in: Raindown only calls its node's `render`, never its `rewrite`, and the text between its tags is its input. You would typically use Deerheads inside a [custom component](/docs/components#custom-components) or for [Static Site Generation](/docs/static).

#### Variables

Variables look like `variable`, unlike Bare syntax and HTML comments, Deerheads syntax treats words without quotes as variables.

Variables with `{variable}` syntax can still be used in the Markdown file but not inside the Deerheads (`<{ }>`).  

Consider that `{variable}`'s are HTML escaped, whereas variables inside Deerheads are not. This allows for complex data such as arrays and hashes and even other nodes to be used as props to a node... but it requires more security considerations and these complex data types are usually only accessible inside a [component](/docs/components) itself, not on a Markdown page. This is advanced usage for themers and programmers.

#### Closing tags

```
<{ if: draft }>
This is a draft.

It has two paragraphs.
<{ :if }>
```

### Self-closing tags

Put a colon at the start of a directive to make it self-closing. Self-closing tags don't output any Markdown into the file, and will only output HTML when rendering the file as HTML. A directive with no block, like `<{ :toc }>`, closes itself.

## Nodes

### Core

Core nodes are similar to Components, in that they produce output on the page. Some can even be overridden by a component: a `TOC`, `List`, `Chart` or `Table` node in `.raindown`, like `class Chart < Raindown::Chart`, replaces `toc:`, `files:`, `chart:` or `table:`. The main difference is that core nodes are library features that tap into advanced workflows, like sanitising curl requests or showing every chart and stat on the terminal UI's [Dashboard](/docs/cli#dashboard).
