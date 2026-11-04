# frozen_string_literal: true

require 'net/http'
require 'json'

class Version < LowNode
  ENDPOINT = 'https://rubygems.org/api/v1/versions/raindown/latest.json'

  def initialize
    response = Net::HTTP.get(URI(ENDPOINT))
    @version = ::JSON.parse(response)['version']
  rescue StandardError
    # When RubyGems can't be reached.
    @version = nil
  end

  def render
    <ul id="releases">
      <{ if: @version }>
        <li>v{@version}</li>
      <{ :if }>
      <li><a href="https://github.com/rainpour/raindown/releases">{"Releases"}</a></li>
    </ul>
  end
end
