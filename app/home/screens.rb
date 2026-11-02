# frozen_string_literal: true

# Screenshots of Raindown's terminal UI, in public/screens, as tabs on the home page, each with what it shows. The raindown
# repo's bin/screens opens each one, ready to screenshot.
class Screens
  Screen = Data.define(:name, :label, :caption)

  SCREENS = [
    ['dashboard', 'Dashboard', 'Every chart and stat in the project, each in a card under its file and heading.'],
    ['outlines', 'Outlines', 'A project\'s files beside the open file\'s headings and directives, which fold open.'],
    ['endpoints', 'Endpoints', 'Every endpoint in the project, by its request, which runs with x, showing its response.'],
    ['feelings', 'Code feelings', 'The code\'s methods as digits, to sort how each makes you feel, from frolic to malice.'],
    ['blueprints', 'Blueprints', 'Diagrams from Claude Code\'s replies and the code\'s comments, each box traced to its code.']
  ].freeze

  def self.all = SCREENS.map { |name, label, caption| Screen.new(name:, label:, caption:) }
end
