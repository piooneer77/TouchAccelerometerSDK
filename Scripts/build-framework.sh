#!/bin/bash

# Configuration
FRAMEWORK_NAME="TouchAccelerometerSDK"
ARCHIVE_REPO_PATH="../${FRAMEWORK_NAME}Archives"
BUILD_DIR="build"
CURRENT_DATE=$(date +%Y%m%d_%H%M%S)
ARCHIVE_DIR="${ARCHIVE_REPO_PATH}/TouchAccelerometerSDKArchives/Sources/TouchAccelerometerSDKArchives/archives"

# Ensure archive repo directory exists
mkdir -p "${ARCHIVE_DIR}"

# Clean previous build
rm -rf ${BUILD_DIR}
mkdir ${BUILD_DIR}

# Archive for iOS devices (arm64)
xcodebuild archive \
    -scheme ${FRAMEWORK_NAME} \
    -configuration Release \
    -destination "generic/platform=iOS" \
    -archivePath "${BUILD_DIR}/ios.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

# Archive for iOS Simulator (arm64 & x86_64)
xcodebuild archive \
    -scheme ${FRAMEWORK_NAME} \
    -configuration Release \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "${BUILD_DIR}/iossimulator.xcarchive" \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    SKIP_INSTALL=NO

rm -rf ${RCHIVE_DIR}

# Create XCFramework combining both archives
xcodebuild -create-xcframework \
    -framework ${BUILD_DIR}/ios.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
    -framework ${BUILD_DIR}/iossimulator.xcarchive/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
    -output "${ARCHIVE_DIR}/${FRAMEWORK_NAME}.xcframework"

# Copy archives to archive repo uncomment if needed in development.
# cp -R ${BUILD_DIR}/ios.xcarchive "${ARCHIVE_DIR}/ios.xcarchive"
# cp -R ${BUILD_DIR}/iossimulator.xcarchive "${ARCHIVE_DIR}/iossimulator.xcarchive"

# Clean up build directory
rm -rf ${BUILD_DIR}

# If running as part of git hook, commit and push changes
if [ "$1" == "hook" ]; then
    cd "${ARCHIVE_REPO_PATH}"
    git add .
    git commit -m "Archive build for commit $(cd - > /dev/null && git rev-parse HEAD)"
    git push
    cd - > /dev/null
fi