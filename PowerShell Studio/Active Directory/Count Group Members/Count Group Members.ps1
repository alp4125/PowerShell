﻿#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: 08c1da43-3bc4-4c24-96c7-70ea7f088ad8
# Source File: Count Group Members.psproj
#------------------------------------------------------------------------
#region Project Recovery Data (DO NOT MODIFY)
<#RecoveryData:
VwIAAB+LCAAAAAAABACFUtFOgzAUfV+yf2j6aMKAjTiMrA+6sOxhasbiq+nKRdDSklLm5tdbKJgt
any57WnvPSfntNEWmDyAOi2ppmQ8Qih6UvINmEbJSbBcSVF8QrrAMeU14O4wLrgGtcBXk6r2b9ta
2iW1i38sebfJulqbak9y4NVEHzXuhIzUM6i6kIJMJ37kDqC/MyqwXhIvZH5Kg5kz27PACdg0cG6u
2dyZe0DnmReGNA0jt2/uR3sHu1MFxIvccziQS54aOeSeq9U96CG6awpunHuYJJoq3VStGav1VydK
cqrauHaqMWltIQMFgkHcCKaNuQVei4N8B2fF5Z7yFxMWJnZft8n9w/4LX5LLD2dDCxFLVRq+DJMB
tS9wQWiBtfkdi0WPqngtBOVtwwMtgdzLRmi0UrKp0AbKvUnL8FVmJnJ/NI9HkXvxkb4AcKIUo1cC
AAA=#>
#endregion
<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2019 v5.6.156
     Generated on:       2018-12-18 13:53
     Generated by:       FredrikWall
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2019
#>



#region Source: Startup.pss
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
YQAAAB+LCAAAAAAABACzCUpNzi9LLap0SSxJVAAyijPz82yVjPUMlex4uRQUbPyLMtMz8xJz3DJz
Uv0Sc1PtgksSi0pKC/QKiott9DFkebls9JGNtAMAoyFkEGEAAAA=#>
#endregion
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)
		
	#--------------------------------------------------------------------------
	#TODO: Add initialization script here (Load modules and check requirements)
	
	
	#--------------------------------------------------------------------------
	
	if((Show-MainForm_psf) -eq 'OK')
	{
		
	}
	
	$script:ExitCode = 0 #Set the exit code for the Packager
}


#endregion Source: Startup.pss

