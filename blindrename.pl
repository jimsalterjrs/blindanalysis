#!/usr/bin/perl

# take a foldername as an argument.
#
# for each file in [foldername], rename it to a randomly-generated filename preserving the extension, and generate a CSV file which serves as a key
# connecting the original filename to the new, randomly-generated filename.

my $folder = $ARGV[0];

if ($folder eq '') {
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

open FH, "> $folder/keyfile.csv" or die "could not open $folder/keyfile.csv for writing!\n";
print FH '"Original Filename","Cloaked Filename"' . "\n";

my @chars=("A"..."Z","a"..."z","0"..."9");

foreach my $file (<$folder/*>) {
	chomp $file;
	my ($oldname) = $file =~ /^$folder\/(.*)$/;
	# don't mess with keyfile.csv itself, and don't mess with directories
	if ($oldname ne 'keyfile.csv' && ! -d $file) {
		# separate extension from basename. be sure you handle bare basenames (no extension) properly if necessary
		my ($ext) = $oldname =~ /^.*(\..*)$/;
		my ($base) = $oldname =~ /^(.*)($ext)?$/;

		# generate a random new basename - 5 alphanumerics. ensure there are no collisions.
		my $cloaked = $folder;
		while (-e $cloaked) {
			$cloaked = '';
			for (1..5) { $cloaked .= $chars[int rand scalar @chars]; }
		}

		my $cloakedname = "$cloaked$ext";

		# first log rename operation, THEN perform it
		print FH "\"$oldname\",\"$cloakedname\"\n";
		rename "$folder/$oldname","$folder/$cloakedname" or die "Could not rename $folder/$oldname to $folder/$cloakedname - you may have a partial operation, check $folder/keyfile.csv to see details!\n";
	}
}

close FH;

exit 0;
