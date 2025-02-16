# Windows Subsystem for Linux (WSL) Guide

This guide covers essential WSL commands and operations for managing Linux distributions on Windows.

## Installation

Install WSL with Ubuntu 24.04 (recommended distribution):
```powershell
wsl --install -d Ubuntu-24.04
```

## Basic WSL Commands

### Start/Stop WSL
```powershell
# Start a specific distribution
wsl -d Ubuntu-24.04

# Stop/shutdown a specific distribution
wsl --terminate Ubuntu-24.04

# Stop all running distributions
wsl --shutdown
```

### List Operations
```powershell
# List all available distributions
wsl --list

# List all distributions with detailed status
wsl --list --verbose

# List online available distributions
wsl --list --online
```

## Backup and Restore

### Export (Backup)
Export your WSL distribution to a TAR file:
```powershell
wsl --export Ubuntu-24.04 E:\WSL\ubuntu_backup.tar
```

### Unregister
Remove a distribution (does not delete backup files):
```powershell
wsl --unregister Ubuntu-24.04
```

### Import (Restore)
Import a previously exported distribution:
```powershell
wsl --import ubuntu E:\WSL\ubuntu E:\WSL\ubuntu_backup.tar
```

## Advanced Operations

### Set Default Version
```powershell
# Set WSL 2 as default
wsl --set-default-version 2
```

### Set Default Distribution
```powershell
# Set a distribution as default
wsl --set-default Ubuntu-24.04
```

### Update WSL
```powershell
# Update WSL kernel and components
wsl --update

# Check WSL version
wsl --version
```

### Mount Drives
WSL automatically mounts Windows drives under /mnt:
- C: drive → /mnt/c
- D: drive → /mnt/d
- etc.

## Troubleshooting

If you encounter issues:
1. Try terminating the distribution: `wsl --terminate Ubuntu-24.04`
2. If that doesn't work, shutdown WSL entirely: `wsl --shutdown`
3. For persistent issues, try unregistering and reimporting the distribution
4. Update WSL: `wsl --update`
