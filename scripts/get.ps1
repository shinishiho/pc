if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Powershell..."
    Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI"
}

# CHANGEME
$repo = "shinishiho/pc"
$branch = "win"
# CHANGEME

if (Get-Command git -ErrorAction SilentlyContinue) {
    git clone --single-branch --branch $branch "https://github.com/$repo.git" $branch  
} else {
    Invoke-WebRequest -Uri "https://github.com/$repo/zipball/$branch" -OutFile "~/$branch.zip"
    Expand-Archive -Path "~/$branch.zip" -DestinationPath "~/$branch"
}

$runScriptPath = "$branch/scripts/run.ps1"
Start-Process -FilePath "pwsh.exe" -ArgumentList "-File `"$runScriptPath`"" -Verb RunAs -WorkingDirectory "~/$branch/scripts"
Exit-PSHostProcess
