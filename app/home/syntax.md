<table class="syntax-table">
  <thead>
    <tr>
      <th>Syntax</th>
      <th>Write-back</th>
      <th>HTML: Directive</th>
      <th>HTML: Output</th>
      <th>GitHub preview: Directive</th>
      <th>GitHub preview: Output</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Bare <code>name:</code> <em>(no closing tag)</em></td>
      <td><span class="pill yes">Yes</span></td>
      <td><span class="pill shown">Bold</span></td>
      <td>Markdown/HTML</td>
      <td>Raw text <code>name:</code></td>
      <td>Rendered Markdown</td>
    </tr>
    <tr>
      <td><code>&lt;!-- name: --&gt;</code> … <code>&lt;!-- :name --&gt;</code></td>
      <td><span class="pill yes">Yes</span></td>
      <td><span class="pill hidden">Hidden</span></td>
      <td>Markdown/HTML</td>
      <td><span class="pill hidden">Hidden</span></td>
      <td>Rendered Markdown</td>
    </tr>
    <tr>
      <td><code>&lt;&#123; name: &#125;&gt;</code> … <code>&lt;&#123; :name &#125;&gt;</code></td>
      <td><span class="pill no">No</span></td>
      <td><span class="pill hidden">Hidden</span></td>
      <td>Markdown/HTML</td>
      <td>Raw text <code>&lt;&#123; name: &#125;&gt;</code></td>
      <td>Raw text <code>&lt;&#123; name: &#125;&gt;</code></td>
    </tr>
  </tbody>
</table>

1. Bare directives work in [Raindown files](/docs/file-types) (`.rd`) and in Markdown files (`.md`) with `raindown: true` front matter or `--bare` via the CLI.
2. All directive types can output custom HTML or Markdown that is rendered to HTML, it's up to you to choose per component. See [Components](/docs/components)
