#!/usr/bin/env bash
set -euo pipefail

echo "[ARD UBA] Reconstructing Unity project before Build Automation starts..."

SOURCE_B64=".ci/uba-source.b64"
SOURCE_ARCHIVE=".ci/uba-source.tar.xz"
EXTRACT_ROOT=".ci/uba-extracted"
PROJECT="$EXTRACT_ROOT/AnimalRandomDefense_MVP"
EXPECTED_SHA256="dfad794a8ac75410ed013b007f35fcbb1746de69547cee53a1c2314f0df271b7"

FILES=(
  .ci/ci20/part000.b64
  .ci/ci20/part001a.b64
  .ci/ci20/part001b.b64
  .ci/ci20/part002.b64
  .ci/ci20/part003.b64
  .ci/ci20/part004.b64
  .ci/ci20/part005a.b64
  .ci/ci20/part005b.b64
  .ci/ci5/part006_00.b64
  .ci/ci5/part006_01.b64
  .ci/ci5/part006_02.b64
  .ci/ci5/part006_03.b64
  .ci/ci5/part007_00.b64
  .ci/ci5/part007_01.b64
  .ci/ci5/part007_02.b64
  .ci/ci5/part007_03.b64
)

for f in "${FILES[@]}"; do
  test -s "$f" || { echo "Missing source chunk: $f" >&2; exit 10; }
done

rm -rf "$SOURCE_B64" "$SOURCE_ARCHIVE" "$EXTRACT_ROOT"
mkdir -p .ci "$EXTRACT_ROOT"
cat "${FILES[@]}" | tr -d '\r\n' > "$SOURCE_B64"
test "$(wc -c < "$SOURCE_B64")" -eq 159048
base64 --decode "$SOURCE_B64" > "$SOURCE_ARCHIVE"
echo "$EXPECTED_SHA256  $SOURCE_ARCHIVE" | sha256sum -c -
xz -t "$SOURCE_ARCHIVE"
tar -xJf "$SOURCE_ARCHIVE" -C "$EXTRACT_ROOT"

test -f "$PROJECT/ProjectSettings/ProjectVersion.txt"
test -f "$PROJECT/Packages/manifest.json"
test -d "$PROJECT/Assets"
grep -q '6000.3.6f1' "$PROJECT/ProjectSettings/ProjectVersion.txt"

# Replace the small repository stubs with the complete Unity project.
rm -rf Assets Packages ProjectSettings
cp -a "$PROJECT/Assets" ./Assets
cp -a "$PROJECT/Packages" ./Packages
cp -a "$PROJECT/ProjectSettings" ./ProjectSettings

# Build Automation pre-export hook. It creates the bootstrap scene and applies
# the Android development-test settings immediately before Unity exports.
mkdir -p Assets/Editor
cat > Assets/Editor/BuildAutomationHooks.cs <<'CSHARP'
#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace AnimalRandomDefense.EditorBuild
{
    public static class BuildAutomationHooks
    {
        private const string ScenePath = "Assets/Scenes/Bootstrap.unity";

        public static void PreExport()
        {
            Debug.Log("[ARD UBA] Preparing Android development build...");

            PlayerSettings.productName = "십이지 랜덤 디펜스";
            PlayerSettings.companyName = "ARD Test Build";
            PlayerSettings.bundleVersion = "0.26.2-cloud-dev";
            PlayerSettings.defaultInterfaceOrientation = UIOrientation.Portrait;
            PlayerSettings.allowedAutorotateToPortrait = false;
            PlayerSettings.allowedAutorotateToPortraitUpsideDown = false;
            PlayerSettings.allowedAutorotateToLandscapeLeft = false;
            PlayerSettings.allowedAutorotateToLandscapeRight = false;
            PlayerSettings.SetApplicationIdentifier(BuildTargetGroup.Android, "com.ardtest.zodiacrandomdefense");
            PlayerSettings.Android.bundleVersionCode = 262;
            PlayerSettings.Android.targetArchitectures = AndroidArchitecture.ARM64;
            PlayerSettings.SetScriptingBackend(NamedBuildTarget.Android, ScriptingImplementation.IL2CPP);
            EditorUserBuildSettings.buildAppBundle = false;

            Directory.CreateDirectory(Path.GetDirectoryName(ScenePath));
            var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            if (!EditorSceneManager.SaveScene(scene, ScenePath))
                throw new System.Exception("Failed to save bootstrap scene: " + ScenePath);

            EditorBuildSettings.scenes = new[] { new EditorBuildSettingsScene(ScenePath, true) };
            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("[ARD UBA] PreExport ready: " + ScenePath);
        }
    }
}
#endif
CSHARP

echo "[ARD UBA] Unity project reconstruction complete."
find Assets Packages ProjectSettings -maxdepth 2 -type f | head -40
