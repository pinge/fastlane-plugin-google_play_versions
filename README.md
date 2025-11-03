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

The action will use Supply under the hood to connect to the Play Store and lookup the highest build version code for the specified track.

### Available options

| Option         | Description                                         | Default   |
|----------------|-----------------------------------------------------|-----------|
| `package_name` | The package name of the application to use          | current directory |
| `track`        | The track of the application to use. The default available tracks are: production, beta, alpha, internal           | `production` |

Run `bundle exec fastlane action google_play_versions` for details.

## Development

1. Run `bundle install` to install dependencies.
2. Use `bundle exec rspec` to run the test suite.

## Issues and Contributions

Please create a GitHub issue if you run into a problem or have a feature request. Pull requests are always welcome.
