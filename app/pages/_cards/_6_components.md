---
title: Custom Components
summary: Create components with custom output
---

<div class="code-tabs">

```ruby
class Changelog < LowNode
  def replace = "- **1.2.0** ..."
end
```

```js
export class Changelog {
  replace() { return "- **1.2.0** ..." }
}
```

```md
<!-- .raindown/Changelog.md -->
- **1.2.0** ...
```

</div>

Use with:
```md
Changelog:
  - **1.2.0** ...
```
