#!/usr/bin/perl

# take a foldername as an argument.
#
# for each file in [foldername], rename it to a randomly-generated filename preserving the extension, and generate a CSV file which serves as a key
# connecting the original filename to the new, randomly-generated filename.

my $folder = $ARGV[0];

# refuse to run as root, for safety reasons.  not sure if this will cause problems on Windows implementations - if so, you can comment the whole block out.
if ( $> == 0 ) { 
	print "For safety reasons, you must NOT be root when running blindrename.pl.  Please become a non-root user, make sure that user has permissions to write to all files in $folder, and try again.\n";
	exit 4;
}

# die now if user didn't supply a folder name.
if ($folder eq '') {
	print "You must supply a folder name.  I will randomly rename all files in that foldername, and create a key file in .CSV format in that folder.\n";
	exit 1;
}

# die now if user didn't provide a *valid* folder name.
if (! -e $folder || ! -d $folder) {
	print "$folder is not a valid, existing folder.  Try again - typo maybe?\n";
	exit 2;
}

# don't blindrename the same folder twice!
if (-e "$folder/keyfile.csv") {
	print "$folder/keyfile.csv already exists.  Have you already randomized that folder?\n";
	exit 3;
}

# open keyfile.csv and write header column before doing anything else.
open FH, "> $folder/keyfile.csv" or die "could not open $folder/keyfile.csv for writing!\n";
print FH '"Original Filename","Cloaked Filename"' . "\n";

# possible characters for cloaked filenames, and how many characters long the cloaked name should be.
my @chars=("A"..."Z","a"..."z","0"..."9");
my $cloaklength = 5;

print "Renaming: ";
my $counter = 0;

foreach my $file (<$folder/*>) {
	chomp $file;
	my ($oldname) = $file =~ /^$folder\/(.*)$/;
	# don't mess with keyfile.csv itself, and don't mess with directories or dotfiles
	if ($oldname ne 'keyfile.csv' && ! -d $file ) {
		# separate extension from basename. be sure you handle bare basenames (no extension) properly if necessary
		my ($ext) = $oldname =~ /^.*(\..*)$/;
		my ($base) = $oldname =~ /^(.*)($ext)?$/;

		# generate a random new basename - and ensure there won't be a collision before doing anything with it.
		my $cloaked = '';
		while (-e "$folder/$cloaked$ext" || ($cloaked eq '') ) {
			$cloaked = '';
			for (1..$cloaklength) { $cloaked .= $chars[int rand scalar @chars]; }
		}

		my $cloakedname = "$cloaked$ext";

		# first log rename operation, THEN perform it
		print FH "\"$oldname\",\"$cloakedname\"\n";
		print "$oldname... ";
		rename "$folder/$oldname","$folder/$cloakedname" or die "Could not rename $folder/$oldname to $folder/$cloakedname - you may have a partial operation, check $folder/keyfile.csv to see details!\n";
		$counter ++;
	}
}

print "\n";
print "$counter files successfully blind renamed; keyfile saved to $folder/keyfile.csv.\n";

close FH;

exit 0;
