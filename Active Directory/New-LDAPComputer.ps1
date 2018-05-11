Function New-LDAPComputer
{
<#
	.SYNOPSIS
		Creates an Active Directory computer object
	
	.DESCRIPTION
		Creates an Active Directory computer object using LDAP.
        The computer will be disabled. Created with just the basic stuff.
	
    .PARAMETER ComputerName
		The name of the computer
        
    .PARAMETER SAMAccountName
		The SAMAccount name
        
    .PARAMETER OUPath
        The distinguishedName of the OU where the computer should be created in.
        
    .EXAMPLE
        New-LDAPComputer -ComputerName "PC001" -SAMAccountName "PC001" -OUPath "OU=Test,OU=Computers,OU=LabOU,DC=poweradmin,DC=se"
        
    .EXAMPLE
        New-LDAPComputer "PC001" "PC001" "OU=Test,OU=Computers,OU=LabOU,DC=poweradmin,DC=se"
        
	.NOTES
		NAME:       New-LDAPComputer
		AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
		TWITTER:    @walle75
		BLOG:       http://www.fredrikwall.se
		CREATED:    2012-01-15
		LASTEDIT:   2016-03-09
		VERSION:    2.1
	
	.LINK
		https://github.com/FredrikWall

#>
	
	[CmdletBinding()]
	Param (
		[Parameter(Position = 1, Mandatory = $true)]
		$ComputerName,
		[Parameter(Position = 2, Mandatory = $true)]
		$SAMAccountName,
		[Parameter(Position = 3, Mandatory = $true)]
		$OUPath
	)
	
	try
	{
		$myOU = new-Object DirectoryServices.DirectoryEntry "LDAP://$OUPath"
		$newComputer = $myOU.psbase.children.add("cn=" + $ComputerName, "computer")
		$newComputer.psbase.commitchanges()
		
		$newComputer.samaccountname = $SAMAccountName
		$newComputer.psbase.commitchanges()
	}
	catch
	{
		Write-Warning "$ComputerName `n$_"
	}
}
