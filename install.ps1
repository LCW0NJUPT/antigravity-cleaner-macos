$GithubBaseUrl = "https://raw.githubusercontent.com/tawroot/antigravity-cleaner/main"

# Detect OS
$IsWin = if ($null -ne $IsWindows) { $IsWindows } else { $env:OS -like "*Windows*" }
$HomePath = if ($IsWin) { $env:USERPROFILE } else { $env:HOME }
$PSExe = if ($IsWin) { "powershell.exe" } else { "pwsh" }

$InstallDir = Join-Path $HomePath ".antigravity"
$TargetFile = Join-Path $InstallDir "Antigravity.ps1"

try {
    # 1. Create Directory
    if (!(Test-Path -LiteralPath $InstallDir)) {
        New-Item -ItemType Directory -Path $InstallDir -Force -ErrorAction Stop | Out-Null
        Write-Host "Created installation directory: $InstallDir" -ForegroundColor Cyan
    }

    # 2. Download and validate without modifying a working installation.
    $TempFile = Join-Path $InstallDir ("Antigravity.{0}.tmp" -f [Guid]::NewGuid().ToString("N"))
    Write-Host "Downloading Antigravity Shell..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri "$GithubBaseUrl/Antigravity.ps1" -OutFile $TempFile -UseBasicParsing -ErrorAction Stop

    $download = Get-Item -LiteralPath $TempFile -ErrorAction Stop
    if ($download.Length -le 0) {
        throw "Downloaded script is empty: $TempFile"
    }
    if (-not (Select-String -LiteralPath $TempFile -SimpleMatch 'ANTIGRAVITY CLEANER' -Quiet -ErrorAction Stop)) {
        throw "Downloaded file does not contain the expected Antigravity script identifier."
    }

    if (Test-Path -LiteralPath $TargetFile) {
        [System.IO.File]::Replace($TempFile, $TargetFile, $null)
    }
    else {
        Move-Item -LiteralPath $TempFile -Destination $TargetFile -ErrorAction Stop
    }
    Write-Host "Download Complete." -ForegroundColor Green

    # 3. Create Desktop Shortcut (Windows Only)
    if ($IsWin) {
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
    else {
        Write-Host ""
        Write-Host "Installation Note (macOS/Linux):" -ForegroundColor Cyan
        Write-Host "To run Antigravity in the future, use:" -ForegroundColor White
        Write-Host "  pwsh $TargetFile" -ForegroundColor Yellow
        Write-Host ""
    }

    # 4. Launch
    Write-Host "Launching Antigravity..." -ForegroundColor Cyan
    $process = Start-Process $PSExe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$TargetFile`"" -PassThru -ErrorAction Stop
    if ($null -eq $process) { throw "Failed to start Antigravity." }
    Write-Host "Antigravity installed and launched successfully." -ForegroundColor Green
}
catch {
    if ($TempFile -and (Test-Path -LiteralPath $TempFile -ErrorAction SilentlyContinue)) {
        Remove-Item -LiteralPath $TempFile -Force -ErrorAction SilentlyContinue
    }
    Write-Error $_
    exit 1
}
