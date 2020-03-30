Ages ago, unix symbolic links were explained to me as "like windows shortcuts"...  But it turns out the converse isn't true.

## Issue
In particular, windows shortcuts retain the .lnk suffix after the original extension, which can break things.  They also don't play well with git repos.

## Solution
Windows actually does support symbolic links that are more like unix symlinks, but they're not easy to find.
They have to be created from inside a command (cmd) prompt window.  Here's an example lifted from the citationb elow:
```
mklink /h "c:\users\Will\AppData\Roaming\AppName\settings.xml" "c:\users\Will\Dropbox\settings.xml" 
```
Before the source and target paths, `mklink` takes an option which can have 3 values:
+ `/d` Creates a 'soft' link to a file (won't work with a directory)
+ `/h` Creates a 'hard' link to a file
+ `/j` Creates a 'hard' link to a directory

In unix I was taught that links are like toilet paper- the soft ones are less likely to cause irritation.
I don't know if that applies to Windows, but I'll start with soft links until there's a problem...

## Citation
http://lifehacker.com/5496652/how-to-use-symlinks-in-windows
