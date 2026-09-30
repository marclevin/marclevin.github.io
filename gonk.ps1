# Served at https://marclevin.me/gonk.ps1
#
#   irm https://marclevin.me/gonk.ps1 | iex
#
# This file never needs to change. It fetches the real installer from the
# GonkLander repository and runs it. It contains no credentials.
#
# To pin what gets installed:   $env:GONK_VERSION = "v0.1.0"; irm https://marclevin.me/gonk.ps1 | iex

function Invoke-GonkShim {
    $repo = if ($env:GONK_REPO) { $env:GONK_REPO } else { "marclevin/GonkLander" }
    $version = if ($env:GONK_VERSION) { $env:GONK_VERSION } else { "main" }
    $url = "https://raw.githubusercontent.com/$repo/$version/lander/install.ps1"

    try {
        $installer = Invoke-RestMethod $url
    } catch {
        Write-Host "Could not download the Gonk installer from:" -ForegroundColor Red
        Write-Host "    $url"
        Write-Host "Check this machine's Internet connection, and that version '$version' exists."
        return
    }
    $env:GONK_REPO = $repo
    $env:GONK_VERSION = $version
    Invoke-Expression $installer
}

Invoke-GonkShim
