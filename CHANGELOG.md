# Changelog

All notable changes to Script Launcher will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.5] - 2025-08-05

### Added
- Copy output button with clipboard icon to copy script output
- Proper PATH environment for script execution

### Fixed
- npm/node "command not found" error (exit code 127) by running bash as login shell with `-l` flag
- Added common paths for npm installations including `/opt/homebrew/bin` for Apple Silicon Macs

## [2.4] - 2025-08-05

### Added
- Copy output button (initial implementation)

## [2.3] - 2025-08-05

### Added
- Run buttons for each script (no more accidental execution on click)
- Project name display in title bar and under Scripts header
- Improved Recent Projects menu showing "ProjectName — ParentFolder" format
- Toolbar shortcuts for Init (➕) and Load (📁) projects
- Enhanced LLM instructions in config files to guide AI assistants
- Info buttons (i) for scripts with long descriptions

### Changed
- Recent Projects now shows project names instead of config filenames
- Better visual hierarchy with project information

## [2.2] - 2025-08-05

### Added
- LLM instructions in config file template

## [2.1] - 2025-08-05

### Added
- Toolbar with Init and Load buttons
- Project name display

## [2.0] - 2025-08-05

### Added
- Run buttons instead of click-to-execute
- Visible descriptions in the UI
- Version number in About dialog

### Changed
- Complete UI overhaul for better usability

## [1.0] - 2025-08-05

### Added
- Initial release
- Basic script management and execution
- Project-based configuration
- Real-time output display
- Recent projects tracking