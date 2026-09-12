# APK Cloud Build — remaining 2 steps

The GitHub Actions workflow is installed and has already triggered successfully. The current failure is intentional: the build payload and Unity license secrets are not present yet.

## Step 1 — upload the build payload

Download from the ChatGPT conversation and upload to the repository root **without renaming**:

`AnimalRandomDefense_v26_2_CLOUD_APK_BUILD.zip`

Expected SHA-256:

`a69ae77198798496970a3668eaee3f202d86effa1566135e401c6918fc2a8039`

Uploading this exact file to `main` automatically triggers the APK workflow.

## Step 2 — add Unity license secrets

GitHub → `Settings` → `Secrets and variables` → `Actions` → `New repository secret`

### Unity Personal

Add all three:

- `UNITY_LICENSE` — full contents of your `.ulf` Unity license file
- `UNITY_EMAIL` — Unity account email
- `UNITY_PASSWORD` — Unity account password

### Unity Pro

Add:

- `UNITY_SERIAL`
- `UNITY_EMAIL`
- `UNITY_PASSWORD`

Do not commit these values into the repository.

## Build result

When both steps are complete the workflow builds:

`ZodiacRandomDefense-v26-cloud-dev.apk`

Artifact name:

`ZodiacRandomDefense-v26-cloud-dev-apk`

The workflow is configured for Unity `6000.3.6f1`, Android APK, ARM64, IL2CPP, Development Build.
