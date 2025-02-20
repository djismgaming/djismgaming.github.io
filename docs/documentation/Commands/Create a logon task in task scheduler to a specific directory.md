---
draft: false
categories:
  - Windows
  - Gaming
---
# Create a logon task in task scheduler to a specific directory

```pwsh
sudo schtasks /create /sc onlogon /tn "user\Steam" /rl highest /tr '"C:\Program Files (x86)\Steam\steam.exe" -silent'
```