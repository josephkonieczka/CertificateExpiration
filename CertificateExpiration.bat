@echo off
set folder=%~dp0
set scriptPath=%folder%CertificateExpiration.ps1
Powershell -NoProfile -ExecutionPolicy ByPass -Command "& '%scriptPath%'";

