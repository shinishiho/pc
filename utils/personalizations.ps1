function Install-Fonts {
    $sourceDirectory = "..\data\fonts"
    $fontFiles = Get-ChildItem -Path $sourceDirectory -Filter ("*.ttf", "*.otf" -join ";")

    foreach ($fontFile in $fontFiles) {
        Add-Font -LiteralPath $fontFile.FullName
    }
}

function Install-Themes {
    Add-Type @"
using System.Runtime.InteropServices;
public class PInvoke {
    [DllImport("user32.dll")] public static extern int SystemParametersInfo(int uiAction, int uiParam, int[] pvParam, int fWinIni);
    [DllImport("user32.dll")] public static extern int SystemParametersInfo(int uiAction, int uiParam, System.IntPtr pvParam, int fWinIni);
}
"@

    $themeFolder = "..\data\themes"
    $themeFile = Get-ChildItem -LiteralPath "$themeFolder" -Filter "*.theme"
    New-Item -ItemType Directory -Force -Path "$env:windir\Resources\Web\Wallpaper\$($themeFile.BaseName)"

    $wallpapers = Get-ChildItem -LiteralPath "$themeFolder\wallpaper" -Filter "*.jpg", "*.jpeg", "*.png"
    foreach ($wallpaper in $wallpapers) {
        Copy-Item -LiteralPath $wallpaper.FullName -Destination "$env:windir\Resources\Web\Wallpaper\$($themeFile.BaseName)" -Force
    }
    Invoke-Item -LiteralPath $themeFile.FullName

    $cursors = Get-ChildItem -LiteralPath "$themeFolder\cursor" -Include "*.ani", "*.cur" -Recurse
    foreach ($cursor in $cursors) {
        Copy-Item -LiteralPath $cursorFile.FullName -Destination "$env:windir\Cursors" -Force
    }

    $regFile = Get-ChildItem -LiteralPath "$themeFolder\cursor" -Filter "*.reg"
    if ($regFile) {
        Start-Process -FilePath "regedit.exe" -ArgumentList "/s `"$($regFile.FullName)`"" -Wait
    }

    [PInvoke]::SystemParametersInfo(0x0057, 0, $null, 0) | Out-Null
}