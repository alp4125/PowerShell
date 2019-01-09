<#
	.SYNOPSIS
		Set MDT CustomSettings properties
	
	.DESCRIPTION
		Set MDT CustomSettings.ini properties
	
	.PARAMETER FilePath
		Path to CustomSettings.ini
	
	.PARAMETER Property
		The property you want to change
	
	.PARAMETER Value
		The value you want to set
	
	.EXAMPLE
				PS C:\> Set-MDTCustomSettingsInformation -FilePath "D:\MDTShare\Control" -Property "TaskSequenceID" -Value "MYTS001"
	
	.NOTES
		
			Author: 		Fredrik Wall
			Email:			fredrik@poweradmin.se
			Version:		1.0
			Created:		2018-12-08
#>
function Set-MDTCustomSettingsInformation
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
        $currentValue = ((Select-String -Path "$($FilePath)\CustomSettings.ini" -pattern "$($property)\b" -AllMatches -ErrorAction Stop).ToString()).split("=")[1]
    }
    catch {
       if ($_.Exception.Message -eq "You cannot call a method on a null-valued expression.") {
        Write-Warning "Could not find property"
        Break
       }
    }

    try {
        (Get-Content "$($FilePath)\CustomSettings.ini").replace("$($property)=$($currentValue)", "$($property)=$($Value)") | Set-Content "$($FilePath)\CustomSettings.ini"
    }
    catch {
        Write-Warning "Error setting the value for the property: $($_.Exception.Message)"
    }
}
