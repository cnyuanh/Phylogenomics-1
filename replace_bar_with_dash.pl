#!/usr/bin/perl -w
use strict;
 #replace_bar_with_dash.pl
my $infile= $ARGV[0] || die "need input file\n";
open IN, "<$infile";
while(<IN>) {
	chomp;
	s/\|/_/g;
	s/:/_/g;
	s/\(/_/g;
	s/\)/_/g;
	s/\//_/g;
	print "$_\n";
}
close IN;
