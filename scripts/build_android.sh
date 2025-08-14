#!/bin/bash
set -e

# Build Android script for Okumanya
echo "🚀 Building Android app..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Configuration
BUILD_TYPE=${1:-"debug"}  # debug, profile, release
BUILD_FORMAT=${2:-"apk"}  # apk, appbundle

echo -e "${YELLOW}Build Configuration:${NC}"
echo "- Type: $BUILD_TYPE"
echo "- Format: $BUILD_FORMAT"
echo ""

# Validate build type
if [[ ! "$BUILD_TYPE" =~ ^(debug|profile|release)$ ]]; then
    echo -e "${RED}❌ Invalid build type: $BUILD_TYPE${NC}"
    echo "Valid options: debug, profile, release"
    exit 1
fi

# Validate build format
if [[ ! "$BUILD_FORMAT" =~ ^(apk|appbundle)$ ]]; then
    echo -e "${RED}❌ Invalid build format: $BUILD_FORMAT${NC}"
    echo "Valid options: apk, appbundle"
    exit 1
fi

# Clean previous builds
echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
flutter clean

# Get dependencies
echo -e "${YELLOW}📦 Getting dependencies...${NC}"
flutter pub get

# Run code generation
echo -e "${YELLOW}🔧 Running code generation...${NC}"
dart run build_runner build --delete-conflicting-outputs

# Check if keystore exists for release builds
if [ "$BUILD_TYPE" = "release" ] && [ ! -f "android/key.properties" ]; then
    echo -e "${RED}❌ Missing android/key.properties for release build${NC}"
    echo "Please create the file from android/key.properties.example"
    exit 1
fi

# Build based on type and format
echo -e "${YELLOW}🏗️ Building $BUILD_FORMAT in $BUILD_TYPE mode...${NC}"

if [ "$BUILD_FORMAT" = "apk" ]; then
    flutter build apk --$BUILD_TYPE --split-per-abi
    echo -e "${GREEN}✅ APK build completed!${NC}"
    echo "📁 Output location: build/app/outputs/flutter-apk/"
    ls -la build/app/outputs/flutter-apk/*.apk
else
    flutter build appbundle --$BUILD_TYPE
    echo -e "${GREEN}✅ App Bundle build completed!${NC}"
    echo "📁 Output location: build/app/outputs/bundle/$BUILD_TYPE/"
    ls -la build/app/outputs/bundle/$BUILD_TYPE/*.aab
fi

# Show build size
echo ""
echo -e "${YELLOW}📊 Build Size Information:${NC}"
if [ "$BUILD_FORMAT" = "apk" ]; then
    for apk in build/app/outputs/flutter-apk/*.apk; do
        if [ -f "$apk" ]; then
            size=$(ls -lh "$apk" | awk '{print $5}')
            echo "$(basename "$apk"): $size"
        fi
    done
else
    for aab in build/app/outputs/bundle/$BUILD_TYPE/*.aab; do
        if [ -f "$aab" ]; then
            size=$(ls -lh "$aab" | awk '{print $5}')
            echo "$(basename "$aab"): $size"
        fi
    done
fi

echo ""
echo -e "${GREEN}🎉 Android build process completed successfully!${NC}"