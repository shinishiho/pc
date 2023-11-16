function Show-Menu {
    param (
        [string]$Title = 'Choose one option:'
    )
    Clear-Host
    Write-Host "================ $Title ================"

    Write-Host "1: Christitus Tweaks"
    Write-Host "2: Install Office"
    Write-Host "3: Install Apps"
    Write-Host "4: Install AtlasOS"
    Write-Host "0: Quit"
}

do {
    Show-Menu
    $input = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
    switch ($input.Character) {
        '1' {
            Start-Job -ScriptBlock {
                Invoke-Expression (Invoke-RestMethod "https://christitus.com/win")
            }
            "Christitus Tweaks is starting..."
        }
        '2' {
            Start-Job -ScriptBlock {
                $tempFilePath = [System.IO.Path]::GetTempFileName() + ".exe"
                Invoke-WebRequest -Uri "https://c2rsetup.officeapps.live.com/c2r/download.aspx?ProductreleaseID=O365ProPlusRetail&platform=x64&language=en-us&version=O16GA" -OutFile $tempFilePath
                Start-Process -FilePath $tempFilePath -Wait
                Remove-Item -Path $tempFilePath
                Invoke-Expression (Invoke-RestMethod "https://massgrave.dev/get")
            }
            "Office installation started..."
        }
        '3' {
            Start-Job -ScriptBlock {
                Start-Sleep -Seconds 15
                $list_url = "https://example.com/path/to/remotefile.txt"
                $apps = (Invoke-WebRequest -Uri $list_url).Content -join " "
                winget --accept-package-agreements --accept-source-agreements --silent install $apps
                Start-Process "thorium.exe" "https://idrive.com/online-backup-download"
                Start-Process "thorium.exe" "https://repack.me"
                Start-Process "thorium.exe" "https://sideloadly.io/#download"
            }
            "Apps installation started..."
        }
        '4' {
            Start-Job -ScriptBlock {
                Start-Sleep -Seconds 30
                $url = "https://download.ameliorated.io/AME%20Wizard%20Beta.zip"
                $zipFile = "AME_Wizard_Beta.zip"
                $extractFolder = "AME_Wizard_Beta"

                try {
                    Invoke-WebRequest -Uri $url -OutFile $zipFile -ErrorAction Stop
                }
                catch {
                    exit
                }

                Expand-Archive -LiteralPath $zipFile -DestinationPath $extractFolder
                Remove-Item -Path $zipFile
                $exePath = Get-ChildItem -Path $extractFolder -Filter "*.exe" | Select-Object -ExpandProperty FullName -First 1
                Start-Process -FilePath $exePath
            }
            "AtlasOS installation started..."
        }
        '0' {
            return
        }
    }
    Get-Job | Where-Object { $_.State -eq 'Completed' } | Remove-Job
} while ($input -ne '0')
