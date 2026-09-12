# APK Cloud Build — current status

The complete Unity v26.2 source payload is now embedded in this repository under:

`.ci/source_chunks/part000.b64` ~ `part003.b64`

The Android workflow reconstructs the source, verifies SHA-256, extracts the Unity project, builds an ARM64 IL2CPP Development APK, and uploads the result as a GitHub Actions artifact.

## Confirmed

- Source payload embedded: DONE
- Source archive SHA-256: `767ca4faa9cd0005c247fbaeb5a18e73e4b679f123133c2003b4ef79141fc303`
- Workflow installed: DONE
- Unity version: `6000.3.6f1`
- Android target: ARM64 / IL2CPP / Development APK
- Artifact name: `ZodiacRandomDefense-v26-cloud-dev-apk`
- APK name: `ZodiacRandomDefense-v26-cloud-dev.apk`

## Current blocker — GitHub-hosted runner

A minimal workflow containing only `echo` was tested and failed before GitHub assigned a runner (`runner_id=0`, no steps executed). This confirms the current blocker is the GitHub Actions runner/account state, not Unity or the game source.

Check:

1. Repository → `Settings` → `Actions` → `General`
   - Ensure Actions are enabled for the repository.
   - Allow the actions used by the workflow (`actions/*`, `game-ci/*`, `jlumbroso/*`).
2. GitHub account → `Settings` → `Billing & licensing` / `Usage`
   - Check remaining Actions minutes and spending/payment status for private repositories.

GitHub-hosted standard runners consume the private-repository Actions allowance. If the allowance is exhausted and additional usage is blocked, jobs cannot start.

## Unity license secrets

Once runners are available, configure these only in:

`Repository Settings → Secrets and variables → Actions`

### Unity Personal

- `UNITY_LICENSE` — full contents of the Unity `.ulf` license file
- `UNITY_EMAIL`
- `UNITY_PASSWORD`

### Unity Pro

- `UNITY_SERIAL`
- `UNITY_EMAIL`
- `UNITY_PASSWORD`

Never paste these secret values into source files or chat.

## Build

After runner access and secrets are ready:

`Actions → Build Android Development APK → Run workflow`

Successful output:

- Artifact: `ZodiacRandomDefense-v26-cloud-dev-apk`
- APK: `ZodiacRandomDefense-v26-cloud-dev.apk`
