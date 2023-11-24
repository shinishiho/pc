. "..\utils\config.ps1"
. "..\utils\personalizations.ps1"
Clear-Host
@"
|-----------------------------------------------------------|
|                                                           |
|               ______               ____ _                 |
|              / ____/____   ____   / __/(_)____ _          |
|             / /    / __ \ / __ \ / /_ / // __ \/          |
|            / /___ / /_/ // / / // __// // /_/ /           |
|            \____/ \____//_/ /_//_/  /_/ \__, /            |
|                                        /____/             |
|                                                           |
|-----------------------------------------------------------|

Restoring config will copy contents in the config folder to their predetermined destinations.
Backing up will overwrite contents in the config folder. Press any other key to exit.

"@ | Write-Host -ForegroundColor Cyan

$option1 = "1. Restore config"
$option2 = "2. Backup config`n"
$option3 = "3. Personalizations"

$columnWidth = 40
$option1 = $option1.PadRight($columnWidth)
$option3 = $option3.PadRight($columnWidth)
Write-Host $option1 -ForegroundColor Cyan -NoNewline
Write-Host $option2 -ForegroundColor Cyan
Write-Host $option3 -ForegroundColor Cyan

$selection = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown").Character - 48
switch ($selection) {
    "1" { Restore-Config }
    "2" { Backup-Config }
    "3" { Install-Fonts ; Install-Themes }
    Default { }
}