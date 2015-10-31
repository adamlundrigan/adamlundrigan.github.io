---
title: Imaging the HP ProBook 6560b
date: 2011-11-22T17:08:00.000Z
tags:
    - random
disqus:
    identifier: 6
---
<p>After much (MUCH) head->desk while trying to make Symantec Ghost Solution Suite's WinPE boot disc pick up a network connection on the new HP ProBook 6560b, I've sorted the issue! Thanks, in no small part, to this thread: <a href='http://communities.intel.com/thread/21719'>http://communities.intel.com/thread/21719</a></p>

<p>If you already have a GSS WinPE boot CD you can simply boot into it, and follow these instructions:</p>

<ol>
<li><a href="http://downloadcenter.intel.com/detail_desc.aspx?agr=Y&amp;DwnldID=18719">Download the latest Intel PRO1000 drivers here</a> (The PROWin32.exe is the one you are looking for.  Yes, it says Server 2003, but that's OK)  </li>
<li>Using 7-Zip (or similar program) decompress the EXE to a folder on your hard drive  </li>
<li>Copy the extracted folder to a USB drive  </li>
<li>Plug the USB drive into the laptop which you've booted into WinPE  </li>
<li>From the command prompt, navigate to the folder: <code>E:\PROWin32\PRO1000\Win32\NDIS61</code>   (your USB drive may have a different letter)  </li>
<li>Run this command: <code>drvload e1c6032.inf</code></li>
</ol>

<p>Voila, you should now have wired network access!  </p>

<p>Of course, you could also create a new WinPE image when using the Symantec Ghost Boot Wizard and include that NDIS61 folder directly in WinPE.  That would eliminate the need to use <code>drvload</code> after booting into WinPE.</p>