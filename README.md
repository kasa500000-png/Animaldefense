# Zodiac Random Defense — Android Cloud Build

This private repository is prepared to build the Android Development APK for **십이지 랜덤 디펜스 / Zodiac Random Defense** using GitHub Actions + GameCI.

## Source

The Unity v26.2 project is embedded as four Base64 chunks under:

`.ci/source_chunks/`

The workflow reconstructs and verifies the source automatically. No project ZIP upload is required.

Source archive SHA-256:

`767ca4faa9cd0005c247fbaeb5a18e73e4b679f123133c2003b4ef79141fc303`

## Build configuration

- Unity: `6000.3.6f1`
- Android Development APK
- ARM64
- IL2CPP
- Portrait
- Development Mock Rewarded adapter enabled for testing

## Required GitHub Actions secrets

Configure only in `Settings → Secrets and variables → Actions`.

Unity Personal:
- `UNITY_LICENSE`
- `UNITY_EMAIL`
- `UNITY_PASSWORD`

Unity Pro:
- `UNITY_SERIAL`
- `UNITY_EMAIL`
- `UNITY_PASSWORD`

Do not commit credentials to the repository.

## Build output

Workflow:

`Actions → Build Android Development APK`

Expected artifact:

`ZodiacRandomDefense-v26-cloud-dev-apk`

Expected APK:

`ZodiacRandomDefense-v26-cloud-dev.apk`

## Current runner status

A minimal `ubuntu-latest` smoke workflow failed before a GitHub-hosted runner was assigned. See `CLOUD_APK_NEXT_STEPS.md` for the repository Actions/billing checks required before the APK workflow can run.
