function Format-Name
{
<#
	.SYNOPSIS
		Formating Name and Names
	
	.DESCRIPTION
		Formating Name and Names with first upper and rest lower case
	
	.PARAMETER Name
		The name or names you want to format
	
	.EXAMPLE
        PS C:\> Format-Name -Name $value1
        
    .EXAMPLE
        PS C:\> Format-Name -Name "$value1 $value2"

    .EXAMPLE
        PS C:\> $value1 | Format-Name
        
	.NOTES
        NAME:      	Format-Name
        AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
        BLOG:       https://fredrikwall.se
        CREATED:	2017-11-03
        VERSION: 	1.2
#>
	
	[CmdletBinding()]
	param
	(
        [Parameter(ValueFromPipeline,Mandatory = $true)]
		$Name
	)
	
	$Name = $Name.Trim()
	
	# If It's double name or more
	if ($Name.IndexOf(" ") -ne "-1")
	{
		
		$TheName = $Name.Split(" ")
		
		$TheNames = @()
		
		foreach ($MyName in $TheName)
		{
			$MyName = "$((($MyName).Trim()).ToUpper().Substring(0, 1))$((($MyName).Trim()).ToLower().Substring(1))"
			$TheNames += $MyName
		}
		
		[string]$FixedName = $TheNames
		Return $FixedName
	}
	else
	{
		$MyName = "$((($Name).Trim()).ToUpper().Substring(0, 1))$((($Name).Trim()).ToLower().Substring(1))"
		[string]$FixedName = $MyName
		Return $FixedName
	}
}
