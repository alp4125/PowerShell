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
        Create-WiFiInfoDocument -SSID "MySSID" -Password "MyPassword" -Description "My WiFi Access"

    .NOTES
        Version:        1.0
        Author:         Fredrik Wall, fredrik.wall@retune.se
        Creation Date:  2018-04-21

		Dependencies:
		myLogo.png - in the script folder

		Code from others:
		Thanks to Patrick Lambert - http://dendory.net for the code from the Resize-Image module.

#>
Param (
	[Parameter(Mandatory = $true)][string]$SSID,
	[Parameter(Mandatory = $true)][string]$Password,
	[Parameter(Mandatory = $true)][string]$Description
)

function Resize-Image
{
   <#
    .SYNOPSIS
        Resize-Image resizes an image file

    .DESCRIPTION
        This function uses the native .NET API to resize an image file, and optionally save it to a file or display it on the screen. You can specify a scale or a new resolution for the new image.
        
        It supports the following image formats: BMP, GIF, JPEG, PNG, TIFF 
 
    .EXAMPLE
        Resize-Image -InputFile "C:\kitten.jpg" -Display

        Resize the image by 50% and display it on the screen.

    .EXAMPLE
        Resize-Image -InputFile "C:\kitten.jpg" -Width 200 -Height 400 -Display

        Resize the image to a specific size and display it on the screen.

    .EXAMPLE
        Resize-Image -InputFile "C:\kitten.jpg" -Scale 30 -OutputFile "C:\kitten2.jpg"

        Resize the image to 30% of its original size and save it to a new file.

    .LINK
        Author: Patrick Lambert - http://dendory.net
    #>
	Param ([Parameter(Mandatory = $true)]
		[string]$InputFile,
		[string]$OutputFile,
		[int32]$Width,
		[int32]$Height,
		[int32]$Scale,
		[Switch]$Display)
	
	# Add System.Drawing assembly
	Add-Type -AssemblyName System.Drawing
	
	# Open image file
	$img = [System.Drawing.Image]::FromFile((Get-Item $InputFile))
	
	# Define new resolution
	if ($Width -gt 0) { [int32]$new_width = $Width }
	elseif ($Scale -gt 0) { [int32]$new_width = $img.Width * ($Scale / 100) }
	else { [int32]$new_width = $img.Width / 2 }
	if ($Height -gt 0) { [int32]$new_height = $Height }
	elseif ($Scale -gt 0) { [int32]$new_height = $img.Height * ($Scale / 100) }
	else { [int32]$new_height = $img.Height / 2 }
	
	# Create empty canvas for the new image
	$img2 = New-Object System.Drawing.Bitmap($new_width, $new_height)
	
	# Draw new image on the empty canvas
	$graph = [System.Drawing.Graphics]::FromImage($img2)
	$graph.DrawImage($img, 0, 0, $new_width, $new_height)
	
	# Create window to display the new image
	if ($Display)
	{
		Add-Type -AssemblyName System.Windows.Forms
		$win = New-Object Windows.Forms.Form
		$box = New-Object Windows.Forms.PictureBox
		$box.Width = $new_width
		$box.Height = $new_height
		$box.Image = $img2
		$win.Controls.Add($box)
		$win.AutoSize = $true
		$win.ShowDialog()
	}
	
	# Save the image
	if ($OutputFile -ne "")
	{
		$img2.Save($OutputFile);
	}
}

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
        Version        1.0
        Author         Fredrik Wall, fredrik.wall@retune.se
        Creation Date  2018-04-24
    #>
	Param ([Parameter(Mandatory = $true)]
		[string]$SSID,
		[string]$Password,
		[string]$Description,
		[string]$Document
		)
	
	$myDocumentName = ($Document).replace(".docx", "")
	
	# Installs the QrCodeGenerator module if not installed
	if (!(Get-Module -Name "QrCodeGenerator"))
	{
		Install-Module -Name QrCodeGenerator
	}
		
	# Creating the QRCode and saves it in the same folder as the script
	New-QRCodeWiFiAccess -SSID $SSID -Password $Password -OutPath "$($env:TEMP)\QR$($SSID)_temp.png"
	
	# Resizeing the QRCode image and saves it in the same folder as the script
	Resize-Image -InputFile "$($env:TEMP)\QR$($SSID)_temp.png" -OutputFile "$($ScriptDirectory)\QR$($SSID).png" -Width 300 -Height 300
	
	
	# Create the word document
	$word = New-Object -ComObject word.application
	$word.visible = $false
	$doc = $word.documents.add()
	$selection = $word.selection
	
	# Landscape
	$selection.PageSetup.Orientation = 1
	$Selection.TypeParagraph()
	
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
	$doc.saveas([ref] "$($ScriptDirectory)\$($SSID)_WiFi_Poster.docx", [ref]$saveFormat::wdFormatDocument)
	$word.quit()
	
	# Clean up
	if (Test-Path "$($ScriptDirectory)\QR$($SSID).png")
	{
		Remove-Item "$($ScriptDirectory)\QR$($SSID).png"
	}
}

Create-WiFiInfoDocument -SSID $SSID -Password $Password -Description $Description -Document $Document