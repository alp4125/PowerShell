#requires -version 5.1
<#
.SYNOPSIS
	Installs MDT core applications
.DESCRIPTION
    Installs MDT core applications
    
    Installs:

    Latest ADK and latest MDT
.NOTES
    NAME:      	Install-MDTCore.ps1
	AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
	CREATED:	2018-05-31
    VERSION:    1.0
#>

# Run the script as Administrator
# Some code is from Ben Armstrongs blog post:
# https://blogs.msdn.microsoft.com/virtual_pc_guy/2010/09/23/a-self-elevating-powershell-script/

# Get the ID and security principal of the current user account
$myWindowsID=[System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)
 
# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

if (!($myWindowsPrincipal.IsInRole($adminRole))) {
   # We are not running "as Administrator" - so relaunch as administrator
   Write-Output "Starting PowerShell As Administrator"

   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   
   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   
   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";
   
   # Start the new process
   [System.Diagnostics.Process]::Start($newProcess) | Out-Null
   
   # Exit from the current, unelevated, process
   exit
}

# Install latest Chocolatey from the web
if (!(Test-Path "C:\ProgramData\chocolatey")) {
    try {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Write-Output "Chocolatey Installed"
    }
    catch {
        Write-Output $_.Exception.Message
        Break
    }
}
else {
    Write-Output "Chocolatey allready installed"    
}
    
    # Check if Windows Assessment and Deployment Kit is installed
    If (!(Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Where-Object { $_.Displayname -match "Windows Assessment and Deployment Kit - Windows 10" })) {
        # If not install it with Chocolatey
        try {
            choco install windows-adk --Yes
            Write-Output "Windows ADK Installed"
        }
        catch {
            Write-Output $_.Exception.Message
            Break
        }
    }
    else {
        Write-Output "Windows ADK allready installed"    
    }
    
    # Check if Microsoft Deployment Toolkit is installed
    If (!(Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName | Where-Object { $_.Displayname -match "Microsoft Deployment Toolkit" })) {
        # If not install it with Chocolatey
        try {
            choco install mdt --Yes
            Write-Output "Microsoft Deployment Toolkit Installed"
        }
        catch {
            Write-Output $_.Exception.Message
            Break
        }
    }
    else {
        Write-Output "Microsoft Deployment Toolkit allready installed"    
    }