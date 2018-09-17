<#
	.SYNOPSIS
		This script will get a random name from a list of peoples Given names and surnames

	.DESCRIPTION
		This function will get a random Given name from a list of peoples Given names and surnames in
		Denmark, England and Wales, Finland, Norway, Sweden and USA.
         
	.NOTES
		NAME:      	Create-RealFakeNames.ps1
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	02/11/2018
					Added support for:
						Denmark
						Finland
						Norway
					Changed:
						Using new source and API for Sweden
						Changed UK to England and Wales
        VERSION:    2.1
#>	

function Get-ScriptDirectory
	{
		if ($hostinvocation -ne $null)
		{
			Split-Path $hostinvocation.MyCommand.path
		}
		else
		{
			Split-Path $script:MyInvocation.MyCommand.Path
		}
	}
	

[string]$ScriptDirectory = Get-ScriptDirectory



function Get-GivenName
{
<#
	.SYNOPSIS
		This function will get a random Given name from a list of peoples Given names

	.DESCRIPTION
		This function will get a random Given name from a list of peoples Given names in
		Denmark, England and Wales, Finland, Norway, Sweden and USA.
        To get the list/lists of Given names use the Import-GivenNames function.
         
	.PARAMETER Country
        Choose from wish country you want to get a surname or use ALL for all lists
    
	.EXAMPLE 
		Get-GivenName -Country DENMARK
	
	.EXAMPLE 
		Get-GivenName -Country ENGLANDWALES
		
	.EXAMPLE 
		Get-GivenName -Country FINLAND

	.EXAMPLE 
		Get-GivenName -Country NORWAY
		
	.EXAMPLE 
        Get-GivenName -Country SWEDEN
    
	.EXAMPLE 
        Get-GivenName -Country USA
        
    .EXAMPLE
        Get-GivenName -Country ALL
	
	.NOTES
		NAME:      	Get-GivenName
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	02/11/2018
					Added support for:
						Denmark
						Finland
						Norway
					Changed:
						Using new source and API for Sweden
						Changed UK to England and Wales
        VERSION:    3.2
#>	
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$Country
	)
	
	# Path to the current directory.
	$CurrDir = (Get-Location -PSProvider FileSystem).ProviderPath
	
	if ($country -eq "ALL")
	{
		$mysNameFiles = Get-ChildItem -Path $ScriptDirectory -Name "gNames*.txt"
		if (!($mysNameFiles -eq $null))
		{
			$mysNames = @()
			
			foreach ($myFile in $mysNameFiles)
			{
				$mysNames += Get-Content "$ScriptDirectory\$myFile"
			}
			
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported given name files found!`nUse Import-GivenNames to get Given name files."
		}
	}
	else
	{
		$mysNameFile = Get-ChildItem -Path $ScriptDirectory -Name "gNames$country.txt"
		if (!($mysNameFile -eq $null))
		{
			
			$mysNames = @()
			
			foreach ($myFile in $mysNameFile)
			{
				$mysNames += Get-Content "$ScriptDirectory\$myFile"
			}
			
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported given name files for $Country found!`nUse Import-GivenNames -Country $Country to get Given name files."
		}
	}
	
}

function Get-SurName
{
<#
	.SYNOPSIS
		This function will get a random Sur name from a list of peoples Sur names

	.DESCRIPTION
		This function will get a random Sur name from a list of peoples Sur names in
		Denmark, England and Wales, Finland, Norway, Sweden and USA.
        To get the list/lists of Given names use the Import-SurNames function.
         
	.PARAMETER Country
        Choose from wish country you want to get a surname or use ALL for all lists
    
	.EXAMPLE 
		Get-SurName -Country DENMARK
	
	.EXAMPLE 
		Get-SurName -Country ENGLANDWALES
		
	.EXAMPLE 
		Get-SurName -Country FINLAND

	.EXAMPLE 
		Get-SurName -Country NORWAY
		
	.EXAMPLE 
        Get-SurnName -Country SWEDEN
    
	.EXAMPLE 
        Get-SurName -Country USA
        
    .EXAMPLE
        Get-SurName -Country ALL
	
	.NOTES
		NAME:      	Get-SurName
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	02/11/2018
					Added support for:
						Denmark
						Finland
						Norway
					Changed:
						Using new source and API for Sweden
						Changed UK to England and Wales
        VERSION:    3.2
#>	
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$Country
	)
	
	# Path to the current directory.
	$CurrDir = (Get-Location -PSProvider FileSystem).ProviderPath
	
	if ($country -eq "ALL")
	{
		$mysNameFiles = Get-ChildItem -Path $ScriptDirectory -Name "sNames*.txt"
		if (!($mysNameFiles -eq $null))
		{
			$mysNames = @()
			
			foreach ($myFile in $mysNameFiles)
			{
				$mysNames += Get-Content "$ScriptDirectory\$myFile"
			}
			
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported sur name files found!`nUse Import-GivenNames to get Sur name files."
		}
	}
	else
	{
		$mysNameFile = Get-ChildItem -Path $ScriptDirectory -Name "sNames$country.txt"
		if (!($mysNameFile -eq $null))
		{
			
			$mysNames = @()
			
			foreach ($myFile in $mysNameFile)
			{
				$mysNames += Get-Content "$ScriptDirectory\$myFile"
			}
			
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported sur name files for $Country found!`nUse Import-SurNames -Country $Country to get Sur name files."
		}
	}
	
}

1..100 | ForEach-Object { Write-Output "$(Get-GivenName -Country ALL) $(Get-SurName -Country ALL)" }