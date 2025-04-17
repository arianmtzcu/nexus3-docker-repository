#!/bin/bash

# === CONFIGURATION ===
GROUP_ID="com.example"
ARTIFACT_ID="demo"
VERSION="1.0.0-SNAPSHOT"
USERNAME="admin"
PASSWORD="nexus"

# === DETECT REPOSITORY BASED ON VERSION ===
if [[ "$VERSION" == *-SNAPSHOT ]]; then
  REPO_ID="nexus-snapshots"
  REPO_URL="http://localhost:8081/repository/nexus-snapshots"
else
  REPO_ID="nexus-releases"
  REPO_URL="http://localhost:8081/repository/nexus-releases"
fi

# === SET PROJECT AND ARTIFACT PATHS ===
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE_PATH="${PROJECT_DIR}/demo/build/libs"
POM_FILE="${PROJECT_DIR}/demo/pom.xml"

# === CONVERT GROUP_ID TO PATH ===
GROUP_PATH=$(echo "${GROUP_ID}" | tr '.' '/')
REMOTE_PATH="${REPO_URL}/${GROUP_PATH}/${ARTIFACT_ID}/${VERSION}"

echo "--> Publishing artifacts to: ${REMOTE_PATH}"

# === FUNCTION: UPLOAD FILE ===
upload_file() {
  local file=$1
  local remote_name=$2

  if [[ -f "$file" ]]; then
    echo ">>> Uploading ${remote_name}..."
    curl -v --user "${USERNAME}:${PASSWORD}" \
         --upload-file "$file" \
         "${REMOTE_PATH}/${remote_name}"
  else
    echo ">>> File not found: $file"
  fi
}

# === UPLOAD ARTIFACTS ===
upload_file "${BASE_PATH}/${ARTIFACT_ID}-${VERSION}.jar" "${ARTIFACT_ID}-${VERSION}.jar"
upload_file "${POM_FILE}" "${ARTIFACT_ID}-${VERSION}.pom"
upload_file "${BASE_PATH}/${ARTIFACT_ID}-${VERSION}-sources.jar" "${ARTIFACT_ID}-${VERSION}-sources.jar"
upload_file "${BASE_PATH}/${ARTIFACT_ID}-${VERSION}-javadoc.jar" "${ARTIFACT_ID}-${VERSION}-javadoc.jar"
