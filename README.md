# Zodiac Random Defense — Cloud APK Build

`Animaldefense` is configured to build the Android Development APK in GitHub Actions with GameCI.

## 1. Upload one project archive

Upload this file to the repository root **without renaming it**:

`AnimalRandomDefense_v26_2_CLOUD_APK_BUILD.zip`

The file is provided in the ChatGPT conversation.

## 2. Configure Unity license secrets

Go to:

`Settings → Secrets and variables → Actions → New repository secret`

For Unity Personal, GameCI's current guidance is to activate a Personal license in Unity Hub and copy the contents of the generated `.ulf` license file. Add:

- `UNITY_LICENSE` — full contents of `Unity_lic.ulf`
- `UNITY_EMAIL` — Unity account email
- `UNITY_PASSWORD` — Unity account password

For Unity Pro, use `UNITY_SERIAL`, `UNITY_EMAIL`, `UNITY_PASSWORD` instead.

## 3. Run the APK build

Go to:

`Actions → Build Android Development APK → Run workflow → Run workflow`

The workflow extracts the uploaded Unity project and builds with:

- Unity `6000.3.6f1`
- Android
- ARM64
- IL2CPP
- Development Build
- Portrait

## 4. Download the APK

After the workflow succeeds, open the workflow run and download the artifact:

`ZodiacRandomDefense-v26-cloud-dev-apk`

Inside it:

`ZodiacRandomDefense-v26-cloud-dev.apk`

Install that APK on the Android device for testing.

## Notes

The cloud build uses the development Mock Rewarded adapter so the game can be tested before final LevelPlay production integration.
