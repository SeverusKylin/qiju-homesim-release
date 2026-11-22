$ErrorActionPreference = 'Stop'

$repo = 'SeverusKylin/qiju-homesim-release'
$version = if ($env:QIJU_HOMESIM_VERSION) { $env:QIJU_HOMESIM_VERSION.Trim() } else { 'v0.3.0' }
$asset = "qiju-homesim-customer-$version.zip"
$installDir = if ($env:QIJU_HOMESIM_DIR) { [IO.Path]::GetFullPath($env:QIJU_HOMESIM_DIR) } else { Join-Path (Get-Location) 'qiju-homesim' }
$workDir = Join-Path ([IO.Path]::GetTempPath()) "qiju-homesim-$([Guid]::NewGuid().ToString('N'))"
$baseUrl = if ($env:QIJU_HOMESIM_BASE_URL) { $env:QIJU_HOMESIM_BASE_URL.TrimEnd('/') } else { "https://github.com/$repo/releases/download/$version" }
$zipPath = Join-Path $workDir $asset
$sumPath = Join-Path $workDir 'SHA256SUMS'

try {
  New-Item -ItemType Directory -Path $workDir -Force | Out-Null
  Write-Host "下载栖居 HomeSim $version ..."
  Invoke-WebRequest -UseBasicParsing -Uri "$baseUrl/$asset" -OutFile $zipPath
  Invoke-WebRequest -UseBasicParsing -Uri "$baseUrl/SHA256SUMS" -OutFile $sumPath
  $line = Get-Content -LiteralPath $sumPath | Where-Object { $_ -match "\s$([regex]::Escape($asset))$" } | Select-Object -First 1
  if (-not $line) { throw '发行包校验值不存在。' }
  $expected = $line -split '\s+'
  $expected = $expected[0].ToLowerInvariant()
  $actual = (Get-FileHash -LiteralPath $zipPath -Algorithm SHA256).Hash.ToLowerInvariant()
  if ($actual -ne $expected) { throw '发行包 SHA-256 校验失败。' }
  if (Test-Path -LiteralPath $installDir) {
    $children = @(Get-ChildItem -LiteralPath $installDir -Force)
    if ($children.Count -gt 0) { throw "安装目录不为空：$installDir" }
  } else {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
  }
  Expand-Archive -LiteralPath $zipPath -DestinationPath $installDir -Force
  Write-Host "安装完成：$installDir"
  Write-Host '启动：powershell -ExecutionPolicy Bypass -File .\start-home-sim.ps1'
} finally {
  if (Test-Path -LiteralPath $workDir) { Remove-Item -LiteralPath $workDir -Recurse -Force }
}
