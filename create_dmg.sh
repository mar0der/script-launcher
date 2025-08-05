#!/bin/bash

# Create styled DMG installer for Script Launcher

APP_NAME="ScriptLauncher"
DMG_NAME="ScriptLauncher"
VOLUME_NAME="Script Launcher"
TEMP_DMG="temp.dmg"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if app exists
if [ ! -d "$APP_NAME.app" ]; then
    echo -e "${RED}❌ $APP_NAME.app not found. Run ./build.sh first.${NC}"
    exit 1
fi

echo -e "${BLUE}Creating styled DMG installer...${NC}"

# Create a temporary directory for the DMG contents
TEMP_DIR=$(mktemp -d)
echo "Using temp directory: $TEMP_DIR"

# Copy the app to temp directory
echo "Copying $APP_NAME.app..."
cp -R "$APP_NAME.app" "$TEMP_DIR/"

# Create a symbolic link to /Applications
echo "Creating Applications symlink..."
ln -s /Applications "$TEMP_DIR/Applications"

# Create temporary DMG
echo "Creating temporary DMG..."
rm -f "$TEMP_DMG"
hdiutil create -volname "$VOLUME_NAME" \
    -srcfolder "$TEMP_DIR" \
    -ov \
    -format UDRW \
    -size 50m \
    "$TEMP_DMG"

# Clean up temp directory
rm -rf "$TEMP_DIR"

# Mount the temporary DMG
echo "Mounting DMG for styling..."
DEVICE=$(hdiutil attach -readwrite -noverify -noautoopen "$TEMP_DMG" | \
         grep '^/dev/' | sed 1q | awk '{print $1}')

echo "Mounted at device: $DEVICE"
sleep 2

# Apply window styling
echo "Applying window styling..."
osascript setup_dmg_window.applescript "$VOLUME_NAME" 2>/dev/null || {
    echo "Note: Window styling requires Finder automation permission"
}

# Give Finder time to save settings
sleep 3

# Unmount
echo "Unmounting styled DMG..."
hdiutil detach "$DEVICE" -quiet

# Convert to compressed DMG
echo "Creating final compressed DMG..."
rm -f "$DMG_NAME.dmg"
hdiutil convert "$TEMP_DMG" \
    -format UDZO \
    -imagekey zlib-level=9 \
    -o "$DMG_NAME.dmg"

# Clean up
rm -f "$TEMP_DMG"

if [ -f "$DMG_NAME.dmg" ]; then
    echo -e "${GREEN}✅ Created $DMG_NAME.dmg successfully!${NC}"
    echo ""
    echo "To install Script Launcher:"
    echo "1. Double-click $DMG_NAME.dmg"
    echo "2. Drag Script Launcher to Applications folder"
    echo "3. Eject the disk image"
    
    # Get DMG size and version
    DMG_SIZE=$(du -h "$DMG_NAME.dmg" | cut -f1)
    VERSION=$(defaults read "$APP_NAME.app/Contents/Info.plist" CFBundleShortVersionString)
    echo ""
    echo "DMG size: $DMG_SIZE"
    echo "App version: $VERSION"
else
    echo -e "${RED}❌ Failed to create DMG${NC}"
    exit 1
fi