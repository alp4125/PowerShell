Function Get-LDAPComputer
{
<#
	.SYNOPSIS
		Looks up Active Directory information about a computer
	
	.DESCRIPTION
		Looks up Active Directory information about a computer object using LDAP
	
	.PARAMETER ComputerName
		The name of the computer that you want to get information about
	
	.EXAMPLE
		Get-LDAPComputer -ComputerName PC001
	
	.EXAMPLE
            "PC001","PC002" | Get-LDAPComputer
	 
    .EXAMPLE
            ("PC001" | Get-LDAPComputer).Path
            
	.EXAMPLE
            "PC001" | Get-LDAPComputer | gm
	
	.NOTES
		NAME:       Get LDAP Computer Information
		AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
		TWITTER:    @walle75
		BLOG:       http://poweradmin.se/blog
		CREATED:    2012-01-20
		LASTEDIT:   2016-03-08
	
	.LINK
		https://github.com/FredrikWall/Scripts
#>
	
	[CmdletBinding()]
	Param ([Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $true)]
		$ComputerName)
	
	Process
	{
		foreach ($myComputer in $ComputerName)
		{
			
			$myActiveDomain = new-object DirectoryServices.DirectoryEntry
			$myDomain = $myActiveDomain.distinguishedName
			$mySearcher = [System.DirectoryServices.DirectorySearcher]"[ADSI]LDAP://$myDomain"
			$mySearcher.filter = "(&(objectClass=computer)(name=$myComputer))"
			
			try
			{
				$mySearcher = $mySearcher.findone().getDirectoryEntry()
				$myDistName = $mySearcher.distinguishedName
				[ADSI]"LDAP://$myDistName"
			}
			catch
			{
				
			}
		}
	}
}


