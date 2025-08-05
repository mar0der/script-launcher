#!/bin/bash

APP_NAME="ScriptLauncher"

# Check if app was built
if [ ! -d "$APP_NAME.app" ]; then
    echo "❌ $APP_NAME.app not found. Run ./build.sh first."
    exit 1
fi

# Copy to Applications
echo "Installing $APP_NAME.app to /Applications..."
rm -rf "/Applications/$APP_NAME.app"
cp -R "$APP_NAME.app" "/Applications/"

if [ $? -eq 0 ]; then
    echo "✅ Successfully installed to /Applications/$APP_NAME.app"
    echo ""
    echo "To add to dock:"
    echo "1. Open Finder and go to Applications"
    echo "2. Drag Script Launcher to your dock"
    echo ""
    echo "First time setup:"
    echo "1. Launch Script Launcher"
    echo "2. Click 'Init New Project' to create a config for a project"
    echo "3. Or 'Load Project' to open an existing .scriptlauncher.json"
else
    echo "❌ Installation failed. You may need to use sudo:"
    echo "  sudo ./install.sh"
fi