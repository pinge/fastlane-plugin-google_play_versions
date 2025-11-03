# frozen_string_literal: true

require "spec_helper"

describe Fastlane::Actions::GooglePlayTrackVersionCodeAction do
  describe ".run" do
    let(:params) { {package_name: "com.example.app", track: "production"} }
    let(:track_version_codes) { [18874901, 18874902] }
    let(:aab_version_codes) { [18874903, 18874900] }
    let(:other_action_double) { instance_double("OtherAction") }

    it "returns the highest version code for a Google Play track, including archived app bundles" do
      allow(described_class).to receive(:other_action).and_return(other_action_double)
      allow(Fastlane::UI).to receive(:success)

      expect(other_action_double).to receive(:google_play_track_version_codes)
        .with(package_name: params[:package_name], track: params[:track])
        .and_return(track_version_codes)

      expect(Fastlane::Helper::GooglePlayVersionsHelper).to receive(:aab_version_codes)
        .with(params)
        .and_return(aab_version_codes)

      expect(Fastlane::UI).to receive(:success)
        .with("Found '#{aab_version_codes.first}' as the latest version code on the 'production' track")

      result = described_class.run(params)

      expect(result).to eq(aab_version_codes.first)
    end

    # from https://developer.android.com/studio/publish/versioning.html
    # versionCode: A positive integer used as an internal version number. This number helps determine whether one
    #              version is more recent than another, with higher numbers indicating more recent versions. This
    #              is not the version number shown to users; that number is set by the versionName setting.
    #              The Android system uses the versionCode value to protect against downgrades by preventing users
    #              from installing an APK with a lower versionCode than the version currently installed on their device.
    # return 0 when no app bundles are present. the version code can then be incremented to become a positive integer.
    it "returns 0 when no version codes exist" do
      allow(described_class).to receive(:other_action).and_return(other_action_double)
      allow(Fastlane::UI).to receive(:success)

      expect(other_action_double).to receive(:google_play_track_version_codes)
        .with(package_name: params[:package_name], track: params[:track])
        .and_return([])

      expect(Fastlane::Helper::GooglePlayVersionsHelper).to receive(:aab_version_codes)
        .with(params)
        .and_return([])

      expect(Fastlane::UI).to receive(:important)
        .with("Could not find any app bundles with version codes on the '#{params[:track]}' track")

      expect(described_class.run(params)).to eq(0)
    end
  end
end
