# frozen_string_literal: true

class PageRenderer < LowNode
  observe '/*'

  def initialize(event:)
    page = Raindeer.pages.page(path: event.route.path) || return

    @path = event.route.path
    @html = page.html
    @title = page.metadata[:title]
    @use_case = page.metadata[:usecase]
    @published = @html && page.metadata[:published]
  end

  def render
    <{ if: @published }>
      <{ Layout: title=@title section='section-pages' path=@path }>
        <{ Sidebar }>

        <div id="content">
          <h1>{@title}</h1>
          <{ UseCase use_case=@use_case }>

          <{ @html }>
        </div>
      <{ :Layout }>
    <{ :if }>
  end
end
