---
title: Create a logon task in task scheduler to a specific directory
date: 2026-08-18
tags:
- commands
---

```pwsh
sudo schtasks /create /sc onlogon /tn "user\Steam" /rl highest /tr '"C:\Program Files (x86)\Steam\steam.exe" -silent'
```