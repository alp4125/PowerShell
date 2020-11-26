# Windows

These are my functions, scripts and special files for working with Windows.

All functions are stored in a separate .ps1 file.

With an standard example how to use them.

So almost all of the PowerShell files can be runned as they are.

Get-PingStatus
--------------
One of my oldest functions.
I used It before Test-Connection came and sometimes I use It today too.

Invoke-CleanTemp.ps1
--------------------
This function will clean the ***current users*** temp folder, plus the ***c:\windows\temp*** folder as standard.

Now It also has support for ***All Users*** with the parameter ***-AllUsers***

It has support for closing a set of applications first to be able to remove as much files and folders as possible.

And It has support for ***-WhatIf***

![alt text](https://github.com/FredrikWall/PowerShell/blob/master/Windows/Pictures/Invoke-CleanTemp.png?raw=true)


Windows10BuildInformation.json
------------------------------

