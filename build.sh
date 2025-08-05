#!/bin/bash

APP_NAME="ScriptLauncher"
BUNDLE_ID="com.peter.scriptlauncher"

echo "Building $APP_NAME.app..."

# Create app bundle structure
rm -rf "$APP_NAME.app"
mkdir -p "$APP_NAME.app/Contents/MacOS"
mkdir -p "$APP_NAME.app/Contents/Resources"

# Compile Swift code
swiftc ScriptLauncher/Sources/main.swift \
    -o "$APP_NAME.app/Contents/MacOS/$APP_NAME" \
    -framework SwiftUI \
    -framework Foundation \
    -framework AppKit \
    -target arm64-apple-macos11.0 \
    -parse-as-library \
    -Osize

# Check if compilation succeeded
if [ $? -ne 0 ]; then
    echo "❌ Compilation failed"
    exit 1
fi

# Copy icon if it exists
if [ -f "ScriptLauncher.icns" ]; then
    cp "ScriptLauncher.icns" "$APP_NAME.app/Contents/Resources/$APP_NAME.icns"
fi

# Create Info.plist
cat > "$APP_NAME.app/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundleDisplayName</key>
    <string>Script Launcher</string>
    <key>CFBundleVersion</key>
    <string>2.5</string>
    <key>CFBundleShortVersionString</key>
    <string>2.5</string>
    <key>LSMinimumSystemVersion</key>
    <string>11.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleIconFile</key>
    <string>$APP_NAME.icns</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>LSUIElement</key>
    <false/>
</dict>
</plist>
EOF

# No need to copy scripts.json anymore - it's per-project now

# Make executable
chmod +x "$APP_NAME.app/Contents/MacOS/$APP_NAME"

echo "✅ Build complete! $APP_NAME.app created"
echo ""
echo "To install to Applications folder:"
echo "  ./install.sh"
echo ""
echo "Or manually:"
echo "  1. Drag $APP_NAME.app to /Applications"
echo "  2. Add to dock for easy access"