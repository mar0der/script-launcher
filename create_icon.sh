#!/bin/bash

# Convert icon_clean.png to ScriptLauncher.icns
# This script creates the app icon from the cleaned PNG file

INPUT_PNG="icon_clean.png"
ICONSET_NAME="ScriptLauncher.iconset"

if [ ! -f "$INPUT_PNG" ]; then
    echo "❌ Error: $INPUT_PNG not found!"
    echo "Please ensure icon_clean.png exists in the project directory"
    exit 1
fi

echo "Converting $INPUT_PNG to ScriptLauncher.icns..."

# Create iconset directory
rm -rf "$ICONSET_NAME"
mkdir "$ICONSET_NAME"

# Generate all required icon sizes (silent output)
sips -z 16 16     "$INPUT_PNG" --out "$ICONSET_NAME/icon_16x16.png" >/dev/null 2>&1
sips -z 32 32     "$INPUT_PNG" --out "$ICONSET_NAME/icon_16x16@2x.png" >/dev/null 2>&1
sips -z 32 32     "$INPUT_PNG" --out "$ICONSET_NAME/icon_32x32.png" >/dev/null 2>&1
sips -z 64 64     "$INPUT_PNG" --out "$ICONSET_NAME/icon_32x32@2x.png" >/dev/null 2>&1
sips -z 128 128   "$INPUT_PNG" --out "$ICONSET_NAME/icon_128x128.png" >/dev/null 2>&1
sips -z 256 256   "$INPUT_PNG" --out "$ICONSET_NAME/icon_128x128@2x.png" >/dev/null 2>&1
sips -z 256 256   "$INPUT_PNG" --out "$ICONSET_NAME/icon_256x256.png" >/dev/null 2>&1
sips -z 512 512   "$INPUT_PNG" --out "$ICONSET_NAME/icon_256x256@2x.png" >/dev/null 2>&1
sips -z 512 512   "$INPUT_PNG" --out "$ICONSET_NAME/icon_512x512.png" >/dev/null 2>&1
sips -z 1024 1024 "$INPUT_PNG" --out "$ICONSET_NAME/icon_512x512@2x.png" >/dev/null 2>&1

# Convert to icns
iconutil -c icns "$ICONSET_NAME"

# Clean up
rm -rf "$ICONSET_NAME"

echo "✅ Created ScriptLauncher.icns from $INPUT_PNG"