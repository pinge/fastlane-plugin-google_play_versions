# frozen_string_literal: true

require "fastlane/plugin/google_play_versions/version"

module Fastlane
  module GooglePlayVersions
    # Autoload all Ruby files in actions and helper directories
    def self.all_classes
      Dir[File.expand_path("**/{actions,helper}/*.rb", __dir__)].sort.each do |file|
        require file
      end
    end
  end
end

Fastlane::GooglePlayVersions.all_classes
