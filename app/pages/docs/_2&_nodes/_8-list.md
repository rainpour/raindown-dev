---
title: List
published: true
usecase: template
---

To list the Markdown files in your project with your own template, instead of the links [`files:`](/docs/files) writes, use a `list:` block. Its template repeats for each file, by its [metadata](/docs/metadata), and only renders in the HTML:

```md
<{ list: page folder: 'notes' }>
## {page.title}
<{ :list }>
```

For example, this list of the node pages is a `list:` block:

<{ list: page folder: 'nodes' }>
- [{page.title}]({page.path})
<{ :list }>

