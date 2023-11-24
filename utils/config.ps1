$configs = Get-Content -Raw -Path "..\data\config_paths.json" | ConvertFrom-Json

function Restore-Config {
    foreach ($config in $configs) {
        $src = "..\data\" + $config.path
        $dest = $config.destination

        Copy-Item -Path $src -Destination $dest -Recurse -Force
        Write-Host "Copied $src => $dest"
    }
    Write-Host "Config restored."
}

function Backup-Config {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    Copy-Item -Path "..\data\config" -Destination "..\data\config_backup_$timestamp" -Recurse -Force

    foreach ($config in $configs) {
        $src = $config.destination
        $dest = "..\data\" + $config.path
        if (-not (Test-Path $src)) {
            continue
        }

        Copy-Item -Path $src -Destination $dest -Recurse -Force
        Write-Host "Copied $src => $dest"
    }
}