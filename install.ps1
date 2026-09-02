param(
    [string]$GithubBaseUrl = $env:ANTIGRAVITY_GITHUB_BASE_URL
)

$ErrorActionPreference = "SilentlyContinue"
$DefaultGithubBaseUrl = "https://raw.githubusercontent.com/LCW0NJUPT/antigravity-cleaner-macos/main"
if ([string]::IsNullOrWhiteSpace($GithubBaseUrl)) {
    $GithubBaseUrl = $DefaultGithubBaseUrl
}
$GithubBaseUrl = $GithubBaseUrl.TrimEnd("/")
$DownloadUrl = "$GithubBaseUrl/Antigravity.ps1"

# Resolve the branch/tag to a commit when the source is a standard GitHub raw URL.
$SourceRevision = "unknown (custom source)"
if ($GithubBaseUrl -match '^https://raw\.githubusercontent\.com/([^/]+)/([^/]+)/(.+)$') {
    $RepositoryOwner = $Matches[1]
    $RepositoryName = $Matches[2]
    $RepositoryRef = $Matches[3]
    $SourceRevision = $RepositoryRef
    try {
        $EncodedRepositoryRef = [Uri]::EscapeDataString($RepositoryRef)
        $Commit = Invoke-RestMethod -Uri "https://api.github.com/repos/$RepositoryOwner/$RepositoryName/commits/$EncodedRepositoryRef" -UseBasicParsing
        if ($Commit.sha) {
            $SourceRevision = "$RepositoryRef ($($Commit.sha))"
        }
    }
    catch {
        # The ref is still useful when the API is unavailable or rate limited.
    }
}

# Detect OS
$IsWin = if ($null -ne $IsWindows) { $IsWindows } else { $env:OS -like "*Windows*" }
$HomePath = if ($IsWin) { $env:USERPROFILE } else { $env:HOME }
$PSExe = if ($IsWin) { "powershell.exe" } else { "pwsh" }

$InstallDir = Join-Path $HomePath ".antigravity"
$TargetFile = Join-Path $InstallDir "Antigravity.ps1"

# 1. Create Directory
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    Write-Host "Created installation directory: $InstallDir" -ForegroundColor Cyan
}

# 2. Download Main Script
Write-Host "Downloading Antigravity Shell..." -ForegroundColor Yellow
Write-Host "Download URL: $DownloadUrl" -ForegroundColor Cyan
Write-Host "Source revision: $SourceRevision" -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $TargetFile -UseBasicParsing
    $DownloadedVersion = Select-String -Path $TargetFile -Pattern '^\s*\$Version\s*=\s*["'']([^"'']+)["'']' | Select-Object -First 1
    if ($DownloadedVersion) {
        Write-Host "Downloaded version: $($DownloadedVersion.Matches[0].Groups[1].Value)" -ForegroundColor Cyan
    }
    else {
        Write-Host "Downloaded version: unknown (no version metadata found)" -ForegroundColor Cyan
    }
    Write-Host "Download Complete." -ForegroundColor Green
}
catch {
    Write-Host "Failed to download script. Check internet connection." -ForegroundColor Red
    exit 1
}

# 3. Create Desktop Shortcut (Windows Only)
if ($IsWin) {
    try {
        $WshShell = New-Object -ComObject WScript.Shell
        $DesktopPath = [Environment]::GetFolderPath("Desktop")
        $ShortcutFile = "$DesktopPath\Antigravity Shell.lnk"
        $Shortcut = $WshShell.CreateShortcut($ShortcutFile)
        $Shortcut.TargetPath = "powershell.exe"
        $Shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$TargetFile`""
        $Shortcut.IconLocation = "shell32.dll,238" 
        $Shortcut.Save()
        Write-Host "Shortcut created on Desktop." -ForegroundColor Green
    }
    catch {
        Write-Host "Could not create shortcut automatically." -ForegroundColor Gray
    }
}
else {
    Write-Host ""
    Write-Host "Installation Note (macOS/Linux):" -ForegroundColor Cyan
    Write-Host "To run Antigravity in the future, use:" -ForegroundColor White
    Write-Host "  pwsh $TargetFile" -ForegroundColor Yellow
    Write-Host ""
}

# 4. Launch
Write-Host "Launching Antigravity..." -ForegroundColor Cyan
Start-Process $PSExe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$TargetFile`""
