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

    $bg = "..\data\themes\bg"
    $cursor = "..\data\themes\cursor"
    $cursorFiles = Get-ChildItem -LiteralPath $cursor -Include "*.ani", "*.cur" -Recurse
    foreach ($cursorFile in $cursorFiles) {
        Copy-Item -LiteralPath $cursorFile.FullName -Destination "$env:windir\Cursors" -Force
    }

    $regFile = Get-ChildItem -LiteralPath $cursor -Filter "*.reg"
    if ($regFile) {
        Start-Process -FilePath "regedit.exe" -ArgumentList "/s `"$($regFile.FullName)`"" -Wait
    }

    [PInvoke]::SystemParametersInfo(0x0057, 0, $null, 0) | Out-Null
}