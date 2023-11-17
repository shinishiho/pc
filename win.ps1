function Show-MainMenu {
    Clear-Host
    $banner = @"
|-----------------------------------------------------------|
|           __     _         _        __     _  __          |
|    _____ / /_   (_)____   (_)_____ / /_   (_)/ /_   ____  |
|   / ___// __ \ / // __ \ / // ___// __ \ / // __ \ / __ \ |
|  (__  )/ / / // // / / // /(__  )/ / / // // / / // /_/ / |
| /____//_/ /_//_//_/ /_//_//____//_/ /_//_//_/ /_/ \____/  |
|                                                           |
|          Repo: https://github.com/shinishiho.pc           |
|               iex(irm win.shinishiho.cyou)                |
|-----------------------------------------------------------|

"@
    Write-Host $banner -ForegroundColor Yellow
    $option1 = "[1] Install Apps"
    $option2 = "[2] Install Tweaks`n"
    $option3 = "[3] Activate Windows"
    $option4 = "[4] Install Office`n"
    $option5 = "[5] Install AtlasOS"
    $quitOption = "[0] Quit"

    $columnWidth = 40
    $option1 = $option1.PadRight($columnWidth)
    $option3 = $option3.PadRight($columnWidth)
    $option5 = $option5.PadRight($columnWidth)

    Write-Host ($option1 + $option2) -ForegroundColor Cyan
    Write-Host ($option3 + $option4) -ForegroundColor Cyan
    Write-Host $option5 -ForegroundColor Cyan -NoNewline
    Write-Host $quitOption -ForegroundColor Red
}
function Install-Apps {
    $banner = @"
|-----------------------------------------------------------|
|                                                           |
|                  ____   ____   ____   _____               |
|                 / __ \// __ \ / __ \ / ___/               |
|                / /_/ // /_/ // /_/ /(__  )                |
|                \__,_// .___// .___//____/                 |
|                     /_/    /_/                            |
|                                                           |
|                     Powered by winget                     |
|-----------------------------------------------------------|

"@

    if (-not (Get-Command "winget" -ErrorAction SilentlyContinue)) {
        Invoke-WebRequest -UseBasicParsing "asheroto.com/winget" | Invoke-Expression
    }
    Clear-Host
    Write-Host $banner -ForegroundColor Yellow
    $apps = -split (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/shinishiho/pc/main/apps_win.txt").Content
    foreach ($app in $apps) {
        Write-Host -NoNewline "`rInstalling $app ($($apps.IndexOf($app)) of $($apps.Count))".PadRight($Host.UI.RawUI.BufferSize.Width - 1, ' ')
        winget install --accept-package-agreements --accept-source-agreements --silent $app | Out-Null
    }
    Start-Process "thorium.exe" "https://idrive.com/online-backup-download"
    Start-Process "thorium.exe" "https://repack.me"
    Start-Process "thorium.exe" "https://sideloadly.io/#download"
}

function Install-Tweaks {

}

function Install-Office {
    $banner = @"
|-----------------------------------------------------------|
|                                                           |
|                 ____   ____ ____ _                        |
|                / __ \ / __// __/(_)_____ ___              |
|               / / / // /_ / /_ / // ___// _ \             |
|              / /_/ // __// __// // /__ /  __/             |
|              \____//_/  /_/  /_/ \___/ \___/              |
|                                                           |
|          massgravel/Microsoft-Activation-Scripts          |
|-----------------------------------------------------------|
"@
    Clear-Host
    Write-Host $banner -ForegroundColor Yellow
    $tempFilePath = [System.IO.Path]::GetTempFileName() + ".exe"
    try {
        Write-Host "Downloading Office 365 Installer..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" -OutFile $tempFilePath    
        Start-Process -FilePath $tempFilePath -Wait
        Remove-Item -Path $tempFilePath
    }
    catch {
        Write-Host "Download failed. Please download and install Office 365 manually and come back to this script for activation." -ForegroundColor Red
        Start-Process "https://massgrave.dev/office_c2r_links.html#English_-_US_[en-us]"
    }
    Invoke-WebRequest -UseBasicParsing "massgrave.dev/get" | Invoke-Expression
}

function Install-AtlasOS {
    $url = "https://download.ameliorated.io/AME%20Wizard%20Beta.zip"
    $zipFile = "AME_Wizard_Beta.zip"
    $extractFolder = "AME_Wizard_Beta"

    try {
        Invoke-WebRequest -Uri $url -OutFile $zipFile -ErrorAction Stop
        Expand-Archive -LiteralPath $zipFile -DestinationPath $extractFolder
        Remove-Item -Path $zipFile
        $exePath = Get-ChildItem -Path $extractFolder -Filter "*.exe" | Select-Object -ExpandProperty FullName -First 1
        Start-Process -FilePath $exePath
    }
    catch {
        Write-Host "Failed to download AME Wizard. Please download manually on website." -ForegroundColor Red

    }
    Start-Process "https://atlasos.net"
}

do {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "iwr -useb win.shinishiho.cyou | iex"
        break
    }
    Show-MainMenu
    $selection = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    switch ($selection.Character) {
        "1" { Install-Apps }
        "2" { Install-Tweaks }
        "3" { Invoke-WebRequest -UseBasicParsing "massgrave.dev/get" | Invoke-Expression }
        "4" { Install-Office }
        "5" { Install-AtlasOS }
        "a" {
            Install-Apps
            Install-Tweaks
            Install-Office
            Install-AtlasOS
        }
        "0" {
            Clear-Host 
            return 
        }
    }
} while ($selection -ne "0")