# frozen_string_literal: true

require 'erb'

# The Markdown example file from the raindown repo, with bare directives, shown on the home page, then the other ways
# to write a directive side by side: in HTML comments, hidden, and in Deerheads, only in the HTML, and a table of them.
class Examples
  Example = Data.define(:file, :language, :summary, :code)

  FILES = [['markdown.md', 'markdown', 'Markdown with `raindown: true` and bare directives']].freeze
  ALTERNATIVES = [
    ['html-comments.md', 'markdown', 'HTML comments hide directives'],
    ['deerheads.md', 'markdown', 'Deerheads only output to HTML']
  ].freeze

  # The table of the ways a directive can be written, and what each does, as HTML.
  def self.syntax = Raindown.render(markdown: File.read(File.expand_path('app/home/syntax.md', Dir.pwd), encoding: Encoding::UTF_8))

  def self.all(files = FILES)
    files.map do |file, language, summary|
      code = File.read(File.expand_path("public/examples/#{file}", Dir.pwd), encoding: Encoding::UTF_8).chomp
      Example.new(file:, language:, summary:, code: ERB::Util.html_escape(code))
    end
  end
end
