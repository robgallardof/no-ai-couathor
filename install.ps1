# Installs the no-ai-coauthor commit-msg hook (Windows PowerShell 5.1+ / PowerShell 7+).
#   .\install.ps1                          global: every repository on this machine
#   .\install.ps1 -Repo PATH               only that repository
#   .\install.ps1 -Uninstall [-Repo PATH]
param(
    [string]$Repo,
    [switch]$Uninstall
)
$ErrorActionPreference = 'Stop'
$hook = Join-Path $PSScriptRoot 'hooks/commit-msg'
$marker = 'no-ai-coauthor'

if (-not $Repo) {
    $configHome = if ($env:XDG_CONFIG_HOME) { $env:XDG_CONFIG_HOME } else { Join-Path $HOME '.config' }
    $dir = (Join-Path $configHome 'git/hooks') -replace '\\', '/'
    $current = git config --global core.hooksPath
} else {
    # --git-path honours a core.hooksPath already set in the repository
    $p = git -C $Repo rev-parse --git-path hooks
    if ($LASTEXITCODE -ne 0) { throw "Not a git repository: $Repo" }
    if (-not [IO.Path]::IsPathRooted($p)) { $p = Join-Path (Resolve-Path $Repo) $p }
    New-Item -ItemType Directory -Force $p | Out-Null
    $dir = (Resolve-Path $p).Path -replace '\\', '/'
}
$target = "$dir/commit-msg"
$isOurs = { (Test-Path $target) -and (Select-String -Quiet -SimpleMatch $marker $target) }

if ($Uninstall) {
    if (& $isOurs) {
        Remove-Item $target
        if (Test-Path "$target.bak") { Move-Item "$target.bak" $target }
    }
    if (-not $Repo -and $current -eq $dir) { git config --global --unset core.hooksPath }
    Write-Host "OK: no-ai-coauthor removed from $dir"
    exit 0
}

if (-not $Repo -and $current -and $current -ne $dir) {
    throw "core.hooksPath is already set globally to: $current. Copy hooks/commit-msg there yourself, or unset it first."
}

New-Item -ItemType Directory -Force $dir | Out-Null
if ((Test-Path $target) -and -not (& $isOurs)) {
    Move-Item -Force $target "$target.bak"
    Write-Host "Note: existing commit-msg hook saved as $target.bak"
}
# keep LF line endings so Git's sh can run it
$text = [IO.File]::ReadAllText($hook) -replace "`r`n", "`n"
[IO.File]::WriteAllText($target, $text, [Text.UTF8Encoding]::new($false))
if (-not $Repo) { git config --global core.hooksPath $dir }
Write-Host "OK: no-ai-coauthor installed in $target"
