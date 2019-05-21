#! /usr/bin/perl

use warnings 'all';
use strict;

my $fixes = "FIX.csv";
my $site = "dtw_52_190510_SYS1.st";

open(my $fh, '<', $fixes) or die("Can't open '$fixes': $!");
my @fixarr = <$fh>;
close($fh);

open(my $sfh, '<', $site) or die("Can't open '$site': $!");

while (my $line = <$sfh>) {
    if ($line =~ /^PT/) {
        my @point = $line =~ /^PT ([A-Z0-9]+) ([NS]\d+ \d+ \d+) ([EW]\d+ \d+ \d+)/;
        my $found = 0;

        foreach my $fix (@fixarr) {
            chomp($fix);
            my @fix_data = ($fix =~ /([A-Z0-9]+),([NS]\d+ \d+ \d+),([EW]\d+ \d+ \d+),.*/);
            # if (@fix_data) {
                if ($fix_data[0] eq $point[0]) {
                    $found = 1;
                    if ($point[1] eq $fix_data[1] and $point[2] eq $fix_data[2]) {
                        last;
                    }
                    else {
                        print "FIX '$point[0]' IN NASR BUT DIFFERENT COORDINATE\n";
                        print "ST: $point[1] $point[2]\n";
                        print "NASR: $fix_data[1] $fix_data[2]\n";
                        last;
                    # }
                }
            }
        }
        if ($found == 0) {
            print "FIX '$point[0]' NOT IN NASR\n";
        }
    }
}
