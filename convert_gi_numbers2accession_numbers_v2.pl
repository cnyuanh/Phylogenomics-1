#!/usr/bin/perl -w
use strict;
#convert_gi_numbers2accession_numbers.pl

#the script is to convert gi number and print the corresponding accession number by tab
use LWP::Simple;
my @GI_array ;
my $infile = $ARGV[0] || die "need the input gi file\n";

open IN, "<$infile";
while(<IN>) {
	chomp;
	push @GI_array, $_;
}
close IN; 

my $base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';

foreach(@GI_array) {
	my $gi = $_;
	my $url = $base . "efetch.fcgi?db=protein&id=$gi&rettype=acc";
	my $accn =  get($url);

	chomp $accn;
	print "$gi\t$accn";

}
