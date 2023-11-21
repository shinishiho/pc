if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`""
    Exit-PSHostProcess
}

function Banner {
    param (
        [Parameter(Mandatory = $true)][string]$For
    )

    $banners = @{
        Main    = @"
|-----------------------------------------------------------|
|           __     _         _        __     _  __          |
|    _____ / /_   (_)____   (_)_____ / /_   (_)/ /_   ____  |
|   / ___// __ \ / // __ \ / // ___// __ \ / // __ \ / __ \ |
|  (__  )/ / / // // / / // /(__  )/ / / // // / / // /_/ / |
| /____//_/ /_//_//_/ /_//_//____//_/ /_//_//_/ /_/ \____/  |
|                                                           |
|          Repo: https://github.com/shinishiho/pc           |
|               iex(irm win.shinishiho.cyou)                |
|-----------------------------------------------------------|

Use number keys to toggle features. Press Enter to run script.

"@
        Apps    = @"
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
        
"@
        Tweaks  = @"
"@
        Office  = @"
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
        AtlasOS = @"
|-----------------------------------------------------------|
|                                                           |
|           ___    __   __              ____  _____         |
|          /   |  / /_ / /____ _ _____ / __ \/ ___/         |
|         / /| | / __// // __ \// ___// / / /\__ \          |
|        / ___ |/ /_ / // /_/ /(__  )/ /_/ /___/ /          |
|       /_/  |_|\__//_/ \__,_//____/ \____//____/           |
|                                                           |
|                    https://atlasos.net                    |
|-----------------------------------------------------------|

"@
    }

    Clear-Host
    Write-Host $banners[$For] -ForegroundColor Yellow
}

$toggle = [System.Collections.Generic.List[System.String]]::new()
do {
    Clear-Host
@"
|-----------------------------------------------------------|
|           __     _         _        __     _  __          |
|    _____ / /_   (_)____   (_)_____ / /_   (_)/ /_   ____  |
|   / ___// __ \ / // __ \ / // ___// __ \ / // __ \ / __ \ |
|  (__  )/ / / // // / / // /(__  )/ / / // // / / // /_/ / |
| /____//_/ /_//_//_/ /_//_//____//_/ /_//_//_/ /_/ \____/  |
|                                                           |
|          Repo: https://github.com/shinishiho/pc           |
|               iex(irm win.shinishiho.cyou)                |
|-----------------------------------------------------------|

Use number keys to toggle features. Press Enter to run script.

"@ | Write-Host -ForegroundColor Yellow

    $option1 = "1. Install Tweaks"
    $option2 = "2. Install AtlasOS`n"
    $option3 = "3. Install Apps"
    $option4 = "4. Install Office`n"
    $option5 = "5. Manage Configs"
    $quitOption = "0. Quit"

    $columnWidth = 40
    $option1 = $option1.PadRight($columnWidth)
    $option3 = $option3.PadRight($columnWidth)
    $option5 = $option5.PadRight($columnWidth)

    Write-Host $option1 -ForegroundColor $(if ($toggle -contains "1") { 'Green' } else { 'Cyan' }) -NoNewline
    Write-Host $option2 -ForegroundColor $(if ($toggle -contains "2") { 'Green' } else { 'Cyan' })
    Write-Host $option3 -ForegroundColor $(if ($toggle -contains "3") { 'Green' } else { 'Cyan' }) -NoNewline
    Write-Host $option4 -ForegroundColor $(if ($toggle -contains "4") { 'Green' } else { 'Cyan' })
    Write-Host $option5 -ForegroundColor $(if ($toggle -contains "5") { 'Green' } else { 'Cyan' }) -NoNewline
    Write-Host $quitOption -ForegroundColor Red

    $selection = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown").Character - 48
    if ($selection -eq 0) { 
        Clear-Host
        return
    }
    if ($toggle -contains $selection) {
        $toggle.Remove($selection)
    }
    else {
        $toggle.Add($selection)
    }
} while ( $selection -ne -35 )

$toggle | ForEach-Object {
    switch ($_) {
        1 { Install-Tweaks }
        2 { Install-AtlasOS }
        3 { Invoke-Expression ".\apps.ps1" }
        4 { Invoke-Expression ".\office.ps1" }
        5 { Invoke-Expression ".\config.ps1" }
        Default {}
    }
}