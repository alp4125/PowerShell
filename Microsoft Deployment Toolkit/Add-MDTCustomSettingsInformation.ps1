<#
	.SYNOPSIS
		Add MDT CustomSettings property
	
	.DESCRIPTION
		Add MDT CustomSettings.ini property
	
	.PARAMETER FilePath
		Path to CustomSettings.ini
	
	.PARAMETER Property
		The property you want to Add
	
	.PARAMETER Value
		The value you want to Add
	
	.EXAMPLE
				PS C:\> Add-MDTCustomSettingsInformation -FilePath "D:\MDTShare\Control" -Property "TaskSequenceID" -Value "MYTS001"
	
	.NOTES
		
			Author: 		Fredrik Wall
			Email:			fredrik@poweradmin.se
			Version:		1.0
			Created:		2018-12-08
#>
function Add-MDTCustomSettingsInformation
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$FilePath,
		[Parameter(Mandatory = $true,
				   Position = 2)]
		$Property,
		[Parameter(Mandatory = $true,
				   Position = 3)]
		$Value
	)
	
	try {
        $currentValue = ((Select-String -Path "$($FilePath)\CustomSettings.ini" -pattern "$($property)\b" -AllMatches -ErrorAction SilentlyContinue).ToString()).split("=")[1]
    }
    catch {
    }

    try {
        if ($currentValue -eq $null) {
            Add-Content "$($FilePath)\CustomSettings.ini" -Value "$($property)=$($value)"
        }
        else {
            Write-Warning "Property already exist!"
            Write-Warning "Use Set-MDTCustomSettingsInformation instead."
        }
    }
    catch {
        $_
    }
}