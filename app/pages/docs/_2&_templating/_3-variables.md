---
title: Variables
published: true
---

Front matter keys are variables, which render with `{key}`, or `<{ key }>` to leave HTML unescaped:

```md
---
title: Release notes
author:
  name: Mark
tags: [ruby, markdown]
draft: false
---

{title}

{author.name}
```

Unknown variables render nothing, and variables in code are left as text.

Use variables in [loops and conditions](/docs/control-flow), and as [component props](/docs/components#props).
