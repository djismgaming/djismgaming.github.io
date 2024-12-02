---
title: Fix your SLOW Origin Games download speeds – UPDATED
draft: false
date: 2024-10-13
tags:
  - origin
  - gaming
authors:
  - djismgaming
categories:
  - Gaming
---
UPDATE 2023.10.13 - This post is here just for history's sake as Origin is basically deprecated at this point in time. It's always nice to keep history though. :wink:

UPDATE 2021.08.20 – This is a non-issue for me anymore although now I personally use EA Desktop with the Xbox Game Pass for PC. I have Origin installed but have not used it directly anymore since.

ORIGINAL POST BELOW:

Origin can be a bit sluggish at times. But we have to live with it no matter what (for now maybe? who knows).

Recently I was downloading the latest patch for Apex Legends. But when I saw my client downloading @ 2.5 MB/s on a 70 Mbps connection, I got intrigued to say the least. Mad could be a better description of the moment. I could get up to 8.75 MB/s on that connection theoretically. I use a 1 GBps wired connection for the computer to my router and also a 1 GBps wired connection from said router to the cable company modem. This is a best case scenario for Origin.

I got into research overdrive that night. Looking over all the internet to find how to fix this. Some reddit posts and forum replies later… I came across this HUGE post on answers.ea.com which has been running for almost 3 years now. People very mad and trying all kind of methods to try to squeeze the most out of their connection. Looking to get better download speeds on Origin to get their games and updates.

There was no good fix for this.

So I searched deeper and found this little snippet of information from the site https://www.pcgamingwiki.com/. The post section, which you can read here, is in regards to resolving an issue where the Origin client suddenly stops downloading mid-download. But says it has been reported to improve the download speeds also.

Mod hat ON!

The excerpt from the site is here for your convenience. Very easy steps:

- Exit Origin
- Create a new empty document on your desktop
- Enter the following text in the file:

```config
[connection]
EnvironmentName=production
 
[Feature]
CdnOverride=akamai
```

- Save the file as EACore.ini.
- Now start Origin.

Upon start you will be asked if you want to import the file you just created on your desktop.
Press Yes.
This will overwrite your old config-file.

#### Note

- The EACore.ini file is deleted from your desktop as soon as you import it. If you ever want to leave R&D mode you need to go to the location where Origin is installed and delete the EACore.ini file found there.

It has been reported that having Origin in R&D-mode will increase your download speed.
This made a huge change for me. The Origin client started with a display of “R&D | PR” in the upper right corner. Then trying the remainder of the patch download I was amazed to see 8.83 MB/s of download speed in Origin.

As a note, I also use Google Public DNS in my gaming computer. That is DNS servers:

8.8.8.8 and 8.8.4.4

The patch just took a couple of minutes to download this time. Hope this helps someone out there.