@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if errorlevel 1 (
  echo 安装失败。
  pause
  exit /b 1
)
pause
