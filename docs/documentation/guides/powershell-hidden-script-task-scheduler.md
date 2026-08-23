---
title: Run a PowerShell ps1 script hidden from view and scheduled on Task Scheduler for Windows
date: '2024-11-29'
tags:
- windows
- powershell
---

## The script launcher

PowerShell scripts run in a visible window by default. To run one completely hidden, launch it through a `.vbs` script executed by `wscript`.

Set up the scheduled task like this:

- In Task Scheduler
	- Action: Start a program
	- Program/script: `wscript`
	- Add arguments (optional): `<path\to\the\.vbs\file>`

The `.vbs` launcher script:

```vbs
command = "powershell.exe -ExecutionPolicy Bypass C:\path\to\script.ps1"

set shell = CreateObject("WScript.Shell")

shell.Run command,0
```
