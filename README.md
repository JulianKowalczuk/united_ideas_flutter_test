# united_ideas_flutter_test

A new Flutter project.

## Additional steps to run app

### Set network policy to allow plaintext connections (should be only used for debugging)

https://flutter.dev/docs/release/breaking-changes/network-policy-ios-android#allowing-cleartext-connection-for-debug-builds

### Generate models

```sh
flutter packages pub run build_runner build
```

PS: it's not fully prepared for Xcode run, if files won't create automatically by IDE hook, use:

```sh
flutter create .
```
