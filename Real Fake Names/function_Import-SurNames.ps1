function Import-SurNames
{
<#
	.SYNOPSIS
		This function will create a list of peoples surnames

	.DESCRIPTION
		This function will create a list of peoples surnames in England and Wales, Norway, Sweden or USA.
        The file will be created in the same folder as the script and will be named sNames[Country].txt.
		You need to have internet access when you run this function.
	
	.PARAMETER Country
        Choose from wish country you want to create a list of peoples surnames 
    
	.EXAMPLE 
        Import-SurNames -Country ENGLANDWALES
	
	.EXAMPLE 
        Import-SurNames -Country NORWAY

	.EXAMPLE 
        Import-SurNames -Country SWEDEN
    
	.EXAMPLE 
        Import-SurNames -Country USA

	.EXAMPLE 
        Import-SurNames -Country SWEDEN | Out-Null
	
	.NOTES
		NAME:      	Import-SurNames
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	02/11/2018
					Added support for:
						Norway
					Changed:
						Using new source and API for Sweden
						Changed UK to England and Wales and using new source
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
	
	# Path to all local files
	$sNamesFile = "$currdir\sNames" + $country + ".txt"
	
	Write-Output "Will create the list of surnames for $country"
	
	# Deleting old files
	if ((Test-Path -path $sNamesFile))
	{
		Remove-Item $sNamesFile
	}
	
	switch ($Country)
	{
		
		"ENGLANDWALES" {
			# The England and Wales file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 500 most common surnames in the England and Wales
			
			# Surnames
			$HTML = Invoke-WebRequest "https://surnames.behindthename.com/top/lists/england-wales/"
			$myNames = $HTML.parsedhtml.getelementsbytagname("TR") |
			
			ForEach-Object {
				($_.children |
					Where-Object { $_.tagName -eq "td" } |
					Select-Object -ExpandProperty innerText -First 2 | Select-Object -Last 1
				)
			}
			
			# Sort the names and only takes the unique ones
			$myNames = $myNames | Sort-Object -Unique
			
			# Fixing the Given line, that is an empty one and some lines in the end
			$myNames = $myNames | Select-Object -Skip 1 | Select-Object -First 500
			
			# Triming all names from blank spaces
			$myNames = $myNames.Trim()
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Save the names to a text file
			$myNames | Out-File $sNamesFile -Append
		}
		
		"Norway" {
			# The Norway file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 100 most common surnames in Norway
			
			# Surnames
			$HTML = Invoke-WebRequest "https://surnames.behindthename.com/top/lists/norway/"
			$myNames = $HTML.parsedhtml.getelementsbytagname("TR") |
			
			ForEach-Object {
				($_.children |
					Where-Object { $_.tagName -eq "td" } |
					Select-Object -ExpandProperty innerText -First 2 | Select-Object -Last 1
				)
			}
			
			# Sort the names and only takes the unique ones
			$myNames = $myNames | Sort-Object -Unique
			
			# Fixing the Given line, that is an empty one and some lines in the end
			$myNames = $myNames | Select-Object -Skip 1 | Select-Object -First 100
			
			# Triming all names from blank spaces
			$myNames = $myNames.Trim()
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Save the names to a text file
			$myNames | Out-File $sNamesFile -Append
		}
		
		"SWEDEN" {
			# The Sweden file is downloaded from 
			# http://www.namnapi.se/
			# It's a API for Swedish Names
			
			# Sur names
			$myRequest = "http://api.namnapi.se/v2/names.json?limit=100&type=surname"
			$myNames = Invoke-WebRequest $myRequest | ConvertFrom-Json
			
			# Getting surnames, sorting it and only unique names
			$mySurNames = $myNames.names.surname | Sort-Object -Unique
			
			# Count all names
			$nrOfName = $mySurNames.Count
			
			# Save the names to a text file
			$mySurNames | Out-File $sNamesFile -Append
		}
		
		"USA" {
			# The USA file is downloaded from 
			# http://names.mongabay.com/most_common_surnames.htm
			# It's a list of the 1000 most common surnames in the US
			
			$HTML = Invoke-WebRequest "http://names.mongabay.com/most_common_surnames.htm"
			$myNames = $HTML.parsedhtml.getelementsbytagname("TR") |
			
			ForEach-Object {
				($_.children |
					Where-Object { $_.tagName -eq "td" } |
					Select-Object -ExpandProperty innerText -First 1
				)
			}
			
			# Make them in lower case and sort them
			# Lower case is needed for the title case thing
			$myNames = $myNames.ToLower() | Sort-Object
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Fix so all names start with a capital letter			
			$TextInfo = (Get-Culture).TextInfo
			$myNames = $TextInfo.ToTitleCase($myNames)
			
			# Fix the names so we can save them one by one in a text file
			$myNames.Split(" ") | Out-File $sNamesFile -Append
		}
	
	}
	Write-Output "$nrOfName surnames from $country imported!"
}