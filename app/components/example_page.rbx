# frozen_string_literal: true

# An example file on the home page, as a page with its name and a summary above its code, with line numbers.
class ExamplePage < LowNode
  def render(event:, example:)
    <figure class="page">
      <figcaption>
        <span class="file"><i class="bi bi-file-earmark-text"></i>{example.file}</span>
        <span class="summary">{example.summary}</span>
      </figcaption>
      <pre class="line-numbers"><code class="language-{example.language}"><{ example.code }></code></pre>
    </figure>
  end
end