#region Source: Globals.ps1
	#--------------------------------------------
	# Declare Global Variables and Functions here
	#--------------------------------------------
	
	
	#Sample function that provides the location of the script
	function Get-ScriptDirectory
	{
	<#
		.SYNOPSIS
			Get-ScriptDirectory returns the proper location of the script.
	
		.OUTPUTS
			System.String
		
		.NOTES
			Returns the correct path within a packaged executable.
	#>
		[OutputType([string])]
		param ()
		if ($null -ne $hostinvocation)
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
	
	
	
#endregion Source: Globals.ps1

#region Source: MainForm.psf
function Show-MainForm_psf
{
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
twQAAB+LCAAAAAAABABllEmrq3gQxfeC3+HytkI7xSFw34U4xjhEjUbjzuGvcZ7HT9/p15uGrtWh
DkVBcer3bYO4XcCwC+EUfn3EmLfN71/kX/ivHxj6+vq+D3mWN2El5RUwwhr86GHeSO1Q/9WN6Tf6
P/vP0D/+j6iqDj4xY5Gxlwt/F/jLv8VdBOM5nxeiuFioQ3Xo6f48cElDFEws3SF0JrPFC29E8Iza
LSkoXvgYnPzz2RkbGIo8sRI58IzcG2+Zx9wAFJghg97SlhufEYKQQDwr42KrrKdfBb5KlNVEa8CW
FtvfDE0BqTRji3odmhKGpN5WOZvFHGKoqUDJXkfv6HfeCt06eND0kav+dsNzY3PI1UqcDpOiOGzm
s/02ejKghPsNK9jVKbiHVsAQ0uouARSVektyUmbsAy9zEcRiVo9dfdX2Sbhu4V56iun3eswFXem+
3DVqaHs/PazenCoyN9K+cTAwwFArxfklBqitBqqjc4+T0OnpLmceQKjOoMfnS0FOzFJUOI2L76lX
Fw931UbujwrJ7mu24hnPisMo314hDCmv0KFUu7whi+SsB8tz462eN+XMnliaQuuOQjLcHfg78taF
sGTnbnOPt23TgHSwa1jZuVrbL9le7hQOQ9PaYz1dDVa2KF199NKcXg1zUEQ8o9O2fjmnmSbI5F3L
5YQYUiTeXcxnDPd67nl7MgUEkKFBSEaYECIMOdknJhL5TB1ipasMiYMwSCXdys2SjzZs0/Ussvgw
YPumKAhXTnJpdqmnLc3tM9tlg1lN7m3sBkltBwydNe2UDgadoOWisRGDO4OGekpblYlPTJZle7fA
xO3WH/XKDxZO8xzikGOUHtxaHWoCtZDNIWKCB9cOhlxllNC6srt6F93sfVQogRZOOHSOnIsRX9An
JaimDnEDe7wcO6ACvZDyU8B36428UrJuiPPs1s3IqBwMkRmVJ1k2xluntbEtlhS32646EqszdYN/
8fRWp+tL68nKM+ZJz6giUaVMoA2lF0QXXpK7Cci5SgavJwy9cty/f1alaNAcn8tTYfh4xGrmXftx
VNL23PoCmiJygnL7a92XQJBnfdh8Rohk1ug9YQiuloyWCZF+PmtLGOZYV9PCojzCssIonSeWvw9N
qBtv1s/aUUj9HjMDM5keR2AGs7y1zsGbOzUwatPUCclGYOvilVVhKPPESIlLe30dex82fHzqyCBG
Uf+mETVbyBUNzH1hjQfSUI1yMj9g+P2N/gHHH4RcxhHUUZWD8Qv9dL7R/4Lq52+8ahBJtwQAAA==#>
#endregion
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formCountGroupMembers = New-Object 'System.Windows.Forms.Form'
	$statusbar1 = New-Object 'System.Windows.Forms.StatusBar'
	$buttonQuit = New-Object 'System.Windows.Forms.Button'
	$groupbox2 = New-Object 'System.Windows.Forms.GroupBox'
	$label0 = New-Object 'System.Windows.Forms.Label'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$combobox1 = New-Object 'System.Windows.Forms.ComboBox'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$formCountGroupMembers_Load={
		#TODO: Initialize Form Controls here
		$activeDomain = new-object DirectoryServices.DirectoryEntry
		# Will get the current domain Distinguished Name
		$curDomain = $activeDomain.distinguishedName
		
		$searcher = New-Object DirectoryServices.DirectorySearcher($curDomain)
		$searcher.filter = "(&(objectClass=group))"
		$group = $searcher.findall()
		
		foreach ($mem in $group)
		{
			$nice = $mem.GetDirectoryEntry()
			$myGroup += [array]$nice.cn
		}
		$myGroup = $myGroup | sort
		
		$comboBox1.items.AddRange($myGroup)
		
		$comboBox1.Text = "Select a group"
	}
	
	#region Control Helper Functions
	function Update-ComboBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ComboBox.
		
		.DESCRIPTION
			Use this function to dynamically load items into the ComboBox control.
		
		.PARAMETER ComboBox
			The ComboBox control you want to add items to.
		
		.PARAMETER Items
			The object or objects you wish to load into the ComboBox's Items collection.
		
		.PARAMETER DisplayMember
			Indicates the property to display for the items in this control.
			
		.PARAMETER ValueMember
			Indicates the property to use for the value of the control.
		
		.PARAMETER Append
			Adds the item(s) to the ComboBox without clearing the Items collection.
		
		.EXAMPLE
			Update-ComboBox $combobox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Update-ComboBox $combobox1 "Red" -Append
			Update-ComboBox $combobox1 "White" -Append
			Update-ComboBox $combobox1 "Blue" -Append
		
		.EXAMPLE
			Update-ComboBox $combobox1 (Get-Process) "ProcessName"
		
		.NOTES
			Additional information about the function.
	#>
		
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ComboBox]
			$ComboBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]$DisplayMember,
			[Parameter(Mandatory = $false)]
			[string]$ValueMember,
			[switch]
			$Append
		)
		
		if (-not $Append)
		{
			$ComboBox.Items.Clear()
		}
		
		if ($Items -is [Object[]])
		{
			$ComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ComboBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ComboBox.Items.Add($obj)
			}
			$ComboBox.EndUpdate()
		}
		else
		{
			$ComboBox.Items.Add($Items)
		}
		
		$ComboBox.DisplayMember = $DisplayMember
		$ComboBox.ValueMember = $ValueMember
	}
	#endregion
	
	$buttonGetGroups_Click={
		#TODO: Place custom script here
		#TODO: Initialize Form Controls here
		
	}
	
	$combobox1_SelectedIndexChanged={
		#TODO: Place custom script here
		if (!($comboBox1.Text -match "Select a group"))
		{
			$myActiveDomain = new-object DirectoryServices.DirectoryEntry
			$myDomain = $myActiveDomain.distinguishedName
			
			$myUppgraderingsListaItemsProgramItemGroup = $comboBox1.Text
			$searcher = [System.DirectoryServices.DirectorySearcher]"[ADSI]LDAP://$mydomain"
			$searcher.filter = "(&(objectClass=group)(sAMAccountName=$myUppgraderingsListaItemsProgramItemGroup))"
			$searcher = $searcher.findone().getDirectoryEntry()
			$distGroupName = $searcher.distinguishedName
			
			$group = [ADSI]("LDAP://$distGroupName")
			if (!(($group.member).count -eq $null))
			{
				$label0.text = ($group.member).count
			}
			else
			{
				$label0.text = "0"
			}
		}
	}
	
	$buttonQuit_Click={
		#TODO: Place custom script here
		$formCountGroupMembers.close()
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formCountGroupMembers.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:MainForm_combobox1 = $combobox1.Text
		$script:MainForm_combobox1_SelectedItem = $combobox1.SelectedItem
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonQuit.remove_Click($buttonQuit_Click)
			$combobox1.remove_SelectedIndexChanged($combobox1_SelectedIndexChanged)
			$formCountGroupMembers.remove_Load($formCountGroupMembers_Load)
			$formCountGroupMembers.remove_Load($Form_StateCorrection_Load)
			$formCountGroupMembers.remove_Closing($Form_StoreValues_Closing)
			$formCountGroupMembers.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formCountGroupMembers.SuspendLayout()
	$groupbox1.SuspendLayout()
	$groupbox2.SuspendLayout()
	#
	# formCountGroupMembers
	#
	$formCountGroupMembers.Controls.Add($statusbar1)
	$formCountGroupMembers.Controls.Add($buttonQuit)
	$formCountGroupMembers.Controls.Add($groupbox2)
	$formCountGroupMembers.Controls.Add($groupbox1)
	$formCountGroupMembers.AutoScaleDimensions = '6, 13'
	$formCountGroupMembers.AutoScaleMode = 'Font'
	$formCountGroupMembers.ClientSize = '429, 240'
	$formCountGroupMembers.Name = 'formCountGroupMembers'
	$formCountGroupMembers.StartPosition = 'CenterScreen'
	$formCountGroupMembers.Text = 'Count Group Members'
	$formCountGroupMembers.add_Load($formCountGroupMembers_Load)
	#
	# statusbar1
	#
	$statusbar1.Location = '0, 218'
	$statusbar1.Name = 'statusbar1'
	$statusbar1.Size = '429, 22'
	$statusbar1.TabIndex = 3
	#
	# buttonQuit
	#
	$buttonQuit.Location = '341, 188'
	$buttonQuit.Name = 'buttonQuit'
	$buttonQuit.Size = '75, 23'
	$buttonQuit.TabIndex = 2
	$buttonQuit.Text = 'Quit'
	$buttonQuit.UseCompatibleTextRendering = $True
	$buttonQuit.UseVisualStyleBackColor = $True
	$buttonQuit.add_Click($buttonQuit_Click)
	#
	# groupbox2
	#
	$groupbox2.Controls.Add($label0)
	$groupbox2.Location = '13, 81'
	$groupbox2.Name = 'groupbox2'
	$groupbox2.Size = '404, 100'
	$groupbox2.TabIndex = 1
	$groupbox2.TabStop = $False
	$groupbox2.Text = 'Members'
	$groupbox2.UseCompatibleTextRendering = $True
	#
	# label0
	#
	$label0.Anchor = 'Top, Bottom, Left, Right'
	$label0.Font = 'Microsoft Sans Serif, 25pt, style=Bold'
	$label0.Location = '60, 12'
	$label0.Name = 'label0'
	$label0.Size = '315, 85'
	$label0.TabIndex = 0
	$label0.Text = '0'
	$label0.TextAlign = 'MiddleCenter'
	$label0.UseCompatibleTextRendering = $True
	#
	# groupbox1
	#
	$groupbox1.Controls.Add($combobox1)
	$groupbox1.Location = '13, 13'
	$groupbox1.Name = 'groupbox1'
	$groupbox1.Size = '404, 61'
	$groupbox1.TabIndex = 0
	$groupbox1.TabStop = $False
	$groupbox1.Text = 'AD Group'
	$groupbox1.UseCompatibleTextRendering = $True
	#
	# combobox1
	#
	$combobox1.FormattingEnabled = $True
	$combobox1.Location = '7, 20'
	$combobox1.Name = 'combobox1'
	$combobox1.Size = '391, 21'
	$combobox1.TabIndex = 0
	$combobox1.add_SelectedIndexChanged($combobox1_SelectedIndexChanged)
	$groupbox2.ResumeLayout()
	$groupbox1.ResumeLayout()
	$formCountGroupMembers.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formCountGroupMembers.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formCountGroupMembers.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formCountGroupMembers.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formCountGroupMembers.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formCountGroupMembers.ShowDialog()

}
#endregion Source: MainForm.psf

#Start the application
Main ($CommandLine)
