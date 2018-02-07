<# 
	    .SYNOPSIS
            Export of all Applications and Packages from CM to text file
            
	    .DESCRIPTION
            Export of all Applications and Packages from CM to
			a csv text file

        .NOTES
            NAME:       Export-ApplicationsAndPackages.ps1
            AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
            TWITTER:    @walle75
            BLOG:       http://www.fredrikwall.se
            CREATED:    10/02/2017
            VERSION:    1.0
	
            
#>	
function Get-ScriptDirectory
{
	# Function from Sapien PowerShell Studio
	# to get current folder
	
	if ($hostinvocation -ne $null)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

# Change these two line to suite your setup
# Look at my blog post to se how to do this
Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" # Import the ConfigurationManager.psd1 module 
Set-Location "X01:" # Set the current location to be the site code.

$myExportFileName = "Applications.txt"

$myApplications = Get-CMApplication
$myPackages = Get-CMPackage

"Name;Created" > "$($ScriptDirectory)\$($myExportFileName)"

foreach ($item in $myApplications)
{
	"$($item.LocalizedDisplayName);$($item.DateCreated)" >> "$($ScriptDirectory)\$($myExportFileName))"
}

foreach ($item in $myPackages)
{
	"$($item.Name);$($item.Sourcedate)" >> "$($ScriptDirectory)\$($myExportFileName)"
}
