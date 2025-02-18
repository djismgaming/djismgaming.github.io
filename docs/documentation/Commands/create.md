---
draft: true
---
# Create a logon task in task scheduler to a specific directory

`sudo schtasks /create /sc onlogon /tn "ismael\Steam" /rl highest /tr "C:\Program Files (x86)\Steam\steam.exe"`