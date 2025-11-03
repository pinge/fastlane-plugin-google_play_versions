# frozen_string_literal: true

module Fastlane
  module Actions
    class GooglePlayTrackVersionCodeAction < Action
      # Supply::Options.available_options keys that apply to this action.
      OPTIONS = [
        :package_name,
        :track,
        :key,
        :issuer,
        :json_key,
        :json_key_data,
        :root_url,
        :timeout
      ]

      def self.run(params)
        config = params || FastlaneCore::Configuration.create(available_options, {})
        track_version_codes = other_action.google_play_track_version_codes(
          package_name: params[:package_name],
          track: params[:track]
        )
        aab_version_codes = Helper::GooglePlayVersionsHelper.aab_version_codes(config)
        if aab_version_codes.empty? && track_version_codes.empty?
          UI.important("Could not find any app bundles with version codes on the '#{params[:track]}' track")
          return 0
        end
        version_code = (track_version_codes + aab_version_codes).max
        UI.success("Found '#{version_code}' as the latest version code on the '#{params[:track]}' track")
        version_code
      end

      def self.description
        "Fetch the most recent build version code from a Play Store track from within Fastlane."
      end

      def self.details
        "Use this action to fetch the highest build version code from a Play Store track, including version codes from builds that are archived."
      end

      def self.return_value
        "Integer with the latest build version code (integer or nil)"
      end

      def self.authors
        ["Nuno Pinge"]
      end

      def self.available_options
        require "supply"
        require "supply/options"

        Supply::Options.available_options.select do |option|
          OPTIONS.include?(option.key)
        end
      end

      def self.example_code
        [
          'google_play_track_version_code(
            package_name: \'com.example\',
            track: \'production\'
          )'
        ]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
