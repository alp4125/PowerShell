Visual Studio Code
==================

Install-VisualStudioCode.ps1
------------------------------

Install script for Visual Studio Code.
Uses the Install-VSCode.ps1 script from Microsoft, adds extra extensions.
And uses both Set-OpenWithVisualStudioCode and Set-BasicPSSettingsVisualStudioCode to
make settings.

Uninstall-VisualStudioCode.ps1
------------------------------

Uninstall function for Visual Studio Code
Will uninstall both the user and system installation and with the force parameter It will also
erase extensions and settings.

Set-OpenWithVisualStudioCode.ps1
--------------------------------

Will add
"Open with Code" action to Windows Explorer file context menu
and
"Open with Code" action to Windows Explorer directory context menu

Set-BasicPSSettingsVisualStudioCode.ps1
---------------------------------------

This function will use the settings.json file from here to
do some basic PowerShell settings to Visual Studio Code.

settings.json
-------------

My basic settings file for Visual Studio Code as my PowerShell script editor.

Visual Studio Code and GitHub CheatSheet.pdf
--------------------------------------------

A basic CheatSheet for setting up Visual Studio Code for GitHub.
To install Git and configure it and to clone a repository on GitHub, pull from GitHub and push to GitHub.
