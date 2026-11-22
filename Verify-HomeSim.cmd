@echo off
setlocal
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Verify-HomeSim.ps1"
if errorlevel 1 pause
