---
title: Config
published: true
---

A project can keep settings in `config.yml` in its [`.raindown`](/docs/nodes) folder.

## Highlighting code

Code blocks are highlighted in the HTML. For a site that highlights code in the browser instead, like with [Prism](https://prismjs.com), turn it off and each code block gets a language class, like `<pre><code class="language-ruby">`:

```yaml
# .raindown/config.yml
highlight_code: false
```

## Showing and hiding directives

How a [directive](/docs/directives) is written decides whether it shows in the HTML: bare directives show in bold, and ones in HTML comments or `<{ }>` are left out. To hide a directive that writes back, write it in comments, like `<!-- toc: -->` and `<!-- :toc -->`.
