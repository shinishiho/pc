Clear-Host
@"
|-----------------------------------------------------------|
|                   ___                                     |
|                  /   |   ____   ____   _____              |
|                 / /| |  / __ \ / __ \ / ___/              |
|                / ___ | / /_/ // /_/ /(__  )               |
|               /_/  |_|/ .___// .___//____/                |
|                      /_/    /_/                           |
|                                                           |
|                     Powered by winget                     |
|-----------------------------------------------------------|

"@ | Write-Host -ForegroundColor Yellow

if (-not (Get-Command "winget" -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -UseBasicParsing "asheroto.com/winget" | Invoke-Expression
}

$apps = Get-Content -Raw -Path "../data/apps.json" | ConvertFrom-Json
foreach ($app in $apps) {
    $wingetId = $app.winget_id
    $name = $app.name
    Write-Host -NoNewline "`rInstalling $name ($($apps.apps.IndexOf($app)) of $($apps.apps.Count))".PadRight($Host.UI.RawUI.BufferSize.Width - 1, ' ')
    winget install --accept-package-agreements --accept-source-agreements --silent $wingetId | Out-Null
}