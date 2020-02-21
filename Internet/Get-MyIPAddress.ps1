function Get-MyIPAddress {
<#
    .SYNOPSIS
        Get you Internet IP Address

    .DESCRIPTION
        Get you Internet IP Address from whatismyipaddress.com
        
    .EXAMPLE
        Get-MyIPAddress
        
    .NOTES
        AUTHOR:     Fredrik Wall, fredrik@poweradmin.se
        CREATED:    2020-02-21
        VERSION:    1.0
#>

    $MyIPAddress = Invoke-RestMethod "bot.whatismyipaddress.com"

    Return $MyIPAddress
}

Get-MYIPAddress
