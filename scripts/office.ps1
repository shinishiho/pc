Clear-Host
@"
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

"@ | Write-Host -ForegroundColor Yellow

$tempFilePath = [System.IO.Path]::GetTempFileName() + ".exe"
try {
    Write-Host "Downloading Office 365 installer..."
    Invoke-WebRequest -Uri "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" -OutFile $tempFilePath    
    Start-Process -FilePath $tempFilePath -Wait
    Remove-Item -Path $tempFilePath
}
catch {
    Write-Host "Download failed. Please download and install Office 365 manually and come back to this script for activation." -ForegroundColor Red
    Start-Process "https://massgrave.dev/office_c2r_links.html#English_-_US_[en-us]"
}
Invoke-WebRequest -UseBasicParsing "massgrave.dev/get" | Invoke-Expression