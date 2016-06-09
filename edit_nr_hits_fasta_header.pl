#!/usr/bin/perl -w
use strict;
#edit_nr_hits_fasta_header.pl
my $infile = $ARGV[0] || die "need the input NR fasta file\n";
open IN, "<$infile";
while(<IN>) {
	chomp;
	my $taxa = "";
	my $good_taxa="";
	my $gi = "";
	my $header= "";
	my $line = $_;
	if(/^>(\S+)/) {
		$gi = $1;
		$gi =~ s/\|/_/g;
		my @F=split(/\[/,$line);
		#print "$F[1]\n";
		$taxa = $F[1];
		#print "$taxa\n";
		my @M=split(/\]/,$taxa);
		$good_taxa = "$M[0]";
		$good_taxa =~ s/\s+/_/g;
		#print "$good_taxa\n";
		$header= $good_taxa."_".$gi;
		$header =~ s/_$//;
		print ">$header\n";
	}
	else {
		print "$_\n";
	}

}
close IN;
