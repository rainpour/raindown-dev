# frozen_string_literal: true

# The use case for a page with "usecase: content" or "usecase: template" front matter.
class UseCase < LowNode
  def initialize(use_case:)
    @content = use_case == 'content'
    @template = use_case == 'template'
  end

  def render
    <{ if: @content }>
      <p><strong>Use case:</strong> <span class="pill yes">Content</span> - <em>Overwrites content it controls.</em></p>
    <{ :if }>

    <{ if: @template }>
      <p><strong>Use case:</strong> <span class="pill no">Template</span> - <em>Accepts content and renders to HTML only.</em></p>
    <{ :if }>
  end
end
