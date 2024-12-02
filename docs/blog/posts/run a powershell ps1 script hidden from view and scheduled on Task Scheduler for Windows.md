---
title: run a powershell ps1 script hidden from view and scheduled on Task Scheduler for Windows
draft: false
date: 2024-11-29
tags:
  - windows
  - powershell
authors:
  - djismgaming
categories:
  - Windows
---

## The script launcher

We need a script launcher as PowerShell scripts run in the foreground and we don't want the window of this script to appear at all.

This one can be a `.vbs` file that will be setup like this
- In Task Scheduler
	- Action: Start a program
	- Program/script: `wscript`
	- Add arguments (optional): `<path\to\the\.ps1\file>`

Here is the `.vbs` script:

```vbs
command = "powershell.exe  -ExecutionPolicy Bypass  C:\Users\Ismael\Documents\GitHub\djismgaming.github.io\blogupdate.ps1"

set shell = CreateObject("WScript.Shell")

shell.Run command,0
```