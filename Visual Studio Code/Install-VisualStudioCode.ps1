<#
.SYNOPSIS
    Installation of Visual Studio Code

.DESCRIPTION
    Installation of Visual Studio Code automatically.
    Plus installation of following extensions:

    eamodio.gitlens
    davidanson.vscode-markdownlint
    vscode-icons-team.vscode-icons
    dotjoshjohnson.xml

    Plus adding Open with code
    Plus adding basic PowerShell settings
    
    The script will use the Install-VSCode script from Microsoft
    to install latest version of Visual Studio Code.
     
.NOTES
    AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
    CREATED:    2020-01-02
    VERSION:    1.0
#>

Function Set-OpenWithVisualStudioCode {
    <#
.SYNOPSIS
    Will set Open with for Visual Studio Code

.DESCRIPTION
    Will set Open with for Visual Studio Code.

.PARAMETER Scope
    For User or System installation
    
.PARAMETER File
    Will set Open with for files

.PARAMETER Directory
    Will set Open with for directory

.EXAMPLE
    Set-OpenWithVisualStudioCode -Scope User -File -Directory

.EXAMPLE
    Set-OpenWithVisualStudioCode -Scope System -File -Directory

.NOTES
    NAME:       Set-OpenWithVisualStudioCode
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
            [Parameter(Mandatory = $true)]
            [ValidateSet('User', 'System')]
            $Scope,
            [Parameter(Mandatory = $false)]
            [Switch]$File,
            [Parameter(Mandatory = $false)]
            [Switch]$Directory
    )
    
    
    New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR | Out-Null
    

    if ($Scope -eq "User") {
            $PathToVSCode = "$env:LOCALAPPDATA\Programs\Microsoft VS Code"
            if (!(Test-Path "$PathToVSCode\Code.exe")) {
                    Write-Output "No User installation found"
                    Break
            }
    }

    if ($Scope -eq "System") {
            $PathToVSCode = "$env:ProgramFiles\Microsoft VS Code"
            if (!(Test-Path "$PathToVSCode\Code.exe")) {
                    Write-Output "No System installation found"
                    Break
            }
    }

    if ($File) {
            If (!(Test-Path -LiteralPath "HKCR:\*\shell\VSCode")) {
                    # Right click on a file
                    try {
                            Set-Location -LiteralPath "HKCR:\*"
                            New-Item -Path ".\shell" -Name "VSCode" -Force | Out-Null
                            New-Item -Path ".\shell\VSCode" -Name "command" -Force | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode" -Name '(Default)' -Value "Open with Code" -Type ExpandString
                            New-ItemProperty -Path ".\shell\VSCode" -Name 'Icon' -PropertyType ExpandString -Value "$PathToVSCode\Code.exe" | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode\command" -Name '(Default)' -Value "`"$PathToVSCode\Code.exe`" `"%1`"" -Type ExpandString
                            Write-Output "Open with Code set for files"
                    }
                    catch {
                            Write-Output "Error: Open with Code not set for files"
                            Write-Output "$_"
                    }
                    
            }
            else {
                    Write-Output "Open with Code already set for files"
            }
    }

    if ($Directory) {
            If (!(Test-Path -LiteralPath "HKCR:\Directory\shell\VSCode")) {
                    # Right click on a folder
                    try {
                            Set-Location -LiteralPath "HKCR:\Directory"
                            New-Item -Path ".\shell" -Name "VSCode" -Force | Out-Null
                            New-Item -Path ".\shell\VSCode" -Name "command" -Force | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode" -Name '(Default)' -Value "Open with Code" -Type ExpandString
                            New-ItemProperty -Path ".\shell\VSCode" -Name 'Icon' -PropertyType ExpandString -Value "$PathToVSCode\Code.exe" | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode\command" -Name '(Default)' -Value "`"$PathToVSCode\Code.exe`" `"%V`"" -Type ExpandString

                            # Right click inside a folder
                            Set-Location -LiteralPath "HKCR:\Directory\Background"
                            New-Item -Path ".\shell" -Name "VSCode" -Force | Out-Null
                            New-Item -Path ".\shell\VSCode" -Name "command" -Force | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode" -Name '(Default)' -Value "Open with Code" -Type ExpandString
                            New-ItemProperty -Path ".\shell\VSCode" -Name 'Icon' -PropertyType ExpandString -Value "$PathToVSCode\Code.exe" | Out-Null
                            Set-ItemProperty -Path ".\shell\VSCode\command" -Name '(Default)' -Value "`"$PathToVSCode\Code.exe`" `"%V`"" -Type ExpandString

                            Write-Output "Open with Code set for directory"
                    }
                    catch {
                            Write-Output "Error: Open with Code not set for files"
                            Write-Output "$_"
                    }
            }
            else {
                    Write-Output "Open with Code already set for directory"
            }
    }
}
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
    

Install-Package NuGet -Force
Install-Script Install-VSCode -Scope CurrentUser -Force
& $env:USERPROFILE\Documents\WindowsPowerShell\Scripts\Install-vscode.ps1 -AdditionalExtensions "eamodio.gitlens","davidanson.vscode-markdownlint","vscode-icons-team.vscode-icons","dotjoshjohnson.xml"
Set-OpenWithVisualStudioCode -Scope System -File -Directory
Set-BasicPSSettingsVisualStudioCode