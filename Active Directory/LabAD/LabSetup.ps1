<#
	.SYNOPSIS
		This script will create a AD tructure for lab

	.DESCRIPTION
		This script will create a AD tructure for lab.
		With users with "real" names and laptops, workstations and servers
	
	
	.NOTES
		NAME:      	
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	2017-02-03
		LASTEDIT:  	2018-12-12
					
        VERSION:    1.2
#>	

Clear-Host

# Trying to import the Microsoft AD Module
try {
	Import-Module ActiveDirectory
}
catch
{
	Write-Output "The script needs the Active Directory PowerShell module"
	Break
}

# Setting som variabels
# Finding domain stuff
$myDomainDN = (Get-ADDomain).distinguishedname
$myDNSroot = (Get-ADDomain).DNSRoot

# Setting password for creating users
$myPWD = ConvertTo-SecureString -AsPlainText "myP@ssw0rd001" -force

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

function Get-GivenName
{
<#
	.SYNOPSIS
		This function will get a random Given name from a list of peoples Given names in USA, UK or Sweden

	.DESCRIPTION
		This function will get a random Given name from a list of peoples Given names in USA, UK or Sweden.
        To get the list/lists of Given names use the Import-GivenNames function Given.
         
	.PARAMETER Country
        Choose from wish country you want to get a surname or use ALL for all lists
    
	.EXAMPLE 
        Get-GivenName -Country SWEDEN
    
	.EXAMPLE 
        Get-GivenName -Country USA

    .EXAMPLE 
        Get-GivenName -Country UK
        
    .EXAMPLE
        Get-GivenName -Country ALL
	
	.NOTES
		NAME:      	Get-GivenName
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://www.poweradmin.se/blog
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	03/23/2016
		VERSION: 	3.1
#>	
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$Country
	)
	
	# Path to the current directory.
	$CurrDir = Get-ScriptDirectory
	
	if ($country -eq "ALL")
	{
		$mysNameFiles = Get-ChildItem -Path $CurrDir -Name "gNames*.txt"
		if (!($mysNameFiles -eq $null))
		{
			$mysNames = @()
			
			foreach ($myFile in $mysNameFiles)
			{
				$mysNames += Get-Content "$currDir\$myFile"
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
		$mysNameFile = Get-ChildItem -Path $CurrDir -Name "gNames$country.txt"
		if (!($mysNameFile -eq $null))
		{
			
			$mysNames = @()
			
			foreach ($myFile in $mysNameFile)
			{
				$mysNames += Get-Content "$currDir\$myFile"
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
		This function will get a random surname from a list of peoples surnames in USA, UK or Sweden

	.DESCRIPTION
		This function will get a random surname from a list of peoples surnames in USA, UK or Sweden.
        To get the list/lists of surnames use the Import-Surnames function Given.
         
	.PARAMETER Country
        Choose from wish country you want to get a surname or use ALL for all lists
    
	.EXAMPLE 
        Get-SurName -Country SWEDEN
    
	.EXAMPLE 
        Get-SurName -Country USA

    .EXAMPLE 
        Get-SurName -Country UK
        
    .EXAMPLE
        Get-Surname -Country ALL
	
	.NOTES
		NAME:      	Get-SurName
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://www.poweradmin.se/blog
		TWITTER:	walle75
		CREATED:	12/24/2009
		LASTEDIT:  	03/20/2016
		VERSION: 	3.0
#>
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1)]
		$Country
	)
	
	# Path to the current directory.
	$CurrDir = Get-ScriptDirectory
	
	if ($country -eq "ALL")
	{
		$mysNameFiles = Get-ChildItem -Path $CurrDir -Name "snames*.txt"
		if (!($mysNameFiles -eq $null))
		{
			$mysNames = @()
			
			foreach ($myFile in $mysNameFiles)
			{
				$mysNames += Get-Content "$currDir\$myFile"
			}
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported surname files found!`nUse Import-SurNames to get surname files."	
		}
	}
	else
	{
		$mysNameFile = Get-ChildItem -Path $CurrDir -Name "snames$country.txt"
		if (!($mysNameFile -eq $null))
		{
			$mysNames = @()
			
			foreach ($myFile in $mysNameFile)
			{
				$mysNames += Get-Content "$currDir\$myFile"
			}	
			Get-Random $mysNames
		}
		else
		{
			Write-Warning "No imported surname files for $Country found!`nUse Import-SurNames -Country $Country to get surname files."
		}
	}
}

$myCurrDir = Get-ScriptDirectory
$myFile = $myCurrDir + "\LabSetup.xml"

$xml = New-Object -TypeName XML
$xml.Load($myFile)
$myOUs = $Xml.LabAD.OrganizationalUnits.OrganizationalUnit

foreach ($item in $myOUs)
{
	
	if ($item.path -eq "" -or $item.path -eq $null)
	{
		$myADPath = $myDomainDN
	}
	else
	{
		$myADPath = "$($item.path),$($myDomainDN)"
	}
	
	try
	{
		New-ADOrganizationalUnit -Name $item.Name -Path $myADPath -Description $item.description -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue
		Write-Output "`n $($item.name) - OU Created`n"
	}
	catch
	{
		if ($error[0].Exception.Message -match "already in use")
		{
			Write-Output "`n $($item.name) - OU already exists!`n"
		}
		else
		{
			
		}
		
	}
	
	if ($item.Country -eq "Yes")
	{
		$myCountrys = $Xml.LabAD.Countrys.Country
		
		foreach ($myCountry in $myCountrys)
		{
			
			$myCountryADPath = "OU=$($item.Name),$($item.path),$($myDomainDN)"
			
			
			# Creating OUs
			
			
			try
			{
				New-ADOrganizationalUnit -Name $myCountry.Name -Path $myCountryADPath -Description "$($item.Name) in $($myCountry.Name)" -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue
				Write-Output "`n   $($myCountry.Name) - Skapade OU:t`n"
			}
			catch
			{
				if ($error[0].Exception.Message -match "already in use")
				{
					Write-Output "`n   $($myCountry.Name) - OU:t Finns redan`n"
				}
				else
				{
					
				}
			}
			
			# Creating computer objects
			# Creating Laptops, Workstations and Servers
			if ($item.Name -eq "Laptops" -or $item.Name -eq "Servers" -or $item.Name -eq "Workstations")
			{
				
				If ($item.Name -eq "Laptops")
				{
					$startName = "$($myCountry.Prefix)LAP"
					$startNumberSerie = 1000
					$nrOf = $myCountry.Laptops
				}
				
				If ($item.Name -eq "Servers")
				{
					$startName = "$($myCountry.Prefix)SRV"
					$startNumberSerie = 100
					$nrOf = $myCountry.Servers
				}
				
				If ($item.Name -eq "Workstations")
				{
					$startName = "$($myCountry.Prefix)WRK"
					$startNumberSerie = 1000
					$nrOf = $myCountry.Workstations
				}
				
				$total = $startNumberSerie + $nrOf
				
				$i = 0
				
				for ($i = $startNumberSerie; $i -lt $total; $i++)
				{
					
					try
					{
						$myComputer = Get-ADComputer -LDAPFilter "(name=$($startName)$($i))" -ErrorAction SilentlyContinue
						
					}
					catch
					{
						$error
					}
					
					if (!($myComputer -eq "" -or $myComputer -eq $null))
					{
						write-host "        $($myComputer.name) - Finns redan!"
					}
					else
					{
						try
						{
							$myNewCountryADPath = "OU=$($myCountry.name),$($myCountryADPath)"
							
							New-ADComputer -Name "$($startName)$($i)" -Path $myNewCountryADPath -Description "$($item.Name) in $($myCountry.Name)" -ErrorAction SilentlyContinue
							write-host "        $($startName)$($i) - Skapad!"
						}
						catch
						{
							
						}
					}
					
					
					
					
				}
			}
			
			# Creating group objects
			# Creating Security Groups
			if ($item.Name -eq "Security Groups")
			{
				
				
				$myGroups = $Xml.LabAD.SecurityGroups.SecurityGroup
				
				$mySecurityGroupADPath = "OU=$($myCountry.Name),OU=$($item.Name),$($item.path),$($myDomainDN)"
				
				foreach ($myGroup in $myGroups)
				{
					
					
					
					try
					{
						New-ADGroup -Name "$($myGroup.name) $($myCountry.name)" -Path $mySecurityGroupADPath -GroupCategory Security -GroupScope Global -ErrorAction SilentlyContinue
						Write-Output "        $($myGroup.name) $($myCountry.name) - Skapade Gruppen"
					}
					catch
					{
						if ($error[0].Exception.Message -match "already exist")
						{
							Write-Output "        $($myGroup.name) $($myCountry.name) - Gruppen finns redan!"
						}
						else
						{
							$error[0].Exception.Message
						}
						
					}
					
				}
			}
			
			# Creating user objects
			# Creating Users
			
			if ($item.Name -eq "Users")
			{
				$nrOfUsers = $myCountry.Users
				
				$i = 0
				
				for ($i = 0;$i -le $nrOfUsers; $i++)
				{
					
					if ($myCountry.Name -eq "England") {
                        $givenname = Get-GivenName -Country UK
					    $surname = Get-SurName -Country UK
                    }
                    
                    if ($myCountry.Name -eq "USA") {
                        $givenname = Get-GivenName -Country USA
					    $surname = Get-SurName -Country USA
                    }

                    if ($myCountry.Name -eq "Sweden" -or $myCountry.Name -eq "Norway" -or $myCountry.Name -eq "Finland" -or $myCountry.Name -eq "Denmark") {
                        $givenname = Get-GivenName -Country SWEDEN
					    $surname = Get-SurName -Country SWEDEN
                    }
					
					$samAccountNumber = Get-Random -Maximum 900 -Minimum 100
					$samAccountName = "$(($givenname.ToLower()).Substring(0, 2))$(($surname.ToLower()).Substring(0, 2))$($samaccountnumber)"
					
                    $myUserADPath = "OU=$($myCountry.Name),OU=$($item.Name),$($item.path),$($myDomainDN)"
					
                    try
					{
						$myADUser = Get-ADUser $samAccountName -SearchBase $myUserADPath

					}
					catch
					{
					}
					
					if (!($myADUser -eq "" -or $myADUser -eq $null))
					{
						Write-Output "        $($samAccountName) - $($givenname).$($surname)@$($dnsroot) - Finns redan!"
						
					}
					else
					{
						try
						{
							New-ADUser -SamAccountName $samAccountName -name "$($givenname) $($surname)" -GivenName $givenname -Surname $surname -Path $myUserADPath -AccountPassword $myPWD -Enabled $true -UserPrincipalName "$($givenname).$($surname)@$($myDNSroot)"
                            Write-Output "        $($samAccountName) - $($givenname).$($surname)@$($myDNSroot) - Skapade användaren"
						}
						catch
						{
						}
					}
				}
			}
			
			
		}
		
	}
	
}