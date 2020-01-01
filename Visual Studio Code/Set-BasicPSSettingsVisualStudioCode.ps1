Function Set-BasicPSSettingsVisualStudioCode {
<#
    .SYNOPSIS
        Will set basic PowerShell settings for Visual Studio Code

    .DESCRIPTION
        Will set basic PowerShell settings for Visual Studio Code
        from settings.json file located at Fredrik Walls GitHub.

        Version 1.0 will set:

        Tab Complition = On
        Default Language = powershell
        Mouse Wheel Zoom = true
        Focus on terminal window on execute = false
        Terminal font size = 22

        Or you can create a own settings.json file and store it on GitHub and use it.

    .PARAMETER Force
        Will overwrite the settings.json file if it already exists
        
    .PARAMETER URLToSettingsFile
        You can specifie your own url to your settings file if you want
    
    .EXAMPLE
        Set-BasicPSSettingsVisualStudioCode

    .EXAMPLE
        Set-BasicPSSettingsVisualStudioCode -Force

    .NOTES
        NAME:       Set-BasicPSSettingsVisualStudioCode
        AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
        TWITTER:    @walle75
        BLOG:       https://www.fredrikwall.se/
        CREATED:    2020-01-01
        VERSION:    1.0

    .LINK
        https://github.com/FredrikWall
#>
    [CmdletBinding()]
    Param (
            [Parameter(Mandatory = $false)]
            [Switch]$Force,
            [Parameter(Mandatory = $false)]
            $URLToSettingsFile = "https://raw.githubusercontent.com/FredrikWall/PowerShell/master/Visual%20Studio%20Code/settings.json"
    )
    if ($Force) {
        try {
            Write-Output "Downloading settings.json file from $URLToSettingsFile"
            Invoke-WebRequest -Uri $URLToSettingsFile -OutFile "$env:APPDATA\Code\User\settings.json"
            Write-Output "settings.json file downloaded to $("$env:APPDATA\Code\User\settings.json")"
        }
        catch {
            Write-Output "Could not download the settings.json file"
            Write-Output "$_"
        }
    }
    else {
        If (!(Test-Path "$env:APPDATA\Code\User\settings.json")) {
            try {
                Write-Output "Downloading settings.json file from $URLToSettingsFile"
                Invoke-WebRequest -Uri $URLToSettingsFile -OutFile "$env:APPDATA\Code\User\settings.json"
                Write-Output "settings.json file downloaded to $("$env:APPDATA\Code\User\settings.json")"
            }
            catch {
                Write-Output "Could not download the settings.json file"
                Write-Output "$_"
            }
        }
        else {
            Write-Output "settings.json file already exists"
            Write-Output "Use -Force if you want to overwrite it"
        }
    }
}

Set-BasicPSSettingsVisualStudioCode

