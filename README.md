# fastlane-plugin-google_play_versions

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-google_play_versions)

Simple [fastlane](https://fastlane.tools/) plugin to fetch build version codes from a Play Store track, including rollout releases that have been halted or app bundles that have been archived.

## Getting Started

Add the plugin to your project:

```bash
bundle exec fastlane add_plugin google_play_versions
```

## Usage

```ruby
lane :release do
  track_version_code = google_play_track_version_code(
    package_name: package_name,
    track: google_play_track
  )
  android_set_version_code(version_code: track_version_code + 1)
end
```

The action uses [Supply](https://docs.fastlane.tools/actions/supply/) to connect to the Play Store and lookup the highest app bundle version code for the track
parameter. It also checks app bundles from archived or halted releases, allowing your workflows to avoid getting a Play Store API error when uploading an app bundle with a version code that already exists. This is not supported by [`google_play_track_version_codes()`](https://docs.fastlane.tools/actions/google_play_track_version_codes/), which only retrieves the version codes on a track.

### Available options

This action supports a subset of Supply's available options.

| Option          | Description                                         | Default   |
|-----------------|-----------------------------------------------------|-----------|
| `package_name`  | The package name of the application to use          | current directory |
| `track`         | The track of the application to use. The default available tracks are: production, beta, alpha, internal           | `production` |
| `json_key`      | The path to a file containing service account JSON, used to authenticate with Google           | * |
| `json_key_data` | The raw service account JSON data used to authenticate with Google           | * |
| `root_url`      | Root URL for the Google Play API. The provided URL will be used for API calls in place of https://www.googleapis.com/           | * |
| `timeout`       | Timeout for read, open, and send (in seconds)       | 300 |

*\* = default value is dependent on the user's system*

Run `bundle exec fastlane action google_play_versions` for details.

## Development

1. Run `bundle install` to install dependencies.
2. Use `bundle exec rspec` to run the test suite.

## Issues and Contributions

Please create a GitHub issue if you run into a problem or have a feature request. Pull requests are always welcome.

## References

- https://developer.android.com/google/play/publishing/multiple-apks#VersionCodes
- https://developer.android.com/build/configure-apk-splits
