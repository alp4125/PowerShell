function Invoke-DownloadApplication {
    <#
        .SYNOPSIS
            Download application
        
        .DESCRIPTION
            Download application with better speed
        
        .PARAMETER Url
            URL to the application to be downloaded
            
        .PARAMETER Destination
            Destination of the application
        
        .EXAMPLE
            PS C:\> Invoke-DownloadApplication -Url "https://www.apple.com/itunes/download/win64" -Destination "$env:TEMP\iTunes64Setup.exe"
            This will download the latest version of iTunes to the temp folder.
        
        .NOTES
            Author:     Fredrik Wall
            Email:      fredrik.powershell@gmail.com
            Created:    2018-02-08
            Changed:    2021-01-13
            Version:    1.1

            Changes:
            1.1
            - Will use old $ProgressPreference settings when done downloading instead of allways use Continue.
            - Will write exeption message as well if error.
        
        .LINK
            Latest version of the function can be found here.
            https://github.com/FredrikWall/PowerShell

    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Url,
        [Parameter(Mandatory)]
        $Destination
    )
    
    try {
        # Will change $ProgressPreference to SilentlyContinue (No Progressbar)
        # This will speed up the download
        if (-not($ProgressPreference -eq "SilentlyContinue")) {
            $OldProgressPreference = $ProgressPreference
            $ProgressPreference = "SilentlyContinue"
        }
        
        Invoke-WebRequest -Uri $URL -OutFile $destination -ErrorAction Stop -UseBasicParsing
        
        # Will change back to the old $ProgressPreference setting
        if ($OldProgressPreference) {
            $ProgressPreference = $OldProgressPreference
            $OldProgressPreference = $null
        }
    }
    catch {
        Write-Error "Can't download application"
        Write-Output $_.Exception
    }
}
