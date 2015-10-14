A simple script to rename all files in a folder, and create a simple CSV file in the same folder which serves as a "key" to match the original filename to the new, randomly-generated names.  Suitable for blind analysis, such as in a laboratory setting.  Almost certainly easier than trying to create an ImageJ plugin. =)

There are no prerequisites or dependencies beyond Perl itself: just download it, make sure it's executable, and run it.  On Linux or BSD or Mac, you should already have Perl, and I'd recommend putting it in `/usr/local/bin` and `chmod 755 /usr/local/bin/blindrename.pl`, after which you can just type **blindrename.pl** ***foldername*** and it will obligingly do its thing.  On Windows... well, do whatever you need to do to run a Perl script on Windows.  (If you're a lost little scientist with only Windows: check out <a href="http://www.cygwin.com/" target="_blank">Cygwin</a> or <a href="http://www.activestate.com/activeperl" target="_blank">ActivePerl</a> for Windows implementations of Perl.)

`blindrename.pl` is reasonably smart - it will test to make sure that you supply a foldername, and that the foldername exists and is a folder.  It also refuses to blindrename a folder *twice* - if there's already a `keyfile.csv` present, it'll die and let you know why.  It logs each rename to `keyfile.csv` *before* actually performing the operation, and will die if it can't successfully rename a file.  Finally, it won't traverse subdirectories, and it won't rename dotfiles.  With all that said... this is still a potentially **really destructive** operation.  **Don't** run `blindrename.pl` on any important system folders, please... including but not limited to your own home folder!

Sample usage:

~~~~
me@banshee:~/git/blindanalysis$ ls -l /tmp/test
total 4
-rw-rw-r-- 1 me me    0 Oct 14 12:55 1.tif
-rw-rw-r-- 1 me me    0 Oct 14 12:56 2.tif
-rw-rw-r-- 1 me me    0 Oct 14 12:56 3.tif
-rw-rw-r-- 1 me me    0 Oct 14 12:56 4.tif
-rw-rw-r-- 1 me me    0 Oct 14 12:56 5
drwxrwxr-x 2 me me 4096 Oct 14 12:56 subdir

me@banshee:~/git/blindanalysis$ ./blindrename.pl /tmp/test

me@banshee:~/git/blindanalysis$ ls -l /tmp/test
total 8
-rw-rw-r-- 1 me me    0 Oct 14 12:56 7icWm.tif
-rw-rw-r-- 1 me me    0 Oct 14 12:56 CTdOD
-rw-rw-r-- 1 me me    0 Oct 14 12:56 Io5cO.tif
-rw-rw-r-- 1 me me  131 Oct 14 13:06 keyfile.csv
-rw-rw-r-- 1 me me    0 Oct 14 12:55 OnvFt.tif
drwxrwxr-x 2 me me 4096 Oct 14 12:56 subdir
-rw-rw-r-- 1 me me    0 Oct 14 12:56 tresH.tif

me@banshee:~/git/blindanalysis$ cat /tmp/test/keyfile.csv
"Original Filename","Cloaked Filename"
"1.tif","OnvFt.tif"
"2.tif","tresH.tif"
"3.tif","Io5cO.tif"
"4.tif","7icWm.tif"
"5","CTdOD"
~~~~
