$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  throw '需要先安装 Node.js 22.12 或更高版本。'
}

$envFile = Join-Path $PSScriptRoot '.env.local'
if (Test-Path -LiteralPath $envFile) {
  foreach ($line in Get-Content -LiteralPath $envFile) {
    if ($line -match '^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)\s*$' -and $line -notmatch '^\s*#') {
      [Environment]::SetEnvironmentVariable($matches[1], $matches[2])
    }
  }
}

node (Join-Path $PSScriptRoot 'runtime/server.mjs')
