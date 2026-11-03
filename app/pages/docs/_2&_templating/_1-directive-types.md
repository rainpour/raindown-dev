---
title: Directive Types
published: true
---

<{ :toc }>

How a directive is written says what it does: bare and comment directives write their output into the file, and `<{ }>` directives only render into the HTML:

| Syntax                              | Write-back                        | HTML: directive                         | HTML: output  | GitHub preview: directive               | GitHub preview: output |
| ----------------------------------- | --------------------------------- | --------------------------------------- | ------------- | --------------------------------------- | ---------------------- |
| Bare `name:`                        | <span class="pill yes">Yes</span> | <span class="pill shown">Bold</span>    | Markdown/HTML | Raw text `name:`                        | Rendered Markdown      |
| `<!-- name: -->` … `<!-- :name -->` | <span class="pill yes">Yes</span> | <span class="pill hidden">Hidden</span> | Markdown/HTML | <span class="pill hidden">Hidden</span> | Rendered Markdown      |
| `<{ name: }>` … `<{ :name }>`       | <span class="pill no">No</span>   | <span class="pill hidden">Hidden</span> | Markdown/HTML | Raw text `<{ name: }>`                  | Raw text `<{ name: }>` |

1. Bare directives work in [Raindown files](/docs/raindown-files) (`.rd`) and in Markdown files (`.md`) with `raindown: true` front matter or `--bare` via the CLI.
2. All directive types can output HTML or Markdown that is rendered to HTML, it's up to you to enable it per component. See [Components](/docs/components).

Directives come in two kinds: template directives, which shape how the Markdown around them renders, and content directives, which bring content into the page.

## Bare directives

Bare directives write their output back into the file, and show in bold in the HTML. They have no end tags, so a bare block, like `toc:`, holds the Markdown straight below it, up to the next blank line:

```
toc:
- [Notes](#notes)
```

When its output needs blank lines, put it in HTML comments with an end tag instead, `<!-- toc: -->` and `<!-- :toc -->`, which works in `.md` and `.rd`, and hides it in the HTML.

Template directives, like `if:` and `for:`, are never bare, and always sit in `<{ }>`:

```
<{ if: draft }>
This is a draft.

It has two paragraphs.
<{ :if }>
```

Directives in prose or code are left as text.

## Template directives

Shape how the Markdown around them renders, like Liquid or Jinja: [variables](/docs/variables) like `{title}`, [loops](/docs/control-flow#loops) with `for:`, [conditions](/docs/control-flow#conditions) with `if:` and [lists](/docs/files-and-lists) with `list:`.

You write their output as a template, and they decide whether it appears and how many times, filling in values like `{title}`. They're always written in `<{ }>`, never bare, and they're invisible in the HTML, since the input is a template, and showing them would break the tables and lists they often sit in.

## Content directives

Bring content into the page: a [table of contents](/docs/table-of-contents) with `toc:` and `:toc`, [files](/docs/files-and-lists) with `files:`, [endpoints](/docs/endpoints) with `endpoint:` and your own [components](/docs/components).

Raindown or your component writes their output, and you only give them input, like `folder: 'notes'` or an endpoint's curl snippet. Most also write their content into the Markdown below them, so it's there for people and agents reading the file.

They sit on their own lines between content blocks. Written bare, they write back and show in bold in the HTML, so you can see where a page's content comes from. In HTML comments, like `<!-- toc: -->` and `<!-- :toc -->`, they write back and stay hidden, in the HTML and on GitHub. In `<{ }>`, like `<{ :toc }>`, they only render into the HTML, and write nothing into the file.

## Blocks and end tags

A block directive wraps the Markdown it applies to, and closes with an end tag named after it, written the same way, in `<{ }>` or in a comment:

```md
<{ if: draft }>
This is a draft.

It has two paragraphs.
<{ :if }>
```

A directive with no block, like `<{ :toc }>`, closes itself. Directives in prose or code are left as text.

> [!TIP]
> In a [Raindown file](/docs/raindown-files) content directives can be written bare, without delimiters or end tags.
