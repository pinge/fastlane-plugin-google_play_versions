# frozen_string_literal: true

require "spec_helper"

describe Fastlane::Helper::GooglePlayVersionsHelper do
  describe ".aab_version_codes" do
    let(:params) { {package_name: "com.example.app", track: "internal"} }
    let(:client) { instance_double("Supply::Client") }

    before do
      allow(Supply::Client).to receive(:make_from_config).and_return(client)
      allow(client).to receive(:begin_edit)
      allow(client).to receive(:aab_version_codes).and_return(version_codes)
      allow(client).to receive(:abort_current_edit)
      allow(Fastlane::UI).to receive(:message)
      allow(Fastlane::UI).to receive(:important)
    end

    around do |example|
      original_config = Supply.respond_to?(:config) ? Supply.config : nil
      example.run
    ensure
      Supply.config = original_config if Supply.respond_to?(:config=)
    end

    context "when app bundles exist in the Google Play track" do
      let(:version_codes) { [16770003, 16770002, 16770001] }

      it "returns an array of their version codes" do
        result = described_class.aab_version_codes(params)
        expect(result).to eq(version_codes)
        expect(client).to have_received(:begin_edit)
          .with(package_name: params[:package_name])
        expect(client).to have_received(:aab_version_codes)
        expect(client).to have_received(:abort_current_edit)
        expect(Fastlane::UI).to have_received(:message)
          .with("Found '#{version_codes.max} ... #{version_codes.min}' version codes on '#{params[:track]}' track (#{version_codes.size})")
        expect(Fastlane::UI).not_to have_received(:important)
      end
    end

    context "when no app bundles exist in the Google Play track" do
      let(:version_codes) { [] }

      it "returns an empty array" do
        result = described_class.aab_version_codes(params)

        expect(result).to eq(version_codes)
        expect(client).to have_received(:begin_edit)
          .with(package_name: params[:package_name])
        expect(client).to have_received(:aab_version_codes)
        expect(client).to have_received(:abort_current_edit)
        expect(Fastlane::UI).not_to have_received(:message)
        expect(Fastlane::UI).to have_received(:important)
          .with("No version codes found on '#{params[:track]}' track for #{params[:package_name]}")
      end
    end
  end
end
