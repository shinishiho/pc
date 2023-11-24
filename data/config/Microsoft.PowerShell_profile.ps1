# Oh-Ky-Posh
oh-my-posh init pwsh --config 'C:\Users\ShiniShiho\AppData\Local\Programs\oh-my-posh\themes\emodipt-extend.omp.json' | Invoke-Expression

#Execution aliases
function Invoke-SGPT {
    param(
        [Parameter(Position=0)]
        [string]$Prompt,

        [string]$Model = "gpt-3.5-turbo-1106",

        [ValidateRange(0.0, 2.0)]
        [float]$Temperature = 0.1,

        [ValidateRange(0.1, 1.0)]
        [float]$TopProbability = 1.0,

        [switch]$Editor,

        [switch]$Cache,

        [Alias("h")]
        [switch]$Help,

        [Alias("s")]
        [switch]$Shell,

        [switch]$DescribeShell,

        [switch]$Code,

        [Alias("id")]
        [string]$Chat,

        [string]$Repl,

        [string]$ShowChat,

        [Alias("lc")]
        [switch]$ListChats,

        [string]$Role,

        [string]$CreateRole,

        [string]$ShowRole,

        [switch]$ListRoles
    )

    $sgptArgs = @("--model", $Model, "--temperature", $Temperature, "--top-probability", $TopProbability)

    if ($Editor) { $sgptArgs += "--editor" }
    elseif (!$Editor) { $sgptArgs += "--no-editor" }

    if ($Cache) { $sgptArgs += "--cache" }
    elseif (!$Cache) { $sgptArgs += "--no-cache" }

    if ($Help) { $sgptArgs += "--help" }

    if ($Shell) { $sgptArgs += "-s" }
    if ($DescribeShell) { $sgptArgs += "-d" }
    if ($Code) { $sgptArgs += "--code" }
    elseif (!$Code) { $sgptArgs += "--no-code" }

    if ($Chat) { $sgptArgs += "--chat", $Chat }
    if ($Repl) { $sgptArgs += "--repl", $Repl }
    if ($ShowChat) { $sgptArgs += "--show-chat", $ShowChat }
    if ($ListChats) { $sgptArgs += "--list-chats" }
    elseif (!$ListChats) { $sgptArgs += "--no-list-chats" }

    if ($Role) { $sgptArgs += "--role", $Role }
    if ($CreateRole) { $sgptArgs += "--create-role", $CreateRole }
    if ($ShowRole) { $sgptArgs += "--show-role", $ShowRole }
    if ($ListRoles) { $sgptArgs += "--list-roles" }
    elseif (!$ListRoles) { $sgptArgs += "--no-list-roles" }

    sgpt @sgptArgs $Prompt
}

Set-Alias -Name ai -Value Invoke-SGPT