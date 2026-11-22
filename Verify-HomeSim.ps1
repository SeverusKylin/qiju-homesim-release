$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$required = @(
  'runtime/server.mjs',
  'dist/index.html',
  'dist/v8/scene.glb',
  'dist/v8/people/dad.glb',
  'dist/v8/people/mom.glb',
  'dist/v8/people/son.glb',
  'config/model.example.json',
  'config/integrations.example.json'
)
foreach ($relative in $required) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $relative) -PathType Leaf)) {
    throw "缺少发行文件：$relative"
  }
}
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '未找到 Node.js 22.12 或更高版本。' }
$nodeVersion = [version](node -p "process.versions.node")
if ($nodeVersion -lt [version]'22.12.0') { throw "Node.js 版本过低：$nodeVersion" }
Write-Host "栖居 HomeSim 发行包检查通过，Node.js $nodeVersion。"
