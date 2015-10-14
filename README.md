A simple script to rename all files in a folder, and create a simple CSV file in the same folder which serves as a "key" to match the original filename to the new, randomly-generated names.  Suitable for blind analysis.

Sample usage:

~~~~
me@banshee:~/git/blindanalysis$ ls -l /tmp/test
total 4
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:55 1.tif
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 2.tif
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 3.tif
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 4.tif
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 5
drwxrwxr-x 2 jimbo jimbo 4096 Oct 14 12:56 subdir

me@banshee:~/git/blindanalysis$ ./blindrename.pl /tmp/test

me@banshee:~/git/blindanalysis$ ls -l /tmp/test
total 8
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 7icWm.tif
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 CTdOD
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 Io5cO.tif
-rw-rw-r-- 1 jimbo jimbo  131 Oct 14 13:06 keyfile.csv
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:55 OnvFt.tif
drwxrwxr-x 2 jimbo jimbo 4096 Oct 14 12:56 subdir
-rw-rw-r-- 1 jimbo jimbo    0 Oct 14 12:56 tresH.tif

me@banshee:~/git/blindanalysis$ cat /tmp/test/keyfile.csv
"Original Filename","Cloaked Filename"
"1.tif","OnvFt.tif"
"2.tif","tresH.tif"
"3.tif","Io5cO.tif"
"4.tif","7icWm.tif"
"5","CTdOD"
~~~~
