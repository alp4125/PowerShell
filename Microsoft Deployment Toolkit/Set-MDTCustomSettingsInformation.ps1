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
			Created:		2018-12-09
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
	
	$currentValue = ((Select-String -Path "$($FilePath)\CustomSettings.ini" -Pattern $property).ToString()).split("=")[1]
	
	(Get-Content $FilePath).replace($currentValue, $value) | Set-Content $FilePath
}