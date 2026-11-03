---
title: Control flow
published: true
---

<{ :toc }>

Loops and conditions decide whether the Markdown inside them appears, and how many times, like Liquid or Jinja. They're template directives, so they're always written in `<{ }>`, never bare, and they write nothing into the file.

## Loops

Loop over a list with `for:`, which repeats its Markdown for each item, filling in [variables](/docs/variables) like `{tag}`:

```md
<{ for: tag in: tags }>
- {tag}
<{ :for }>
```

Loop over a hash by its keys and values, like `links` in the front matter:

```md
---
links:
  docs: https://raindown.dev
  code: https://github.com/raindeer-rb/raindown
---

<{ for: name, url in: links }>
- [{name}]({url})
<{ :for }>
```

To loop over your project's files, use a [`list:`](/docs/files-and-lists) block.

## Conditions

Render a block only when a value is true with `if:`:

```md
<{ if: draft }>
This is a draft.
<{ :if }>
```

A value can be nested, like `if: author.name`. Only `false` and missing values are false, so `0`, empty text and empty lists count as true.

## Render order

Variables, loops and conditions render before the Markdown does, like Liquid in Jekyll. So a loop's lines make one list or table, and a value can contain Markdown like `*emphasis*`.

> [!NOTE]
> Template directives are always invisible in the HTML, since their input is a template, and showing them would break the tables and lists they often sit in.
