function Get-PingStatus {
	<#
	.SYNOPSIS
		This function will help you to test if a computer is pingable.

	.DESCRIPTION
		This function will help you to test if a computer is pingable.

	.PARAMETER  myComputer
		The name or IP address of the computer
	.EXAMPLE
		Get-PingStatus server01
	.EXAMPLE
		if (Get-PingStatus server01) { Write-Host "I'm up!" }
	.EXAMPLE
		if (!(Get-PingStatus server01)) { Write-Host "I'm not up!" }
	.NOTES
		NAME:      	Get-PingStatus
		AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
		BLOG:		http://www.fredrikwall.se
		TWITTER:	walle75
		CREATED:	21/07/2009
        LASTEDIT:  	09/02/18
                    Added/Changed so the function will support PowerShell 6.0

                    10/02/2011
					Some minor changes.
					Added Synopsis, Description, Parameter, Examples and Notes.
	#>

	param ($myComputer)
	$myPingStatus = Get-CimInstance -Query "SELECT StatusCode FROM win32_PingStatus
	WHERE ADDRESS = '$myComputer'"
	      if ($myPingStatus.StatusCode -eq 0) {
	      	$true
	      }
	      else
	      {
	      	$false
	      }
	}

if (Get-PingStatus $env:computername) { Write-Host "I'm up!" }