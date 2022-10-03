fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios release

```sh
[bundle exec] fastlane ios release
```

Sumbit app to App Store

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Package and submit a new version to TestFlight

### ios sync_certificates

```sh
[bundle exec] fastlane ios sync_certificates
```

Create/Update the certificates

### ios build_ipa

```sh
[bundle exec] fastlane ios build_ipa
```

Builds an .ipa file of the app

### ios build_bundle_identifier

```sh
[bundle exec] fastlane ios build_bundle_identifier
```

Build bundler identifier

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
