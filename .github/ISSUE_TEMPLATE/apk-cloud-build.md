---
name: APK Cloud Build
about: Track the Android development APK cloud build
---

## Source payload

- [x] Unity source embedded in `.ci/source_chunks/part000.b64` ~ `part003.b64`
- [x] Source SHA-256 expected: `767ca4faa9cd0005c247fbaeb5a18e73e4b679f123133c2003b4ef79141fc303`
- [x] Android cloud-build workflow installed

## GitHub runner

- [ ] Repository Actions are enabled in `Settings → Actions → General`
- [ ] GitHub-hosted runner usage is available for this private repository
- [ ] Actions minutes / billing status allows a standard `ubuntu-latest` runner to start

## Unity license secrets

- [ ] `UNITY_EMAIL` repository secret configured
- [ ] `UNITY_PASSWORD` repository secret configured
- [ ] Personal: `UNITY_LICENSE` configured OR Pro: `UNITY_SERIAL` configured

## Build

- [ ] `Build Android Development APK` workflow succeeds
- [ ] Artifact `ZodiacRandomDefense-v26-cloud-dev-apk` exists
- [ ] `ZodiacRandomDefense-v26-cloud-dev.apk` installs on Android device
- [ ] App launches and reaches lobby
- [ ] W1 battle starts
- [ ] Mock Rewarded test grants the 24-hour 2×/3× Speed Pass
