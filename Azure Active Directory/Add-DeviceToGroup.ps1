function Add-AzureADComputerToGroup {

    <#
	.SYNOPSIS
		Adds Azure Active Directory Device to AAD Group
	
	.DESCRIPTION
		Adds Azure Active Directory Device to AAD Group based on name
	
	.PARAMETER AzureADGroupName
		Azure Active Directory Group Name
	
	.PARAMETER ComputerName
		Computer Name
	 
    .EXAMPLE
            Add-AzureADComputerToGroup -AzureADGroupName "Install Chrome" -ComputerName "MyComputer002"
            
	.NOTES
		NAME:       Add-AzureADComputerToGroup
		AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
		TWITTER:    @walle75
		BLOG:       https://www.fredrikwall.se/
		CREATED:    2018-11-20
        VERSION:    1.0
	
	.LINK
		https://github.com/FredrikWall
    #>
	
	[CmdletBinding()]
    Param ([Parameter(Position = 1, Mandatory = $true)]
            [string]$AzureADGroupName,
            [Parameter(Position = 2, Mandatory = $true)]
            [string]$ComputerName
    )
        $myGroupID = (Get-AzureADGroup -filter "DisplayName eq '$($AzureADGroupName)'").ObjectID
        $myDeviceID = (Get-AzureADDevice -filter "DisplayName eq '$($ComputerName)'").ObjectID
    
        try {
            Add-AzureADGroupMember -ObjectId $myGroupID -RefObjectId $myDeviceID
            Write-Output "$($ComputerName) added to $($AzureADGroupName)"
        }
        catch {
            if ($_.exception.message -match "already exist") {
            Write-Warning "$($ComputerName) could not be added to $($AzureADGroupName). Already member!"
            }
            else {
                $_.exception.message
            }
        }
    }