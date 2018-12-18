function Invoke-CleanTemp {
    <#
        .Synopsis
            Will clean the local temp folder
        .Description
            Will clean the local temp folder
        .Parameter Close
            Closes running programs
        .Example
            Clean-Temp
        .Example
            Clean-Temp Close
        .Notes
            NAME:      	Clean-Temp
            AUTHOR:    	Fredrik Wall, fredrik@poweradmin.se
            BLOG:		https://www.fredrikwall.se
            TWITTER:	walle75
            LASTEDIT:  	04/07/2010
            CHANGES:   	04/07/2010 - Added support for closing Chrome and Tweetdeck
                        30/09/2010 - Added support for closing Skype, Spotify, iTunes and Safari
    #>
        param($extra)
        if ($extra -eq 'close') {
            # Some programs that often uses temp dir for temp files
            Get-Process iexplore* | Stop-Process
            Get-Process outlook* | Stop-Process
            Get-Process word* | Stop-Process
            Get-Process excel* | Stop-Process
            Get-Process msn* | Stop-Process
            Get-Process chrome* | Stop-Process
            Get-Process tweetdeck* | Stop-Process
            Get-Process skype* | Stop-Process
            Get-Process spotify* | Stop-Process
            Get-Process itunes* | Stop-Process
            Get-Process safari* | Stop-Process
        }
            $myTemp = "$Env:temp"
            Get-Childitem $myTemp | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
            $myTemp = $null
    }
    
    cls
    
    Write-Host "Starting to Clean Temp"
    Invoke-Cleanclean-temp close
    Write-Host "Finished Cleaning Temp"