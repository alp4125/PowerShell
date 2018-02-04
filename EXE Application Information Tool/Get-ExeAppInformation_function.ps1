function Get-ExeAppInformation
{
	<#
	.SYNOPSIS
		Gets Exe Application Information from a EXE file
	.DESCRIPTION
		This function will check if the selected exe file have the application information that we wants.
	.PARAMETER FilePath
		Path to the EXE file
	.PARAMETER Property
		The Property that you want to get information from
	.EXAMPLE
		Get-EXEAppInformation -FilePath "JavaSetup8u144.exe" -Property "ProductName"
	
		Java Platform SE 8 U144
	
	.EXAMPLE
		Get-EXEAppInformation -FilePath "JavaSetup8u144.exe" -Property "ProductVersion"
	
		8.0.1440.1
	
	.NOTES
		Author: 	Fredrik Wall
		Email:		fredrik@poweradmin.se
		Created:	23/01/2016
	
	#>
	[CmdletBinding()]
	Param ([Parameter(Position = 1, Mandatory = $true)]
		$FilePath,
		[Parameter(Position = 2, Mandatory = $true)]
		$Property
	)
	try
	{
		
		$ExeAppInformation = ((Get-Itemproperty $FilePath).VersionInfo).$($Property)
		return $ExeAppInformation
		
	}
	catch
	{
		throw "Failed to get Exe application information. Error: {0}." -f $_
	}
}
