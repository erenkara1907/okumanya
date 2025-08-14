#!/bin/bash
set -e

# Build iOS script for Okumanya
echo "🍎 Building iOS app..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Configuration
BUILD_TYPE=${1:-"debug"}  # debug, profile, release
CODESIGN=${2:-"false"}    # true, false

echo -e "${YELLOW}Build Configuration:${NC}"
echo "- Type: $BUILD_TYPE"
echo "- Code Signing: $CODESIGN"
echo ""

# Validate build type
if [[ ! "$BUILD_TYPE" =~ ^(debug|profile|release)$ ]]; then
    echo -e "${RED}❌ Invalid build type: $BUILD_TYPE${NC}"
    echo "Valid options: debug, profile, release"
    exit 1
fi

# Check if on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}❌ iOS builds require macOS${NC}"
    exit 1
fi

# Clean previous builds
echo -e "${YELLOW}🧹 Cleaning previous builds...${NC}"
flutter clean
cd ios && rm -rf build/ && cd ..

# Get dependencies
echo -e "${YELLOW}📦 Getting Flutter dependencies...${NC}"
flutter pub get

# Run code generation
echo -e "${YELLOW}🔧 Running code generation...${NC}"
dart run build_runner build --delete-conflicting-outputs

# Install iOS dependencies
echo -e "${YELLOW}🍎 Installing iOS dependencies...${NC}"
cd ios
pod install --repo-update
cd ..

# Build iOS app
echo -e "${YELLOW}🏗️ Building iOS app in $BUILD_TYPE mode...${NC}"

if [ "$CODESIGN" = "true" ]; then
    # Check for required signing files
    if [ ! -f "ios/ExportOptions.plist" ]; then
        echo -e "${RED}❌ Missing ios/ExportOptions.plist for signed build${NC}"
        echo "Please configure the ExportOptions.plist file"
        exit 1
    fi
    
    flutter build ios --$BUILD_TYPE
    
    # Create archive
    echo -e "${YELLOW}📦 Creating iOS archive...${NC}"
    cd ios
    xcodebuild -workspace Runner.xcworkspace \
               -scheme Runner \
               -configuration Release \
               -destination generic/platform=iOS \
               archive \
               -archivePath build/Runner.xcarchive
    
    # Export IPA
    echo -e "${YELLOW}📱 Exporting IPA...${NC}"
    xcodebuild -exportArchive \
               -archivePath build/Runner.xcarchive \
               -exportOptionsPlist ExportOptions.plist \
               -exportPath ../build/ios/iphoneos/
    
    cd ..
    echo -e "${GREEN}✅ iOS build with code signing completed!${NC}"
    echo "📁 Output location: build/ios/iphoneos/"
    ls -la build/ios/iphoneos/*.ipa 2>/dev/null || echo "No IPA files found"
else
    flutter build ios --$BUILD_TYPE --no-codesign
    echo -e "${GREEN}✅ iOS build (no code signing) completed!${NC}"
    echo "📁 Output location: build/ios/iphoneos/"
    ls -la build/ios/iphoneos/ 2>/dev/null || echo "Build artifacts in build/ios/iphoneos/"
fi

# Show build information
echo ""
echo -e "${YELLOW}📊 Build Information:${NC}"
if [ -d "build/ios/iphoneos" ]; then
    echo "Build directory contents:"
    ls -la build/ios/iphoneos/
fi

echo ""
echo -e "${GREEN}🎉 iOS build process completed successfully!${NC}"