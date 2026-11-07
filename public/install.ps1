# Installs or updates the standalone raindown binary on Windows, where the Obsidian plugin looks for it, and adds it to
# your PATH. Run it again to update, with Obsidian closed, as Windows can't replace a program that's running:
#   irm https://raindown.dev/install.ps1 | iex
$ErrorActionPreference = 'Stop'

function Install-Raindown {
  $releases = 'https://github.com/rainpour/raindown/releases/latest/download'
  $name = 'raindown-windows-x86_64.exe'
  $folder = Join-Path $env:LOCALAPPDATA 'Programs\raindown'
  $temporary = Join-Path ([IO.Path]::GetTempPath()) ([IO.Path]::GetRandomFileName())
  New-Item -ItemType Directory -Path $temporary | Out-Null

  try {
    Write-Host "Downloading $name..."
    Invoke-WebRequest -UseBasicParsing -Uri "$releases/SHA256SUMS" -OutFile "$temporary\SHA256SUMS"
    Invoke-WebRequest -UseBasicParsing -Uri "$releases/$name" -OutFile "$temporary\$name"

    $line = Get-Content "$temporary\SHA256SUMS" | Where-Object { $_ -match "\s\*?$([regex]::Escape($name))$" }
    if (-not $line) { throw "the release doesn't list a checksum for $name" }

    $expected = ($line -split '\s+')[0]
    $actual = (Get-FileHash -Algorithm SHA256 "$temporary\$name").Hash
    if ($actual -ne $expected) { throw "$name didn't match its checksum, so it wasn't installed" }

    New-Item -ItemType Directory -Force -Path $folder | Out-Null
    Move-Item -Force "$temporary\$name" "$folder\raindown.exe"
  } finally {
    Remove-Item -Recurse -Force $temporary
  }

  $path = [Environment]::GetEnvironmentVariable('Path', 'User')
  if (($path -split ';') -notcontains $folder) {
    [Environment]::SetEnvironmentVariable('Path', "$path;$folder", 'User')
  }

  Write-Host "Installed Raindown $(& "$folder\raindown.exe" --version) to $folder\raindown.exe"
}

Install-Raindown
