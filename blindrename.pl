#!/usr/bin/perl

# take a foldername as an argument.
#
# for each file in [foldername], rename it to a randomly-generated filename preserving the extension, and generate a CSV file which serves as a key
# connecting the original filename to the new, randomly-generated filename.

my $folder = $ARGV[0];

if ($folder == '') {
	print "You must supply a folder name.  I will randomly rename all files in that foldername, and create a key file in .CSV format in that folder.\n";
	exit 1;
}

if (! -e $folder || ! -d $folder) {
	print "$folder is not a valid, existing folder.  Try again - typo maybe?\n";
	exit 2;
}

if (-e "$folder/keyfile.csv") {
	print "$folder/keyfile.csv already exists.  Have you already randomized that folder?\n";
	exit 3;
}

open FH, "> $folder/keyfile.csv";

foreach my $file (<$folder/*>) {
	print $file;
}

close FH;

exit 0;
