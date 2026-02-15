# Check for Administrator privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Requesting Administrator privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "--- WSL Setup Script ---" -ForegroundColor Cyan
Write-Host "Enabling Windows Subsystem for Linux and Virtual Machine Platform..."

# Attempt the standard install command
wsl --install

if ($LASTEXITCODE -ne 0) {
    Write-Host "Standard install failed or components missing. Attempting to enable features manually..." -ForegroundColor Yellow
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
}

Write-Host "`n--------------------------------------------------" -ForegroundColor Green
Write-Host "Setup actions completed."
Write-Host "1. Please RESTART your computer now."
Write-Host "2. If issues persist, check your BIOS settings to ensure VIRTUALIZATION is ENABLED."
Write-Host "--------------------------------------------------"
Pause
