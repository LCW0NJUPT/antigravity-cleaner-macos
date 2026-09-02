$scriptPath = Join-Path $PSScriptRoot "../Antigravity.ps1"
. $scriptPath

Describe "cleanup path safety" {
    BeforeAll {
        $testRoot = Join-Path ([IO.Path]::GetTempPath()) ("AntigravityCleaner-Pester-" + [guid]::NewGuid())
        New-Item -ItemType Directory -Path $testRoot -Force | Out-Null
    }

    AfterAll {
        Remove-Item -LiteralPath $testRoot -Recurse -Force -ErrorAction SilentlyContinue
    }

    It "rejects dangerous roots with trailing separators" -TestCases @(
        @{ Path = [IO.Path]::GetPathRoot($testRoot) }
        @{ Path = "/tmp/" }
        @{ Path = "/private/tmp/" }
        @{ Path = "/Library/" }
        @{ Path = $HomePath + [IO.Path]::DirectorySeparatorChar }
        @{ Path = (Join-Path $HomePath "Library") + [IO.Path]::DirectorySeparatorChar }
    ) {
        param($Path)
        Test-AllowedCleanupPath -Path $Path -AllowedRoots @($Path) | Should -BeFalse
    }

    It "rejects dot-dot traversal outside an allowed directory" {
        $allowed = Join-Path $testRoot "allowed"
        New-Item -ItemType Directory -Path $allowed -Force | Out-Null
        $traversal = Join-Path $allowed "../outside"
        Test-AllowedCleanupPath -Path $traversal -AllowedRoots @($allowed) | Should -BeFalse
    }

    It "rejects a symbolic link cleanup target" {
        $outside = Join-Path $testRoot "outside"
        $link = Join-Path $testRoot "linked-cleanup"
        New-Item -ItemType Directory -Path $outside -Force | Out-Null
        New-Item -ItemType SymbolicLink -Path $link -Target $outside | Out-Null
        Test-AllowedCleanupPath -Path $link -AllowedRoots @($link) | Should -BeFalse
    }

    It "accepts an ordinary explicitly allowed application directory" {
        $allowed = Join-Path $testRoot "Antigravity"
        New-Item -ItemType Directory -Path $allowed -Force | Out-Null
        Test-AllowedCleanupPath -Path $allowed -AllowedRoots @($allowed) | Should -BeTrue
    }
}
