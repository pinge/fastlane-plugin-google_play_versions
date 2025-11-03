# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fastlane/plugin/google_play_versions/version"

Gem::Specification.new do |spec|
  spec.name = "fastlane-plugin-google_play_versions"
  spec.version = Fastlane::GooglePlayVersions::VERSION
  spec.authors = ["Nuno Pinge"]
  spec.email = ["nuno@pinge.org"]

  spec.summary = "Fastlane plugin to fetch build version codes accurately from the Play Store, including archived builds"
  spec.description = "Fetch build version codes accurately for a Play Store track from within Fastlane."
  spec.homepage = "https://github.com/pinge/fastlane-plugin-google_play_versions"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/pinge/fastlane-plugin-google_play_versions/CHANGELOG.md"

  spec.files = Dir["lib/**/*", "fastlane/**/*", "README.md", "LICENSE", "Rakefile"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "fastlane", ">= 2.96.0"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "standard"
end
