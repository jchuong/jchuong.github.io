---
layout: post
title: How to Install Gfire Plugin on Crunchbang Linux
tags: linux guide
---

After reinstalling Windows 8 after it probably automatically installed something via Windows update that resulted in black screens, I found out that it also somehow marked my Crunchbang root partition unallocated.

So after reinstalling Crunchbang, I realized that there isn't a good guide to installing the [*Gfire plugin*][1] on Crunchbang/Debian since there are some dependency issues.

So here's a quick guide to compiling gfire for Wheezy:

The first symptom is that the .deb of gfire complains that you do not have a version of **libnotify1** installed.  

In Crunchbang Waldorf/Debian Wheezy, you might notice that libnotify1 doesn't exist; you have libnotify4 installed.

1. Download the source from [sourceforge][2]
2. Unzip the tar.bz2 with
`tar xjf pidgin-gfire-0.9.4.tar.bz2`
3. Change directories to the unzipped files
4. Run 
`./configure`
 and see the output.  If you are on a clean install, then here's what you might encounter.
5. You are missing `pkg-config`, so install it: `apt-get install pkg-config`
6. You are missing `Purple`, so install the library `apt-get install libpurple-dev`
7. You are missing intltool, install it `apt-get install intltool`
8. If configure complains that libpurple was not found after installing it, use `./configure --prefix=/usr` 
9. Hopefully, configure finally finishes without errors now, so run `./make`
10. Finish the installation with `make install`

Now, when you fire up Pidgin, you should have the Gfire plugin installed!

[1]:gfireproject.org
[2]:http://sourceforge.net/projects/gfire/files/gfire/gfire-0.9.4/pidgin-gfire-0.9.4.tar.bz2/download
