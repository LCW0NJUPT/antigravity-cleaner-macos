# Technical Architecture

## Overview
Antigravity Cleaner (v3.0.0) is a native **PowerShell Automation Engine** designed to interface directly with the Windows File System and Registry to manage application states without external dependencies.

## Core Components

### 1. The Shell Engine (`Antigravity.ps1`)
*   **Runtime:** Windows PowerShell 5.1 / Core 7+
*   **State Management:** Stateless execution. Configuration is runtime-defined constants.
*   **UI Layer:** Host-based text UI with color-coded feedback (`Write-Host` wrappers).

### 2. Browser Hooking Mechanism
Instead of using heavy automation drivers (Selenium/Playwright), we use **File System Analysis**:
*   **Profile Detection:**
    *   Scans `%LOCALAPPDATA%` for Chromium-based browsers (Chrome, Edge, Brave).
    *   Parses `Local State` and `Preferences` JSON files to map Profile Folders (e.g., `Profile 14`) to User Accounts (e.g., `user@gmail.com`).
*   **Lock Handling:** Prompts before backup, stops the selected browser, verifies that it exited, and treats locked-file copy errors as backup failures rather than silently skipping files.

### 3. Backup Strategy
*   **Light Mode (Smart Select):**
    *   Filters only critical SQLite databases (`Cookies`, `Login Data`, `Web Data`) and JSON configs.
    *   Stores `Local State` from the browser User Data root separately from files under the selected `Default`/`Profile N` directory. Metadata records both relative locations.
    *   Requires both `Local State` and `Cookies`; a missing or uncopyable required file produces a `Failed` backup that restore refuses to use.
    *   Ignores cache, temporary files, and heavy binary blobs (Service Workers).
    *   Result: ~95% size reduction compared to full profile copy.
*   **Full Mode (Robocopy Equivalent):**
    *   Recursive copy of the selected profile plus the root-level `Local State`, preserving their User Data layout.

### macOS encryption boundary
Chromium browsers use macOS Keychain to protect encryption keys. The file backup intentionally does not attempt to export or restore Keychain records, so neither light nor full file copies guarantee that cookies or saved passwords will decrypt under another macOS user or on another Mac.

### 4. Network Stack
*   **Connectivity Check:** Uses `.NET` classes (`System.Net.WebRequest`) for rapid HTTP status checks.
*   **Reset Operations:** Invokes native Windows binaries (`netsh.exe`, `ipconfig.exe`) with elevated privileges to flush the networking stack.

## Directory Structure
```
/antigravity-cleaner
│   Antigravity.ps1       # Main Engine
│   install.ps1           # One-line Installer
│
├── /Data                 # (Generated at runtime)
│   ├── /Sessions         # Backup storage
│   │   ├── /Google Chrome
│   │   └── /...
│   └── /Logs             # Application logs
│
└── /docs                 # Technical Documentation
```
