# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "fastlane"
require "fastlane/plugin/google_play_versions"

Fastlane.load_actions

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end
