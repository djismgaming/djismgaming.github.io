---
title: "Create New Table Entries in SAP SM30 Using VBS in Excel"
description: Enter new rows into a custom SAP table via the SM30 transaction using a VBS script in Excel.
---

# Create New Table Entries in SAP SM30 Using VBS in Excel

While working on SAP Security, I've come across a few situations where a script really helps. :wink:

This is one of them.

!!! note
    Paste this into a VBA module in the Excel workbook you're working with.

    First, run the transaction once and record it with the SAP GUI Script
    Recorder to capture the real values for `<saptable>` and
    `<saptablefield>`.

    The timer code can be removed or commented out before you run the script.

```vba
Sub sm30newentriesTABLE()

'
' new entries on TABLE
'

' timer code to count time taken on script
Dim StartTime As Double
StartTime = Timer

        ''''''''''''''''''''
            'Your Code'
        ''''''''''''''''''''
' timer code to count time taken on script

' variables
Dim i, role, roleDescription, pSecondary, pPrimary
' variables

' sapgui connection
Set SapGuiAuto = GetObject("SAPGUI")
Set SapApplication = SapGuiAuto.GetScriptingEngine
Set Connection = SapApplication.Children(0)
Set session = Connection.Children(0)
' sapgui connection

'go into tcode
session.findById("wnd[0]/tbar[0]/okcd").Text = "/nSM30"
session.findById("wnd[0]/tbar[0]/btn[0]").press
session.findById("wnd[0]/usr/ctxtVIEWNAME").Text = "tablename"
session.findById("wnd[0]/usr/btnUPDATE_PUSH").press
session.findById("wnd[0]/tbar[1]/btn[5]").press

'get data from current active sheet in the opened workbook
For i = 2 To Cells.Find("*", Range("A1"), xlFormulas, , xlByRows, xlPrevious).Row
'set variables values for each row
role = Cells(i, 1).Value
roleDescription = Cells(i, 2).Value
pSecondary = Cells(i, 10).Value
pPrimary = Cells(i, 11).Value

'do new entries
session.findById("wnd[0]/<saptable>/<saptablefield>").Text = role
session.findById("wnd[0]/<saptable>/<saptablefield>").Text = roleDescription
session.findById("wnd[0]/<saptable>/<saptablefield>").Key = "Y"
session.findById("wnd[0]/<saptable>/<saptablefield>").Key = "Y"
session.findById("wnd[0]/<saptable>/<saptablefield>").Key = "PR1"
session.findById("wnd[0]/<saptable>/<saptablefield>").Text = pSecondary
session.findById("wnd[0]/<saptable>/<saptablefield>").Text = pPrimary
session.findById("wnd[0]/<saptable>/<saptablefield>").Key = "PWM"

'move one vertical scroll step down
session.findById("wnd[0]/<saptable>").verticalScrollbar.Position = i - 1

Next

' timer code to count time taken on script
MsgBox "RunTime : " & Format((Timer - StartTime) / 86400, "hh:mm:ss")
' timer code to count time taken on script

End Sub
```
