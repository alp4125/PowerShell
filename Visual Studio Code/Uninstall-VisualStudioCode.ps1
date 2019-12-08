<#
	.SYNOPSIS
		Uninstall script for Visual Studio Code
	
	.DESCRIPTION
		Will uninstall Visual Studio Code and have
		the option to completly remove it from the users profile
	
	.PARAMETER Force
		Will completly remove Visual Studio Code from the installation
		in the current users profile
	
	.EXAMPLE
		Uninstall-VisualStudioCode

		Will Uninstall Visual Studio Code silently
	
	.EXAMPLE
        Uninstall-VisualStudioCode -Force

		Will Uninstall Visual Studio Code silently and remove all
		Visual Studio Code folders with settings and extensions.
	 
    .NOTES
		NAME:       Uninstall-VisualStudioCode
		AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
		TWITTER:    @walle75
		BLOG:       https://www.fredrikwall.se/
		CREATED:    2019-12-08
        VERSION:    1.0
	
	.LINK
		https://github.com/FredrikWall
#>
[CmdletBinding()]
Param ([Parameter(Mandatory = $false)]
	[Switch]$Force)

# Uninstall Visual Studio Code
if (Test-Path "$env:LOCALAPPDATA\Programs\Microsoft VS Code\unins000.exe") {
	Write-Output "Visual Studio Code will be uninstalled."
	
	$VsCode = Get-process "code" -ErrorAction SilentlyContinue

    if ($VsCode) {
		Write-Output "Visual Studio Code will be closed."
		try
		{
			$VsCode | Stop-Process -Force
		}
		catch
		{
			Write-Output "Visual Studio Code could not be closed."
		}
		
	}
	try {
		start-process "$env:LOCALAPPDATA\Programs\Microsoft VS Code\unins000.exe" -arg "/VERYSILENT" -Wait
	}
	catch
	{
		Write-Output "Visual Studio Code could not be uninstalled."
		Write-Output "Try to uninstall it manually and then run the script again."
		Break
	}
}
else
{
	Write-Output "Visual Studio Code is not installed for the current user."
}


if ($Force) {
	Write-Output "Will perform an remove of $env:APPDATA\Code if it exists"
	# Remove the Code folder under UserName\AppData\Roaming folder
	if (Test-Path "$env:APPDATA\Code")
	{
		try {
			Write-Output "Removing $env:APPDATA\Code"
			Remove-Item "$env:APPDATA\Code" -Recurse -Force
			Write-Output "$env:APPDATA\Code removed"
		}
		catch
		{
			Write-Output "Could not remove $env:APPDATA\Code"
		}
	}
	else
	{
		Write-Output "$env:APPDATA\Code does not exists"
	}
	
	Write-Output "Will perform an remove of $env:USERPROFILE\.vscode if it exists"
	# Remove the .vscode folder under UserName
	if (Test-Path "$env:USERPROFILE\.vscode")
	{
		try {
			Write-Output "Removing $env:USERPROFILE\.vscode"
			Remove-Item "$env:USERPROFILE\.vscode" -Recurse -Force
			Write-Output "$env:USERPROFILE\.vscode removed"
		}
		catch
		{
			Write-Output "Could not remove $env:USERPROFILE\.vscode"
		}
	}
	else
	{
		Write-Output "$env:USERPROFILE\.vscode does not exists"
	}
	
	if ((!(Test-Path "$env:APPDATA\Code")) -and (!(Test-Path "$env:USERPROFILE\.vscode")))
	{
		Write-Output "No Visual Studio Code files and folders are found now"
		Write-Output "You can Install Visual Studio Code again if you want"
	}
}