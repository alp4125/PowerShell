function Import-GivenNames
{
<#
	.SYNOPSIS
		This function will create a list of peoples given names

	.DESCRIPTION
		This function will create a list of peoples given names in
		Denmark, England and Walse, Finland, Norway, Sweden or USA.
        The file will be created in the same folder as the script and will be named gNames[Country].txt.
		You need to have internet access when you run this function.
	
	.PARAMETER Country
        Choose from wish country you want to create a list of peoples given names
    
	.EXAMPLE 
        Import-GivenNames -Country DENMARK
	
	.EXAMPLE 
        Import-GivenNames -Country ENGLANDWALES
	
	.EXAMPLE 
        Import-GivenNames -Country FINLAND
	
	.EXAMPLE 
        Import-GivenNames -Country NORWAY
	
	.EXAMPLE 
        Import-GivenNames -Country SWEDEN
    
	.EXAMPLE 
        Import-GivenNames -Country USA

	.EXAMPLE
		Import-GivenNames -Country SWEDEN | Out-Null
	
	.NOTES
		NAME:      	Import-GivenNames
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
	
	# Path to all local files
	$gNamesFile = "$currdir\gNames" + $country + ".txt"
	
	Write-Output "Will create the list of Given names for $country"
	
	# Deleting old files
	if ((Test-Path -path $gNamesFile))
	{
		Remove-Item $gNamesFile
	}
	
	switch ($Country)
	{
		
		"Denmark" {
			# The Denmark file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 99 most common Given names in the England and Wales
			
			# Male and female names
			$HTML = Invoke-WebRequest "http://www.behindthename.com/top/lists/denmark"
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
			$myNames | Out-File $gNamesFile -Append
		}
		
		"ENGLANDWALES" {
			# The England and Wales file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 991 most common Given names in the England and Wales
			
			# Male and female names
			$HTML = Invoke-WebRequest "http://www.behindthename.com/top/lists/england-wales"
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
			$myNames = $myNames | Select-Object -Skip 1 | Select-Object -First 991
			
			# Triming all names from blank spaces
			$myNames = $myNames.Trim()
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Save the names to a text file
			$myNames | Out-File $gNamesFile -Append
		}
		
		"Finland" {
			# The Finland file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 100 most common Given names in the England and Wales
			
			# Male and female names
			$HTML = Invoke-WebRequest "http://www.behindthename.com/top/lists/finland"
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
			$myNames | Out-File $gNamesFile -Append
		}
		
		"Norway" {
			# The Denmark file is downloaded from 
			# http://www.behindthename.com
			# It's a list of the 100 most common Given names in the England and Wales
			
			# Male and female names
			$HTML = Invoke-WebRequest "http://www.behindthename.com/top/lists/norway"
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
			$myNames = $myNames | Select-Object -Skip 1 | Select-Object -First 200
			
			# Triming all names from blank spaces
			$myNames = $myNames.Trim()
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Save the names to a text file
			$myNames | Out-File $gNamesFile -Append
		}
		
		"Sweden" {
			# The Sweden file is downloaded from 
			# http://www.namnapi.se/
			# It's a API for Swedish Names
			
			# Male and Female names
			$myRequest = "http://api.namnapi.se/v2/names.json?limit=200&type=firstname"
			$myNames = Invoke-WebRequest $myRequest | ConvertFrom-Json
			
			# Getting firstnames, sorting it and only unique names
			$myFirstNames = $myNames.names.firstname | Sort-Object -Unique
			
			# Count all names
			$nrOfName = $myFirstNames.Count
			
			# Save the names to a text file
			$myFirstNames | Out-File $gNamesFile -Append
		}
		
		"USA" {
			# The USA files is downloaded from 
			# http://names.mongabay.com/male_names_alpha.htm
			# http://names.mongabay.com/female_names_alpha.htm
			# It's a list of more then 5000 most common given names in the US
			
			# Male names
			$HTML = Invoke-WebRequest "http://names.mongabay.com/male_names_alpha.htm"
			$myMaleNames = $HTML.parsedhtml.getelementsbytagname("TR") |
			
			ForEach-Object {
				($_.children |
					Where-Object { $_.tagName -eq "td" } |
					Select-Object -ExpandProperty innerText -First 1
				)
			}
			
			# Female names
			$HTML = Invoke-WebRequest "http://names.mongabay.com/female_names_alpha.htm"
			$myFemaleNames = $HTML.parsedhtml.getelementsbytagname("TR") |
			
			ForEach-Object {
				($_.children |
					Where-Object { $_.tagName -eq "td" } |
					Select-Object -ExpandProperty innerText -First 1
				)
			}
			
			# Add Male and Female names together
			$myNames = $myMaleNames + $myFemaleNames
			
			# Make them in lower case and sort them
			# Lower  case is needed for the title case thing
			$myNames = $myNames.ToLower() | Sort-Object -Unique
			
			# Count all names
			$nrOfName = $myNames.Count
			
			# Fix so all names start with a capital letter
			$TextInfo = (Get-Culture).TextInfo
			$myNames = $TextInfo.ToTitleCase($myNames)
			
			# Fix the names so we can save them one by one in a text file
			$myNames.Split(" ") | Out-File $gNamesFile -Append
		}
	}
	Write-Output "$nrOfName Given names from $country imported!"
}
