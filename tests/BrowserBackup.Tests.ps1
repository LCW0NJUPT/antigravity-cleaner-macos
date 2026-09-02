BeforeAll {
    $env:ANTIGRAVITY_NO_MAIN = "1"
    . (Join-Path $PSScriptRoot ".." "Antigravity.ps1")
}

Describe "Chromium profile discovery" {
    It "returns UserDataPath for <Browser> <ProfileName>" -ForEach @(
        @{ Browser = "Google Chrome"; ProfileName = "Default" }
        @{ Browser = "Microsoft Edge"; ProfileName = "Profile 1" }
        @{ Browser = "Brave Browser"; ProfileName = "Profile 12" }
    ) {
        $root = Join-Path $TestDrive ($Browser -replace " ", "-")
        $profilePath = Join-Path $root $ProfileName
        New-Item -ItemType Directory -Path $profilePath -Force | Out-Null
        '{"account_info":[{"email":"test@example.com"}]}' | Set-Content (Join-Path $profilePath "Preferences")

        $profiles = @(Get-BrowserProfiles -BrowserName $Browser -UserDataPath $root)

        $profiles | Should -HaveCount 1
        $profiles[0].Name | Should -Be $ProfileName
        $profiles[0].UserDataPath | Should -Be $root
    }
}

Describe "Browser backup payload" {
    BeforeEach {
        $script:userData = Join-Path $TestDrive "UserData"
        $script:profilePath = Join-Path $script:userData "Profile 2"
        $script:destination = Join-Path $TestDrive "Backup"
        New-Item -ItemType Directory -Path $script:profilePath -Force | Out-Null
        "state" | Set-Content (Join-Path $script:userData "Local State")
        "cookies" | Set-Content (Join-Path $script:profilePath "Cookies")
        "prefs" | Set-Content (Join-Path $script:profilePath "Preferences")
        $script:profile = [pscustomobject]@{
            Browser = "Google Chrome"; Name = "Profile 2"; Path = $script:profilePath; UserDataPath = $script:userData
        }
    }

    It "preserves root and profile relative locations" {
        Copy-BrowserBackupPayload -Profile $script:profile -Destination $script:destination -Mode Light

        Join-Path $script:destination "User Data/Local State" | Should -Exist
        Join-Path $script:destination "User Data/Profile 2/Cookies" | Should -Exist
        Join-Path $script:destination "User Data/Profile 2/Preferences" | Should -Exist
    }

    It "fails when Cookies is absent" {
        Remove-Item (Join-Path $script:profilePath "Cookies")
        { Copy-BrowserBackupPayload -Profile $script:profile -Destination $script:destination -Mode Light } |
            Should -Throw "*Cookies*"
    }

    It "fails rather than ignoring a locked critical file" {
        Mock Copy-Item {
            if ($LiteralPath -like "*Cookies") { throw "file is locked" }
            Microsoft.PowerShell.Management\Copy-Item @PSBoundParameters
        } -ParameterFilter { $null -ne $LiteralPath }

        { Copy-BrowserBackupPayload -Profile $script:profile -Destination $script:destination -Mode Light } |
            Should -Throw "*locked*"
    }
}
