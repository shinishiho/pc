function Install-Fonts {
    $sourceDirectory = "..\data\fonts"
    $fontFiles = Get-ChildItem -Path $sourceDirectory -Filter "*.ttf", "*.otf"

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
    $cursorJson = Get-Content -Raw -Path "$cursor\cursor.json" | ConvertFrom-Json

    foreach ($key in $cursorJson.PSObject.Properties) {
        Copy-Item -Path "$cursor\$($key.Value)" -Destination "$env:SystemRoot\Cursors" -Force
        Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name $key.Name -Value "$env:SystemRoot\Cursors\$($key.Value)"
    }
    [PInvoke]::SystemParametersInfo(0x0057, 0, $null, 0) | Out-Null
}