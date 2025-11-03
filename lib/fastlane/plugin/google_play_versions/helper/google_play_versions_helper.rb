# frozen_string_literal: true

require "supply"
require "supply/client"

module Fastlane
  module Helper
    class GooglePlayVersionsHelper
      def self.aab_version_codes(params)
        Supply.config = params
        client = Supply::Client.make_from_config
        client.begin_edit(package_name: Supply.config[:package_name])
        version_codes = client.aab_version_codes
        client.abort_current_edit
        if version_codes.empty?
          UI.important("No version codes found on '#{params[:track]}' track for #{params[:package_name]}")
        else
          UI.message("Found '#{version_codes.max} ... #{version_codes.min}' version codes on '#{params[:track]}' track (#{version_codes.size})")
        end
        version_codes
      end
    end
  end
end
