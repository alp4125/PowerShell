<#
	.SYNOPSIS
		This script will restart the MobiControl Deployment Service

	.DESCRIPTION
		This script will restart the MobiControl Deployment Service
	
	.NOTES
		NAME:      	Restart-MobiControlService.ps1
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://fredrikwall.se
		TWITTER:	walle75
		CREATED:	2018-10-13
							
        VERSION:    1.0
#>	

# Restart MobiControl Deployment Service
Get-Service MCDPSRV | Restart-Service
