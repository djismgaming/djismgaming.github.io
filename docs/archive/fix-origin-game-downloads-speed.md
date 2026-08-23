---
title: Fix your SLOW Origin Games download speeds – UPDATED
date: '2024-10-13'
tags:
- origin
- gaming
---

!!! warning "Deprecated"

    Origin is deprecated at this point in time. This entry is kept for historical purposes only.

!!! note

    UPDATE 2021.08.20 - This is a non-issue anymore; EA Desktop with the Xbox Game Pass for PC replaced direct use of the Origin client.

ORIGINAL POST BELOW:

Origin can be sluggish at times.

While downloading a large game patch, the client downloaded @ 2.5 MB/s on a 70 Mbps connection, well below the theoretical maximum of 8.75 MB/s on that connection. This was with a best-case setup: a 1 GBps wired connection from the computer to the router and another from the router to the cable company modem.

Research on Reddit posts, forum replies, and a long-running thread on answers.ea.com showed people trying all kinds of methods to improve Origin download speeds. There was no good official fix for this.

A snippet of information from https://www.pcgamingwiki.com/ pointed to a workaround. The post section, readable [here](https://www.pcgamingwiki.com/wiki/Origin), addresses an issue where the Origin client suddenly stops downloading mid-download, but reports that it also improves download speeds.

The excerpt from the site is reproduced below. Very easy steps:

- Exit Origin
- Create a new empty document on your desktop
- Enter the following text in the file:

```config
[connection]
EnvironmentName=production
 
[Feature]
CdnOverride=akamai
```

- Save the file as `EACore.ini`.
- Now start Origin.

Upon start, Origin asks whether to import the file created on the desktop.
Press Yes.
This overwrites the old config file.

#### Note

- The EACore.ini file is deleted from the desktop as soon as it is imported. To leave R&D mode later, go to the location where Origin is installed and delete the EACore.ini file found there.

It has been reported that having Origin in R&D-mode increases download speed.
With this change, the Origin client started with a display of “R&D | PR” in the upper right corner. On the next patch download, Origin reached 8.83 MB/s.

As a note, Google Public DNS (`8.8.8.8` and `8.8.4.4`) was also in use on the gaming computer.

The patch downloaded in a couple of minutes with these settings.
