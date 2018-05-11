Function Get-LDAPGroup
{
	<# 
	    .SYNOPSIS
            Get Active Directory group information
            
	    .DESCRIPTION
            Get Active Directory group information using LDAP
             
        .PARAMETER GroupName
		The name of the group that you want to get information about
        
	    .EXAMPLE
            Get-LDAPGroup -GroupName GROUP01
            
	    .EXAMPLE
            "GROUP01" | Get-LDAPGroup
            
	    .EXAMPLE
            "GROUP01","GROUP02" | Get-LDAPGroup
            
	    .EXAMPLE
            ("GROUP01" | Get-LDAPGroup).Path
            
	    .EXAMPLE
            "GROUP01" | Get-LDAPGroup | gm
            
        .NOTES
            NAME:       Get-LDAPGroup
            AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
            TWITTER:    @walle75
            BLOG:       http://www.fredrikwall.se
            CREATED:    2012-02-12
            LASTEDIT:   2016-03-07
            VERSION:    2.1
	
        .LINK
            https://github.com/FredrikWall
        
	#>	
	
	[CmdletBinding()]
	Param ([Parameter(Position = 1, Mandatory = $true, ValueFromPipeline = $true)]
		$GroupName)
	Process
	{
		foreach ($myGroup in $GroupName)
		{
			
			$myActiveDomain = new-object DirectoryServices.DirectoryEntry
			$myDomain = $myActiveDomain.distinguishedName
			$mySearcher = [System.DirectoryServices.DirectorySearcher]"[ADSI]LDAP://$myDomain"
			$mySearcher.filter = "(&(objectClass=group)(name=$myGroup))"
			
			try
			{
				$mySearcher = $mySearcher.findone().getDirectoryEntry()
				$myDistName = $mySearcher.distinguishedName
				[ADSI]"LDAP://$myDistName"
			}
			catch
			{
				Write-Warning "$_"
			}
		}
	}
}