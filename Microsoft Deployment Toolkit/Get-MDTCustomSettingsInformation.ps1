<#
	.SYNOPSIS
		Get MDT CustomSettings properties values
	
	.DESCRIPTION
		Get MDT CustomSettings properties values
	
	.PARAMETER FilePath
		Path to CustomSettings.ini
	
	.PARAMETER Property
		The property you want to get information from
	
	.EXAMPLE
				PS C:\> Set-MDTCustomSettingsInformation -FilePath "D:\MDTShare\Control" -Property "TaskSequenceID"
	
	.NOTES
		
			Author: 		Fredrik Wall
			Email:			fredrik@poweradmin.se
			Version:		1.0
			Created:		2018-12-09
#>
function Get-MDTCustomSettingsInformation
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$FilePath,
		[Parameter(Mandatory = $true,
				   Position = 2)]
		$Property
	)
	
	try {
        $Value = ((Select-String -Path "$($FilePath)\CustomSettings.ini" -pattern "$($property)\b" -AllMatches -ErrorAction Stop).ToString()).split("=")[1]
    }
    catch {
       if ($_.Exception.Message -eq "You cannot call a method on a null-valued expression.") {
        Write-Warning "Could not find property"
       }
    }
	
    Return $Value
}