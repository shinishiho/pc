$configs = Get-Content -Raw -Path "..\data\config_paths.json" | ConvertFrom-Json

function Restore-Config {
    foreach ($config in $configs) {
        $src = "..\config\" + $config.path
        $dest = $config.destination + $config.path

        Copy-Item -Path $src -Destination $dest -Recurse -Force
        Write-Host "Copied $src => $dest"
    }
    Write-Host "Config restored."
}

function Backup-Config {
    $timestamp = Get-Date -Format "yyyyMMddHHmmss"
    Copy-Item -Path "../config" -Destination "../config_backup_$timestamp" -Recurse -Force

    foreach ($config in $configs) {
        $src = $config.destination + $config.path
        if (-not (Test-Path $src)) {
            continue
        }
        $dest = "../config/" + $config.path

        Copy-Item -Path $src -Destination $dest -Recurse -Force
    }
}