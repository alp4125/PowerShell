#requires -RunAsAdministrator
#requires -version 5
<#
    .SYNOPSIS
        Creates a Word document with logo and QRCode for connection to WiFi

    .DESCRIPTION
        Creates a Word document with logo and QRCode for connection to WiFi

	.PARAMETER SSID
        The SSID of the WiFi network

	.PARAMETER Password
        The Password

	.PARAMETER Description
        The header of the document

    .EXAMPLE
        Create-WiFiPoster.ps1 -SSID "MySSID" -Password "MyPassword" -Description "My WiFi Access" -Document "MyWiFiNetworkInfo.docx"
    .NOTES
        Version:        1.1
        Author:         Fredrik Wall, fredrik.wall@retune.se
        Creation Date:  2018-04-21
        Last change:    2018-06-26

		Dependencies:
		myLogo.png - in the script folder

#>
Param (
	[Parameter(Mandatory = $true)][string]$SSID,
	[Parameter(Mandatory = $true)][string]$Password,
	[Parameter(Mandatory = $true)][string]$Description,
    [Parameter(Mandatory = $true)][string]$Document
)


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

#Sample variable that provides the location of the script
[string]$ScriptDirectory = Get-ScriptDirectory

function Create-WiFiInfoDocument
{
   <#
    .SYNOPSIS
		Creates a WiFi Connection Document

    .DESCRIPTION
        Creates a WiFi Connection Document
 
    .EXAMPLE
        Create-WiFiInfoDocument -SSID "My WiFi Network" -Password "MyPassword2018" -Document "MyWiFiNetworkInfo.docx"

    .NOTES
        Version        1.1
        Author         Fredrik Wall, fredrik.wall@retune.se
        Creation Date  2018-04-24
        Last change:    2018-06-26
    #>
	Param ([Parameter(Mandatory = $true)]
		[string]$SSID,
		[string]$Password,
		[string]$Description,
		[string]$Document
		)
		
	# Installs the QrCodeGenerator module if not installed
	if (!(Get-Module -Name "QrCodeGenerator"))
	{
		Install-Module -Name QrCodeGenerator
	}
		
	# Creating the QRCode and saves it in the same folder as the script
	New-QRCodeWiFiAccess -SSID $SSID -Password $Password -OutPath "$($ScriptDirectory)\QR$($SSID).png" -Width 10
		
	# Create the word document
	$word = New-Object -ComObject word.application
	$word.visible = $true
	$doc = $word.documents.add()
	$selection = $word.selection
	
	# Landscape
	$selection.PageSetup.Orientation = 1
	$Selection.TypeParagraph()

    # Top Margin
    $selection.PageSetup.TopMargin = 5
	
	# Center
	$selection.Paragraphs.Alignment = 1
	
	# Adding the logo
	$Selection.TypeParagraph()
	$selectimage = $selection.InlineShapes.AddPicture("$($ScriptDirectory)\myLogo.png")
	
	# Adding the description
	$Selection.TypeParagraph()
	$Selection.Font.Bold = 1
	$Selection.Font.Size = 30
	$Selection.TypeText($Description)
	
	# Adding the QRCode
	$Selection.TypeParagraph()
	$selectimage = $selection.InlineShapes.AddPicture("$($ScriptDirectory)\QR$($SSID).png")
	
	# Adding the SSID
	$Selection.TypeParagraph()
	$Selection.Font.Bold = 1
	$Selection.Font.Size = 10
	$Selection.TypeText("SSID: $($SSID)")
	
	# Adding the Password
	$Selection.TypeParagraph()
	$Selection.Font.Bold = 1
	$Selection.Font.Size = 10
	$Selection.TypeText("Password: $($Password)")
	
	# Saves the word document in the same folder as the script
	$doc.saveas([ref] "$($ScriptDirectory)\$($Document)", [ref]$saveFormat::wdFormatDocument)
	$word.quit()
	
	# Clean up
	if (Test-Path "$($ScriptDirectory)\QR$($SSID).png")
	{
		Remove-Item "$($ScriptDirectory)\QR$($SSID).png"
	}
}

Create-WiFiInfoDocument -SSID $SSID -Password $Password -Description $Description -Document $Document